import 'dart:math';

import 'package:dio/dio.dart';

import 'package:quizzerg/network/error/api_error_mapper.dart';
import 'package:quizzerg/network/util/backoff.dart';

/// Повторяет запрос на сетевых ошибках, 5xx и 429.
///
/// Неидемпотентные POST не повторяются: их ретраит вызывающий код,
/// когда понимает, что дубль безопасен.
class RetryInterceptor extends Interceptor {
  static const _attemptKey = 'retry_attempt';

  /// Пути, повтор которых может задвоить данные.
  static const nonIdempotentPaths = [
    '/sync/push',
    '/stats/answer',
    '/stats/answers/batch',
    '/import/csv',
    '/tokens',
  ];

  final Dio _dio;
  final int _maxRetries;
  final Duration _baseDelay;
  final Random? _random;

  RetryInterceptor({
    required Dio dio,
    int maxRetries = 3,
    Duration baseDelay = Backoff.defaultBase,
    Random? random,
  })  : _dio = dio,
        _maxRetries = maxRetries,
        _baseDelay = baseDelay,
        _random = random;

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (!_isRetryable(err)) {
      handler.next(err);
      return;
    }

    final attempt = (err.requestOptions.extra[_attemptKey] as int? ?? 0) + 1;
    if (attempt > _maxRetries) {
      handler.next(err);
      return;
    }

    await Future<void>.delayed(_delay(err, attempt));

    final options = err.requestOptions;
    options.extra[_attemptKey] = attempt;

    try {
      handler.resolve(await _dio.fetch<Object?>(options));
    } on DioException catch (retryError) {
      handler.next(retryError);
    }
  }

  Duration _delay(DioException err, int attempt) {
    final retryAfter = ApiErrorMapper.retryAfterOf(err.response);
    if (retryAfter != null) return retryAfter;

    return Backoff.delayFor(attempt, base: _baseDelay, random: _random);
  }

  bool _isRetryable(DioException err) {
    if (err.type == DioExceptionType.cancel) return false;
    if (_isNonIdempotent(err.requestOptions)) return false;

    final status = err.response?.statusCode;
    if (status == null) return err.type != DioExceptionType.badResponse;

    return status == 429 || status >= 500;
  }

  bool _isNonIdempotent(RequestOptions options) {
    if (options.method.toUpperCase() != 'POST') return false;

    return nonIdempotentPaths.any((path) => options.path.startsWith(path));
  }
}
