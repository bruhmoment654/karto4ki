import 'dart:math';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quizzerg/network/api/interceptor/retry_interceptor.dart';

import 'scripted_adapter.dart';

Dio _dio(ScriptedAdapter adapter, {int maxRetries = 3}) {
  final dio = Dio(BaseOptions(baseUrl: 'https://example.test/v1'))
    ..httpClientAdapter = adapter;
  dio.interceptors.add(
    RetryInterceptor(
      dio: dio,
      maxRetries: maxRetries,
      baseDelay: const Duration(milliseconds: 1),
      random: Random(7),
    ),
  );

  return dio;
}

/// Адаптер, который всегда падает без ответа — «сеть пропала».
class _OfflineAdapter implements HttpClientAdapter {
  int calls = 0;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) {
    calls++;

    throw DioException.connectionError(
      requestOptions: options,
      reason: 'offline',
    );
  }

  @override
  void close({bool force = false}) {}
}

Dio _dioWith(HttpClientAdapter adapter, {int maxRetries = 3}) {
  final dio = Dio(BaseOptions(baseUrl: 'https://example.test/v1'))
    ..httpClientAdapter = adapter;
  dio.interceptors.add(
    RetryInterceptor(
      dio: dio,
      maxRetries: maxRetries,
      baseDelay: const Duration(milliseconds: 1),
      random: Random(7),
    ),
  );

  return dio;
}

void main() {
  group('RetryInterceptor', () {
    test('5xx повторяется заданное число раз и падает', () async {
      final adapter = ScriptedAdapter([])
        ..fallback = const ScriptedResponse(500, {'code': 'server.internal'});

      await expectLater(
        _dio(adapter).get<Object?>('/tests'),
        throwsA(isA<DioException>()),
      );
      // Исходный запрос плюс три повтора.
      expect(adapter.requests.length, 4);
    });

    test('успех после временной ошибки', () async {
      final adapter = ScriptedAdapter([
        const ScriptedResponse(503, {'code': 'server.unavailable'}),
        const ScriptedResponse(200, {'ok': true}),
      ]);

      final response = await _dio(adapter).get<Object?>('/tests');

      expect(response.statusCode, 200);
      expect(adapter.requests.length, 2);
    });

    test('429 повторяется', () async {
      final adapter = ScriptedAdapter([
        const ScriptedResponse(429, {'code': 'rate_limit.exceeded'}),
        const ScriptedResponse(200, {'ok': true}),
      ]);

      final response = await _dio(adapter).get<Object?>('/tests');

      expect(response.statusCode, 200);
      expect(adapter.requests.length, 2);
    });

    test('4xx не повторяется', () async {
      final adapter = ScriptedAdapter([])
        ..fallback =
            const ScriptedResponse(400, {'code': 'validation.invalid_field'});

      await expectLater(
        _dio(adapter).get<Object?>('/tests'),
        throwsA(isA<DioException>()),
      );
      expect(adapter.requests.length, 1);
    });

    test('неидемпотентный POST не повторяется', () async {
      final adapter = ScriptedAdapter([])
        ..fallback = const ScriptedResponse(500, {'code': 'server.internal'});

      await expectLater(
        _dio(adapter)
            .post<Object?>('/sync/push', data: {'changes': <Object>[]}),
        throwsA(isA<DioException>()),
      );
      expect(adapter.requests.length, 1);
    });

    test('POST /auth/refresh не повторяется на сетевой ошибке', () async {
      // Цена бага — разлогин на всех устройствах: сервер считает второй
      // приход того же refresh компрометацией и отзывает всю цепочку.
      final adapter = _OfflineAdapter();

      await expectLater(
        _dioWith(adapter).post<Object?>('/auth/refresh', data: {'refresh': 'r'}),
        throwsA(isA<DioException>()),
      );
      expect(adapter.calls, 1);
    });

    test('идемпотентный GET на сетевой ошибке повторяется', () async {
      final adapter = _OfflineAdapter();

      await expectLater(
        _dioWith(adapter).get<Object?>('/tests'),
        throwsA(isA<DioException>()),
      );
      expect(adapter.calls, 4);
    });

    test('идемпотентный POST повторяется', () async {
      final adapter = ScriptedAdapter([
        const ScriptedResponse(500, {'code': 'server.internal'}),
        const ScriptedResponse(201, {'ok': true}),
      ]);

      final response = await _dio(adapter).post<Object?>('/groups');

      expect(response.statusCode, 201);
      expect(adapter.requests.length, 2);
    });
  });
}
