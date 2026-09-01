import 'package:dio/dio.dart';

import 'package:quizzerg/core/logger/error_logger.dart';
import 'package:quizzerg/network/api/public_paths.dart';

/// Пишет запросы и ошибки в лог. Включается только в debug.
///
/// Тела `/auth/*` не логируются — там токены.
class LoggingInterceptor extends Interceptor {
  final ErrorLogger _errorLogger;
  final void Function(String message) onWrite;

  LoggingInterceptor({
    required ErrorLogger errorLogger,
    void Function(String message)? onWrite,
  })  : _errorLogger = errorLogger,
        // ignore: avoid_print
        onWrite = onWrite ?? print;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    onWrite('→ ${options.method} ${options.uri} ${_body(options)}');
    handler.next(options);
  }

  @override
  void onResponse(
    Response<Object?> response,
    ResponseInterceptorHandler handler,
  ) {
    onWrite(
      '← ${response.statusCode} '
      '${response.requestOptions.method} ${response.requestOptions.uri}',
    );
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final requestId = _requestId(err);
    onWrite(
      '✕ ${err.response?.statusCode ?? err.type.name} '
      '${err.requestOptions.method} ${err.requestOptions.uri}'
      '${requestId == null ? '' : ' requestId=$requestId'}',
    );
    _errorLogger.logError(err, err.stackTrace);
    handler.next(err);
  }

  String _body(RequestOptions options) {
    if (options.data == null) return '';
    if (PublicPaths.isPublic(options.path)) return '<hidden>';

    return options.data.toString();
  }

  String? _requestId(DioException err) {
    final data = err.response?.data;

    return data is Map ? data['requestId'] as String? : null;
  }
}
