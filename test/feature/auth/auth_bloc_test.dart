import 'package:flutter_test/flutter_test.dart';
import 'package:quizzerg/feature/auth/data/dto/auth_dto.dart';
import 'package:quizzerg/feature/auth/data/repository/auth_status_repository.dart';
import 'package:quizzerg/feature/auth/domain/bloc/auth_bloc.dart';
import 'package:quizzerg/feature/auth/domain/entity/auth_status.dart';
import 'package:quizzerg/feature/auth/domain/entity/auth_token_pair.dart';
import 'package:quizzerg/feature/auth/domain/entity/auth_user_entity.dart';
import 'package:quizzerg/feature/auth/domain/repository/i_auth_api_repository.dart';
import 'package:quizzerg/feature/profile/data/dto/user_dto.dart';
import 'package:quizzerg/feature/profile/domain/repository/i_profile_api_repository.dart';
import 'package:quizzerg/network/error/api_exception.dart';

import 'auth_fakes.dart';

final _userDto = UserDto(
  id: 'user-1',
  email: 'a@b.c',
  plan: 'free',
  displayName: 'Артём',
  createdAt: DateTime.utc(2026),
  updatedAt: DateTime.utc(2026),
);

const _cachedUser = AuthUserEntity(
  id: 'user-1',
  email: 'a@b.c',
  plan: 'free',
  displayName: 'Кеш',
);

void main() {
  late _FakeAuthApi api;
  late _FakeProfileApi profileApi;
  late FakeAuthTokenStorage tokenStorage;
  late AuthStatusRepository authStatus;
  late FakeAuthUserStorage userStorage;
  late FakeGoogleSignInService google;

  AuthBloc build() => AuthBloc(
        api: api,
        profileApi: profileApi,
        authStatus: authStatus,
        userStorage: userStorage,
        googleSignIn: google,
        errorLogger: const SilentErrorLogger(),
      );

  setUp(() {
    api = _FakeAuthApi();
    profileApi = _FakeProfileApi();
    tokenStorage = FakeAuthTokenStorage();
    authStatus = AuthStatusRepository(storage: tokenStorage);
    userStorage = FakeAuthUserStorage();
    google = FakeGoogleSignInService();
  });

  tearDown(() => authStatus.close());

  group('AuthBloc.started', () {
    test('пустое хранилище — гость', () async {
      final bloc = build();
      final states = <AuthState>[];
      final subscription = bloc.stream.listen(states.add);

      bloc.add(const AuthEvent.started());
      await pumpEventQueue();

      expect(states, [const AuthState.unauthorized()]);
      await subscription.cancel();
      await bloc.close();
    });

    test('есть токены — профиль из кеша, затем из /me', () async {
      tokenStorage.pair = const AuthTokenPair(
        accessToken: 'a',
        refreshToken: 'r',
      );
      userStorage.user = _cachedUser;

      final bloc = build();
      final states = <AuthState>[];
      final subscription = bloc.stream.listen(states.add);

      bloc.add(const AuthEvent.started());
      await pumpEventQueue();

      expect(states.first, const AuthState.authorized(user: _cachedUser));
      expect(states.last.user?.displayName, 'Артём');
      expect(userStorage.user?.displayName, 'Артём');
      await subscription.cancel();
      await bloc.close();
    });

    test('офлайн на старте не роняет сессию', () async {
      tokenStorage.pair = const AuthTokenPair(
        accessToken: 'a',
        refreshToken: 'r',
      );
      userStorage.user = _cachedUser;
      profileApi.error = const NetworkUnavailable();

      final bloc = build()..add(const AuthEvent.started());
      await pumpEventQueue();

      expect(bloc.state, const AuthState.authorized(user: _cachedUser));
      await bloc.close();
    });
  });

  group('AuthBloc.expired', () {
    test('статус expired из репозитория переводит блок в expired', () async {
      tokenStorage.pair = const AuthTokenPair(
        accessToken: 'a',
        refreshToken: 'r',
      );
      userStorage.user = _cachedUser;

      final bloc = build()..add(const AuthEvent.started());
      await pumpEventQueue();

      await authStatus.markExpired();
      await pumpEventQueue();

      expect(bloc.state.isExpired, isTrue);
      expect(bloc.state.user?.email, 'a@b.c');
      await bloc.close();
    });

    test('у гостя сессия истечь не может', () async {
      final bloc = build()..add(const AuthEvent.started());
      await pumpEventQueue();

      await authStatus.markExpired();
      await pumpEventQueue();

      expect(bloc.state, const AuthState.unauthorized());
      expect(authStatus.status, AuthStatus.unauthorized);
      await bloc.close();
    });
  });

  group('AuthBloc.signIn', () {
    test('успешный вход сохраняет пару и профиль', () async {
      final bloc = build()..add(const AuthEvent.started());
      await pumpEventQueue();

      bloc.add(const AuthEvent.signInRequested());
      await pumpEventQueue();

      expect(bloc.state.isAuthorized, isTrue);
      expect(tokenStorage.pair?.accessToken, 'fresh-access');
      expect(google.nonces, ['nonce-1']);
      expect(bloc.state.user?.displayName, 'Артём');
      await bloc.close();
    });

    test('401 auth.invalid_nonce — ровно один повтор цепочки', () async {
      // Nonce одноразовый и живёт в памяти инстанса: рестарт сервера или
      // «застрял на гугловом экране» — штатные сценарии.
      api.googleErrors = [
        const AuthInvalidNonce(code: 'auth.invalid_nonce', statusCode: 401),
      ];

      final bloc = build()..add(const AuthEvent.started());
      await pumpEventQueue();

      bloc.add(const AuthEvent.signInRequested());
      await pumpEventQueue();

      expect(bloc.state.isAuthorized, isTrue);
      expect(api.nonceCalls, 2);
      expect(api.googleCalls, 2);
      await bloc.close();
    });

    test('второй invalid_nonce подряд — ошибка пользователю', () async {
      // Больше одного повтора нельзя: лимит /auth/* считается по IP,
      // и автоцикл съест 20 запросов в минуту на всех за общим NAT.
      api.googleErrors = [
        const AuthInvalidNonce(code: 'auth.invalid_nonce', statusCode: 401),
        const AuthInvalidNonce(code: 'auth.invalid_nonce', statusCode: 401),
      ];

      final bloc = build()..add(const AuthEvent.started());
      await pumpEventQueue();

      bloc.add(const AuthEvent.signInRequested());
      await pumpEventQueue();

      expect(bloc.state, isA<AuthState$Unauthorized>());
      expect((bloc.state as AuthState$Unauthorized).error,
          isA<AuthInvalidNonce>());
      expect(api.googleCalls, 2);
      await bloc.close();
    });

    test('401 auth.invalid_token не ретраится', () async {
      // Это баг конфигурации (audience/issuer) или подделка — повторять
      // бессмысленно.
      api.googleErrors = [
        const AuthInvalidToken(code: 'auth.invalid_token', statusCode: 401),
      ];

      final bloc = build()..add(const AuthEvent.started());
      await pumpEventQueue();

      bloc.add(const AuthEvent.signInRequested());
      await pumpEventQueue();

      expect(bloc.state, isA<AuthState$Unauthorized>());
      expect(api.googleCalls, 1);
      expect(api.nonceCalls, 1);
      await bloc.close();
    });

    test('заглушка Google даёт ошибку, а не падение', () async {
      google.error = UnimplementedError('нет реализации');

      final bloc = build()..add(const AuthEvent.started());
      await pumpEventQueue();

      bloc.add(const AuthEvent.signInRequested());
      await pumpEventQueue();

      expect(bloc.state, isA<AuthState$Unauthorized>());
      expect((bloc.state as AuthState$Unauthorized).error, isNotNull);
      await bloc.close();
    });
  });

  group('AuthBloc.signOut', () {
    test('чистит токены и кеш в любом исходе', () async {
      tokenStorage.pair = const AuthTokenPair(
        accessToken: 'a',
        refreshToken: 'r',
      );
      userStorage.user = _cachedUser;
      // Сети нет — разлогиниваемся локально и забываем.
      api.logoutError = const NetworkUnavailable();

      final bloc = build()..add(const AuthEvent.started());
      await pumpEventQueue();

      bloc.add(const AuthEvent.signOutRequested());
      await pumpEventQueue();

      expect(bloc.state, const AuthState.unauthorized());
      expect(tokenStorage.pair, isNull);
      expect(userStorage.user, isNull);
      expect(api.logoutCalls, 1);
      expect(google.signOutCalls, 1);
      await bloc.close();
    });
  });
}

class _FakeAuthApi implements IAuthApiRepository {
  int nonceCalls = 0;
  int googleCalls = 0;
  int logoutCalls = 0;

  /// Ошибки `/auth/google` по порядку вызовов.
  List<Exception> googleErrors = [];
  Exception? logoutError;

  @override
  Future<String> nonce() async {
    nonceCalls++;

    return 'nonce-$nonceCalls';
  }

  @override
  Future<TokenPairDto> google(String idToken) async {
    googleCalls++;
    if (googleErrors.isNotEmpty) throw googleErrors.removeAt(0);

    return const TokenPairDto(
      accessToken: 'fresh-access',
      refreshToken: 'fresh-refresh',
    );
  }

  @override
  Future<TokenPairDto> refresh(String refresh) async => throw StateError('n/a');

  @override
  Future<void> logout(String refresh) async {
    logoutCalls++;
    final error = logoutError;
    if (error != null) throw error;
  }
}

class _FakeProfileApi implements IProfileApiRepository {
  ApiException? error;

  @override
  Future<UserDto> getMe() async {
    final failure = error;
    if (failure != null) throw failure;

    return _userDto;
  }

  @override
  Future<UserDto> updateMe(UpdateMeDto body) async => _userDto;

  @override
  Future<void> deleteMe() async {}
}
