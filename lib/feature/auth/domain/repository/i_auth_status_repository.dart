import 'package:quizzerg/feature/auth/domain/entity/auth_status.dart';
import 'package:quizzerg/feature/auth/domain/entity/auth_token_pair.dart';

/// Владелец сессии: токены и её статус.
///
/// Единственный источник правды о том, авторизован ли пользователь.
/// Подписчиков двое и они друг о друге не знают — `AuthBloc` (рисует UI
/// и ведёт вход) и `SyncBloc` (решает, запускать прогоны). Раньше второй
/// получал `authBloc.stream`, отмапленный в DI, то есть блок зависел
/// от выхода другого блока.
abstract interface class IAuthStatusRepository {
  /// Текущий статус.
  AuthStatus get status;

  /// Поток статусов. Реплеит текущий, поэтому подписка не опаздывает.
  Stream<AuthStatus> get statusChanges;

  /// Текущая пара токенов. Нужна транспорту и выходу из аккаунта.
  Future<AuthTokenPair?> tokens();

  /// Прочитать хранилище и определить статус. Зовётся один раз на старте.
  Future<void> restore();

  /// Записать пару и считать сессию действующей.
  ///
  /// Запись атомарна: после ротации старый refresh мёртв сразу, и потеря
  /// нового означает разлогин на всех устройствах.
  Future<void> saveTokens(AuthTokenPair pair);

  /// Забыть сессию: выход из аккаунта.
  Future<void> clear();

  /// Сессия истекла: токены чистим, но это не выход — UI показывает
  /// «войдите заново», а локальные данные остаются на месте.
  Future<void> markExpired();
}
