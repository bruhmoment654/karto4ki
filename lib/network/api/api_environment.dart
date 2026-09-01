import 'dart:io';

/// Окружение бэкенда.
enum ApiEnvironment {
  /// Локальный сервер разработки.
  dev,

  /// Боевой сервер.
  prod;

  /// Base URL окружения. Все пути в API-слое задаются относительно него.
  String get baseUrl => switch (this) {
        // На Android-эмуляторе хост машины доступен по 10.0.2.2.
        ApiEnvironment.dev => Platform.isAndroid
            ? 'http://10.0.2.2:8080/v1'
            : 'http://localhost:8080/v1',
        ApiEnvironment.prod => 'https://api.karto4ki.app/v1',
      };
}
