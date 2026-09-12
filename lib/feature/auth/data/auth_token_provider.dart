import 'package:quizzerg/core/logger/error_logger.dart';
import 'package:quizzerg/feature/auth/data/dto/auth_dto.dart';
import 'package:quizzerg/feature/auth/domain/entity/auth_token_pair.dart';
import 'package:quizzerg/feature/auth/domain/repository/i_auth_api_repository.dart';
import 'package:quizzerg/feature/auth/domain/repository/i_auth_status_repository.dart';
import 'package:quizzerg/network/api/auth_token_provider.dart';
import 'package:quizzerg/network/error/api_exception.dart';

/// Источник токена для транспорта.
///
/// Состояние сессии не держит: и токены, и статус живут в
/// [IAuthStatusRepository], туда же уходит признак «сессия истекла».
/// Отдельного стрима у провайдера нет — иначе было бы два источника
/// правды об одном и том же.
///
/// Зависимость от `ApiClient` циклическая (Dio требует провайдер, провайдер
/// требует клиент для `/auth/refresh`), поэтому репозиторий `/auth/*`
/// приезжает setter-инъекцией через [attach].
class AuthTokenProvider implements IAuthTokenProvider {
  final IAuthStatusRepository _authStatus;
  final ErrorLogger _errorLogger;

  IAuthApiRepository? _api;

  AuthTokenProvider({
    required IAuthStatusRepository authStatus,
    required ErrorLogger errorLogger,
  })  : _authStatus = authStatus,
        _errorLogger = errorLogger;

  /// Досоздание зависимости, разрывающее цикл в DI.
  void attach(IAuthApiRepository api) => _api = api;

  @override
  Future<String?> accessToken() async =>
      (await _authStatus.tokens())?.accessToken;

  /// Обновляет пару токенов.
  ///
  /// Терминальны **оба** ответа бэкенда, и оба дают `false`:
  /// - `401 auth.invalid_token` — refresh неизвестен, отозван или истёк;
  /// - `409 resource.conflict` — refresh уже ротирован (reuse-detection),
  ///   сервер при этом отзывает всю цепочку токенов пользователя.
  ///
  /// Второй важен отдельно: по общему правилу проекта 409 значит
  /// «конфликт, разберись и повтори», а здесь это разлогин.
  ///
  /// Сетевая ошибка терминальной не считается и уходит наружу: сессия
  /// в порядке, просто сейчас нет связи.
  @override
  Future<bool> refreshTokens() async {
    final refresh = (await _authStatus.tokens())?.refreshToken;
    if (refresh == null) return false;

    final api = _api;
    if (api == null) return false;

    try {
      await _save(await api.refresh(refresh));

      return true;
    } on AuthInvalidToken catch (error, stackTrace) {
      _errorLogger.logError(error, stackTrace);

      return false;
    } on AuthMissingToken catch (error, stackTrace) {
      _errorLogger.logError(error, stackTrace);

      return false;
    } on ApiConflict catch (error, stackTrace) {
      _errorLogger.logError(error, stackTrace);

      return false;
    }
  }

  /// Локальные данные не трогаем — ни БД, ни курсор синхронизации.
  @override
  Future<void> onSessionExpired() => _authStatus.markExpired();

  Future<void> _save(TokenPairDto pair) => _authStatus.saveTokens(
        AuthTokenPair(
          accessToken: pair.accessToken,
          refreshToken: pair.refreshToken,
        ),
      );
}
