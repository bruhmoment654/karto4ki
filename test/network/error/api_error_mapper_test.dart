import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quizzerg/network/error/api_error_mapper.dart';
import 'package:quizzerg/network/error/api_exception.dart';

DioException _badResponse({
  required int status,
  Map<String, Object?>? problem,
  Map<String, List<String>> headers = const {},
}) {
  final options = RequestOptions(path: '/tests');

  return DioException(
    requestOptions: options,
    type: DioExceptionType.badResponse,
    response: Response<Object?>(
      requestOptions: options,
      statusCode: status,
      data: problem,
      headers: Headers.fromMap(headers),
    ),
  );
}

void main() {
  group('ApiErrorMapper', () {
    test('таймаут — это офлайн, а не ошибка сервера', () {
      final result = ApiErrorMapper.map(
        DioException(
          requestOptions: RequestOptions(path: '/tests'),
          type: DioExceptionType.connectionTimeout,
        ),
      );

      expect(result, isA<NetworkUnavailable>());
    });

    test('обрыв соединения — офлайн', () {
      final result = ApiErrorMapper.map(
        DioException(
          requestOptions: RequestOptions(path: '/tests'),
          type: DioExceptionType.connectionError,
        ),
      );

      expect(result, isA<NetworkUnavailable>());
    });

    test('решение принимается по code, а не по статусу', () {
      final result = ApiErrorMapper.map(
        _badResponse(
          status: 400,
          problem: {
            'code': 'resource.conflict',
            'title': 'что угодно',
            'status': 400,
          },
        ),
      );

      expect(result, isA<ApiConflict>());
    });

    test('validation.* доносит ошибки полей и requestId', () {
      final result = ApiErrorMapper.map(
        _badResponse(
          status: 400,
          problem: {
            'code': 'validation.invalid_field',
            'title': 'bad',
            'status': 400,
            'requestId': 'req-1',
            'errors': [
              {'field': 'title', 'message': 'length must be in 1..200'},
            ],
          },
        ),
      );

      expect(result, isA<ValidationFailed>());
      expect((result as ValidationFailed).errors.single.field, 'title');
      expect(result.requestId, 'req-1');
    });

    test('401 без problem+json всё равно даёт AuthInvalidToken', () {
      expect(
        ApiErrorMapper.map(_badResponse(status: 401)),
        isA<AuthInvalidToken>(),
      );
    });

    test('502 без тела — ошибка сервера', () {
      expect(
        ApiErrorMapper.map(_badResponse(status: 502)),
        isA<ApiServerError>(),
      );
    });

    test('429 читает Retry-After', () {
      final result = ApiErrorMapper.map(
        _badResponse(
          status: 429,
          problem: {
            'code': 'rate_limit.exceeded',
            'title': 'slow down',
            'status': 429,
          },
          headers: {
            'retry-after': ['12'],
          },
        ),
      );

      expect(result, isA<RateLimited>());
      expect((result as RateLimited).retryAfter, const Duration(seconds: 12));
    });

    test('auth.expired_token приравнивается к невалидному токену', () {
      expect(
        ApiErrorMapper.map(
          _badResponse(
            status: 401,
            problem: {
              'code': 'auth.expired_token',
              'title': 'expired',
              'status': 401,
            },
          ),
        ),
        isA<AuthInvalidToken>(),
      );
    });
  });
}
