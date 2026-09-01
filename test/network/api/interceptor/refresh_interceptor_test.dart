import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quizzerg/network/api/auth_token_provider.dart';
import 'package:quizzerg/network/api/interceptor/auth_interceptor.dart';
import 'package:quizzerg/network/api/interceptor/refresh_interceptor.dart';

import 'scripted_adapter.dart';

/// Провайдер токена с управляемым refresh.
class _FakeTokenProvider implements IAuthTokenProvider {
  String? token;
  bool refreshSucceeds;
  int refreshCalls = 0;
  int sessionExpiredCalls = 0;

  /// Задержка внутри refresh — нужна, чтобы поймать гонку двух 401.
  static const refreshDelay = Duration(milliseconds: 20);

  _FakeTokenProvider({this.refreshSucceeds = true}) : token = 'stale';

  @override
  Future<String?> accessToken() async => token;

  @override
  Future<bool> refreshTokens() async {
    refreshCalls++;
    await Future<void>.delayed(refreshDelay);
    if (refreshSucceeds) token = 'fresh';

    return refreshSucceeds;
  }

  @override
  Future<void> onSessionExpired() async {
    sessionExpiredCalls++;
    token = null;
  }
}

Dio _dio(ScriptedAdapter adapter, _FakeTokenProvider provider) {
  final dio = Dio(BaseOptions(baseUrl: 'https://example.test/v1'))
    ..httpClientAdapter = adapter;
  dio.interceptors.addAll([
    AuthInterceptor(tokenProvider: provider),
    RefreshInterceptor(tokenProvider: provider, dio: dio),
  ]);

  return dio;
}

void main() {
  group('RefreshInterceptor', () {
    test('на 401 обновляет токен и повторяет запрос', () async {
      final provider = _FakeTokenProvider();
      final adapter = ScriptedAdapter([
        const ScriptedResponse(401, {'code': 'auth.invalid_token'}),
        const ScriptedResponse(200, {'ok': true}),
      ]);

      final response = await _dio(adapter, provider).get<Object?>('/me');

      expect(response.statusCode, 200);
      expect(provider.refreshCalls, 1);
      expect(adapter.requests.length, 2);
      expect(
        adapter.requests.last.headers['Authorization'],
        'Bearer fresh',
      );
    });

    test('два параллельных 401 обновляют токен один раз', () async {
      final provider = _FakeTokenProvider();
      final adapter = ScriptedAdapter([
        const ScriptedResponse(401, {'code': 'auth.invalid_token'}),
        const ScriptedResponse(401, {'code': 'auth.invalid_token'}),
        const ScriptedResponse(200, {'ok': true}),
        const ScriptedResponse(200, {'ok': true}),
      ]);
      final dio = _dio(adapter, provider);

      await Future.wait([
        dio.get<Object?>('/me'),
        dio.get<Object?>('/tests'),
      ]);

      expect(provider.refreshCalls, 1);
    });

    test('провал refresh — сессия истекла, ретрая нет', () async {
      final provider = _FakeTokenProvider(refreshSucceeds: false);
      final adapter = ScriptedAdapter([
        const ScriptedResponse(401, {'code': 'auth.invalid_token'}),
      ]);

      await expectLater(
        _dio(adapter, provider).get<Object?>('/me'),
        throwsA(isA<DioException>()),
      );
      expect(provider.sessionExpiredCalls, 1);
      expect(adapter.requests.length, 1);
    });

    test('повторный 401 после обновления не зацикливается', () async {
      final provider = _FakeTokenProvider();
      final adapter = ScriptedAdapter([
        const ScriptedResponse(401, {'code': 'auth.invalid_token'}),
        const ScriptedResponse(401, {'code': 'auth.invalid_token'}),
      ]);

      await expectLater(
        _dio(adapter, provider).get<Object?>('/me'),
        throwsA(isA<DioException>()),
      );
      expect(adapter.requests.length, 2);
      expect(provider.refreshCalls, 1);
    });

    test('публичные пути идут без Authorization', () async {
      final provider = _FakeTokenProvider();
      final adapter = ScriptedAdapter([const ScriptedResponse(200)]);

      await _dio(adapter, provider).get<Object?>('/health');

      expect(adapter.requests.single.headers.containsKey('Authorization'),
          isFalse);
    });
  });
}
