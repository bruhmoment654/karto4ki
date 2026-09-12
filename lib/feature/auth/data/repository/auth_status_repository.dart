import 'package:quizzerg/feature/auth/data/storage/i_auth_token_storage.dart';
import 'package:quizzerg/feature/auth/domain/entity/auth_status.dart';
import 'package:quizzerg/feature/auth/domain/entity/auth_token_pair.dart';
import 'package:quizzerg/feature/auth/domain/repository/i_auth_status_repository.dart';
import 'package:rxdart/rxdart.dart';

/// Реализация [IAuthStatusRepository] поверх защищённого хранилища.
///
/// Статус отдаётся через [BehaviorSubject], засеянный `unknown`: подписчик
/// получает текущее значение сразу, даже если подписался позже старта.
/// Одинаковый статус подряд не эмитится — ротация токенов не должна
/// выглядеть как повторный вход.
class AuthStatusRepository implements IAuthStatusRepository {
  final IAuthTokenStorage _storage;
  final BehaviorSubject<AuthStatus> _status =
      BehaviorSubject<AuthStatus>.seeded(AuthStatus.unknown);

  AuthStatusRepository({required IAuthTokenStorage storage})
      : _storage = storage;

  @override
  AuthStatus get status => _status.value;

  @override
  Stream<AuthStatus> get statusChanges => _status.stream;

  @override
  Future<AuthTokenPair?> tokens() => _storage.read();

  @override
  Future<void> restore() async {
    final pair = await _storage.read();
    _emit(pair == null ? AuthStatus.unauthorized : AuthStatus.authorized);
  }

  @override
  Future<void> saveTokens(AuthTokenPair pair) async {
    await _storage.write(pair);
    _emit(AuthStatus.authorized);
  }

  @override
  Future<void> clear() async {
    await _storage.clear();
    _emit(AuthStatus.unauthorized);
  }

  /// «Истекла» бывает только у существовавшей сессии: без токенов
  /// пользователь просто гость, и показывать ему «войдите заново» нечего.
  @override
  Future<void> markExpired() async {
    final hadSession = _status.value == AuthStatus.authorized;
    await _storage.clear();
    _emit(hadSession ? AuthStatus.expired : AuthStatus.unauthorized);
  }

  Future<void> close() => _status.close();

  void _emit(AuthStatus next) {
    if (_status.isClosed || _status.value == next) return;

    _status.add(next);
  }
}
