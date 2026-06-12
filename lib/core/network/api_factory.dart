import 'package:dio/dio.dart';

import 'package:quizzerg/core/auth/i_auth_service.dart';
import 'package:quizzerg/core/config/backend_config.dart';
import 'package:quizzerg/core/network/karto4ki_api.dart';

/// Сборка [Karto4kiApi] с авторизацией.
abstract final class ApiFactory {
  static Karto4kiApi create(IAuthService authService) {
    final dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );
    dio.interceptors.add(_AuthInterceptor(authService));
    return Karto4kiApi(dio, baseUrl: '${BackendConfig.apiBaseUrl}/v1');
  }
}

/// Подставляет Bearer-токен из [IAuthService].
class _AuthInterceptor extends Interceptor {
  final IAuthService _authService;

  const _AuthInterceptor(this._authService);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _authService.getAccessToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}
