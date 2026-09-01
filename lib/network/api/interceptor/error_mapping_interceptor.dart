import 'package:dio/dio.dart';

import 'package:quizzerg/network/error/api_error_mapper.dart';

/// Последний в цепочке: заменяет [DioException] типизированным
/// `ApiException`, чтобы выше по стеку про dio никто не знал.
class ErrorMappingInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        response: err.response,
        type: err.type,
        error: ApiErrorMapper.map(err),
        stackTrace: err.stackTrace,
      ),
    );
  }
}
