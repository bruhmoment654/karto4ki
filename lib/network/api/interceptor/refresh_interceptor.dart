import 'dart:async';

import 'package:dio/dio.dart';

import 'package:quizzerg/network/api/auth_token_provider.dart';
import 'package:quizzerg/network/api/public_paths.dart';
import 'package:quizzerg/network/error/api_exception.dart';

/// Обновляет токен на 401 и повторяет запрос.
///
/// Обновление — single-flight: параллельные 401 ждут один общий refresh.
/// Иначе один и тот же refresh-токен уйдёт на сервер дважды, сработает
/// reuse-detection и будет отозвана вся цепочка токенов.
class RefreshInterceptor extends Interceptor {
  static const _retriedKey = 'auth_refresh_retried';

  final IAuthTokenProvider _tokenProvider;
  final Dio _dio;

  Future<bool>? _inFlight;

  RefreshInterceptor({
    required IAuthTokenProvider tokenProvider,
    required Dio dio,
  })  : _tokenProvider = tokenProvider,
        _dio = dio;

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (!_shouldRefresh(err)) {
      handler.next(err);
      return;
    }

    final refreshed = await _refreshOnce();
    if (!refreshed) {
      handler.next(err);
      return;
    }

    final options = err.requestOptions;
    options.extra[_retriedKey] = true;

    try {
      handler.resolve(await _dio.fetch<Object?>(options));
    } on DioException catch (retryError) {
      handler.next(retryError);
    }
  }

  bool _shouldRefresh(DioException err) {
    if (err.response?.statusCode != 401) return false;
    if (PublicPaths.isPublic(err.requestOptions.path)) return false;

    return err.requestOptions.extra[_retriedKey] != true;
  }

  Future<bool> _refreshOnce() {
    final pending = _inFlight;
    if (pending != null) return pending;

    final flight = _runRefresh();
    _inFlight = flight;

    return flight;
  }

  Future<bool> _runRefresh() async {
    try {
      final refreshed = await _tokenProvider.refreshTokens();
      // Провал refresh — это «сессия истекла», а не повод ретраить вечно.
      if (!refreshed) await _tokenProvider.onSessionExpired();

      return refreshed;
    } on NetworkUnavailable {
      // Сети нет — сессия ни при чём. Чистить токены нельзя: пользователь
      // разлогинится из-за одного потерянного пакета.
      return false;
    } on Object {
      await _tokenProvider.onSessionExpired();

      return false;
    } finally {
      _inFlight = null;
    }
  }
}
