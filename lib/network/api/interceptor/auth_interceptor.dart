import 'package:dio/dio.dart';

import 'package:quizzerg/network/api/auth_token_provider.dart';
import 'package:quizzerg/network/api/public_paths.dart';

/// Подставляет `Authorization: Bearer <access>` во все приватные запросы.
class AuthInterceptor extends Interceptor {
  final IAuthTokenProvider _tokenProvider;

  AuthInterceptor({required IAuthTokenProvider tokenProvider})
      : _tokenProvider = tokenProvider;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (PublicPaths.isPublic(options.path)) {
      handler.next(options);
      return;
    }

    final token = await _tokenProvider.accessToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }
}
