import 'package:flutter_test/flutter_test.dart';
import 'package:quizzerg/feature/auth/data/auth_token_provider.dart';
import 'package:quizzerg/feature/auth/data/dto/auth_dto.dart';
import 'package:quizzerg/feature/auth/data/repository/auth_status_repository.dart';
import 'package:quizzerg/feature/auth/domain/entity/auth_status.dart';
import 'package:quizzerg/feature/auth/domain/entity/auth_token_pair.dart';
import 'package:quizzerg/feature/auth/domain/repository/i_auth_api_repository.dart';
import 'package:quizzerg/network/error/api_exception.dart';

import 'auth_fakes.dart';

void main() {
  late FakeAuthTokenStorage storage;
  late AuthStatusRepository authStatus;
  late FakeAuthApi api;
  late AuthTokenProvider provider;

  setUp(() async {
    storage = FakeAuthTokenStorage(
      const AuthTokenPair(accessToken: 'old-access', refreshToken: 'old-refresh'),
    );
    // Настоящий репозиторий поверх фейкового хранилища: провайдер больше
    // не владеет сессией, и проверять надо именно их связку.
    authStatus = AuthStatusRepository(storage: storage);
    await authStatus.restore();
    api = FakeAuthApi();
    provider = AuthTokenProvider(
      authStatus: authStatus,
      errorLogger: const SilentErrorLogger(),
    )..attach(api);
  });

  tearDown(() => authStatus.close());

  group('AuthTokenProvider', () {
    test('accessToken читается из хранилища', () async {
      expect(await provider.accessToken(), 'old-access');
    });

    test('успешный refresh пишет пару целиком', () async {
      api.refreshResult = const TokenPairDto(
        accessToken: 'new-access',
        refreshToken: 'new-refresh',
      );

      expect(await provider.refreshTokens(), isTrue);
      // Пара пишется одним значением: половину потерять нельзя.
      expect(storage.writes, 1);
      expect(storage.pair?.accessToken, 'new-access');
      expect(storage.pair?.refreshToken, 'new-refresh');
    });

    test('401 auth.invalid_token — терминально, false', () async {
      api.refreshError = const AuthInvalidToken(
        code: 'auth.invalid_token',
        statusCode: 401,
      );

      expect(await provider.refreshTokens(), isFalse);
      // Токены чистит onSessionExpired, а не сам refresh.
      expect(storage.pair, isNotNull);
    });

    test('409 resource.conflict (reuse) — тоже терминально, false', () async {
      api.refreshError = const ApiConflict(
        code: 'resource.conflict',
        statusCode: 409,
        message: 'Refresh token already used',
      );

      expect(await provider.refreshTokens(), isFalse);
    });

    test('сетевая ошибка не терминальна и уходит наружу', () async {
      // Сессия в порядке — просто нет связи. Молча вернуть false нельзя:
      // RefreshInterceptor счёл бы это «сессия истекла» и разлогинил.
      api.refreshError = const NetworkUnavailable();

      await expectLater(
        provider.refreshTokens(),
        throwsA(isA<NetworkUnavailable>()),
      );
      expect(storage.pair, isNotNull);
    });

    test('без refresh-токена обновлять нечего', () async {
      await storage.clear();

      expect(await provider.refreshTokens(), isFalse);
      expect(api.refreshCalls, 0);
    });

    test('onSessionExpired чистит токены и переводит статус в expired',
        () async {
      final statuses = <AuthStatus>[];
      final subscription = authStatus.statusChanges.listen(statuses.add);

      await provider.onSessionExpired();
      await pumpEventQueue();

      expect(storage.pair, isNull);
      expect(authStatus.status, AuthStatus.expired);
      expect(statuses.last, AuthStatus.expired);
      await subscription.cancel();
    });

    test('успешный refresh статус не переключает', () async {
      // Ротация токенов — не повторный вход: лишний authorized заставил бы
      // подписчиков (в том числе синхронизацию) думать, что сессия новая.
      final statuses = <AuthStatus>[];
      final subscription = authStatus.statusChanges.skip(1).listen(statuses.add);

      await provider.refreshTokens();
      await pumpEventQueue();

      expect(authStatus.status, AuthStatus.authorized);
      expect(statuses, isEmpty);
      await subscription.cancel();
    });
  });
}

/// Репозиторий `/auth/*` с управляемыми ответами.
class FakeAuthApi implements IAuthApiRepository {
  TokenPairDto refreshResult = const TokenPairDto(
    accessToken: 'new-access',
    refreshToken: 'new-refresh',
  );
  ApiException? refreshError;
  int refreshCalls = 0;

  @override
  Future<TokenPairDto> refresh(String refresh) async {
    refreshCalls++;
    final error = refreshError;
    if (error != null) throw error;

    return refreshResult;
  }

  @override
  Future<String> nonce() async => 'nonce';

  @override
  Future<TokenPairDto> google(String idToken) async => refreshResult;

  @override
  Future<void> logout(String refresh) async {}
}
