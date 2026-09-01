import 'package:dio/dio.dart';

import 'package:quizzerg/network/dto/page_response_dto.dart';
import 'package:quizzerg/network/error/api_error_mapper.dart';
import 'package:quizzerg/network/error/api_exception.dart';

/// Тонкая обёртка над [Dio], скрывающая dio от репозиториев.
///
/// Любая ошибка транспорта выходит наружу типизированным [ApiException].
class ApiClient {
  final Dio dio;

  const ApiClient(this.dio);

  /// Выполняет запрос и разбирает тело ответа.
  Future<T> request<T>({
    required Future<Response<Object?>> Function(Dio dio) send,
    required T Function(Object? data) parse,
  }) async {
    try {
      final response = await send(dio);

      return parse(response.data);
    } on DioException catch (error, stackTrace) {
      Error.throwWithStackTrace(_toApiException(error), stackTrace);
    }
  }

  /// Выполняет запрос без разбора тела (204 и подобные).
  Future<void> requestVoid(
    Future<Response<Object?>> Function(Dio dio) send,
  ) =>
      request(send: send, parse: (_) {});

  /// Приводит тело ответа к JSON-объекту.
  static Map<String, dynamic> asMap(Object? data) {
    if (data is Map) return Map<String, dynamic>.from(data);

    throw ApiServerError(
      message: 'Ожидался JSON-объект, пришло ${data.runtimeType}',
    );
  }

  /// Разбирает страницу списочного эндпоинта.
  static PageResponseDto<T> asPage<T>(
    Object? data,
    T Function(Map<String, dynamic> json) itemFromJson,
  ) =>
      PageResponseDto<T>.fromJson(
        asMap(data),
        (json) => itemFromJson(asMap(json)),
      );

  ApiException _toApiException(DioException error) {
    final mapped = error.error;

    return mapped is ApiException ? mapped : ApiErrorMapper.map(error);
  }
}
