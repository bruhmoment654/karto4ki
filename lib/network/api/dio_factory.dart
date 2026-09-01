import 'package:dio/dio.dart';

import 'package:quizzerg/core/logger/error_logger.dart';
import 'package:quizzerg/network/api/api_config.dart';
import 'package:quizzerg/network/api/auth_token_provider.dart';
import 'package:quizzerg/network/api/interceptor/auth_interceptor.dart';
import 'package:quizzerg/network/api/interceptor/error_mapping_interceptor.dart';
import 'package:quizzerg/network/api/interceptor/logging_interceptor.dart';
import 'package:quizzerg/network/api/interceptor/refresh_interceptor.dart';
import 'package:quizzerg/network/api/interceptor/retry_interceptor.dart';

/// Сборка [Dio] с интерцепторами.
abstract final class DioFactory {
  /// Порядок интерцепторов важен: refresh должен получить 401 раньше,
  /// чем retry начнёт молотить бэкофф, а маппер ошибок идёт последним.
  static Dio create({
    required ApiConfig config,
    required IAuthTokenProvider tokenProvider,
    required ErrorLogger errorLogger,
  }) {
    final dio = Dio(
      BaseOptions(
        baseUrl: config.baseUrl,
        connectTimeout: config.connectTimeout,
        receiveTimeout: config.receiveTimeout,
        contentType: Headers.jsonContentType,
      ),
    );

    dio.interceptors.addAll([
      AuthInterceptor(tokenProvider: tokenProvider),
      RefreshInterceptor(tokenProvider: tokenProvider, dio: dio),
      RetryInterceptor(dio: dio, maxRetries: config.maxRetries),
      if (config.enableLogging) LoggingInterceptor(errorLogger: errorLogger),
      ErrorMappingInterceptor(),
    ]);

    return dio;
  }
}
