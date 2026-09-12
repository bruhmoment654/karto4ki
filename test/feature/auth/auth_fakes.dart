import 'package:quizzerg/core/logger/error_logger.dart';
import 'package:quizzerg/feature/auth/data/service/i_google_sign_in_service.dart';
import 'package:quizzerg/feature/auth/data/storage/i_auth_token_storage.dart';
import 'package:quizzerg/feature/auth/data/storage/i_auth_user_storage.dart';
import 'package:quizzerg/feature/auth/domain/entity/auth_token_pair.dart';
import 'package:quizzerg/feature/auth/domain/entity/auth_user_entity.dart';

/// Логгер, который молчит: в тестах стектрейсы только мешают.
class SilentErrorLogger implements ErrorLogger {
  const SilentErrorLogger();

  @override
  void logError(Object error, StackTrace stackTrace) {}
}

/// Хранилище токенов в памяти со счётчиком записей.
class FakeAuthTokenStorage implements IAuthTokenStorage {
  AuthTokenPair? pair;
  int writes = 0;

  FakeAuthTokenStorage([this.pair]);

  @override
  Future<AuthTokenPair?> read() async => pair;

  @override
  Future<void> write(AuthTokenPair value) async {
    writes++;
    pair = value;
  }

  @override
  Future<void> clear() async => pair = null;
}

/// Кеш профиля в памяти.
class FakeAuthUserStorage implements IAuthUserStorage {
  AuthUserEntity? user;

  FakeAuthUserStorage([this.user]);

  @override
  AuthUserEntity? get() => user;

  @override
  Future<void> save(AuthUserEntity value) async => user = value;

  @override
  Future<void> clear() async => user = null;
}

/// Google-сервис с управляемым результатом.
class FakeGoogleSignInService implements IGoogleSignInService {
  String token = 'id-token';

  /// Ошибка, которую бросает сервис. `UnimplementedError` — ровно то, что
  /// делает заглушка, пока реализации входа нет.
  Object? error;
  int calls = 0;
  int signOutCalls = 0;
  final List<String> nonces = [];

  @override
  Future<String> idToken({required String nonce}) async {
    calls++;
    nonces.add(nonce);
    final failure = error;
    if (failure != null) Error.throwWithStackTrace(failure, StackTrace.current);

    return token;
  }

  @override
  Future<void> signOut() async => signOutCalls++;
}
