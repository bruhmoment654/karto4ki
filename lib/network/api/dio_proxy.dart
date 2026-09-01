import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';

/// Проксирование запросов через локальный снифер (Charles, Proxyman).
///
/// Отладочная механика: включается только с дебаг-экрана, а тот доступен
/// исключительно в dev-сборке.
abstract final class DioProxy {
  /// Направляет запросы [dio] через прокси [proxyUrl] (`host:port`).
  ///
  /// `null` или пустая строка — прокси выключен.
  ///
  /// Вместе с прокси отключается проверка сертификата: снифер подменяет его
  /// своим. Уже открытые соединения берутся из пула, поэтому надёжнее всего
  /// перезапустить приложение.
  static void apply(Dio dio, String? proxyUrl) {
    final adapter = dio.httpClientAdapter;
    if (adapter is! IOHttpClientAdapter) return;

    final proxy = proxyUrl?.trim();
    adapter.createHttpClient = () {
      final client = HttpClient();
      if (proxy == null || proxy.isEmpty) return client;

      return client
        ..findProxy = ((_) => 'PROXY $proxy')
        ..badCertificateCallback = ((_, __, ___) => true);
    };
  }
}
