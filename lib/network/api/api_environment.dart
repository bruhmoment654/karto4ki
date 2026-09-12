/// Окружение бэкенда.
enum AppUrl {
  /// Локальный сервер разработки.
  dev,

  /// Боевой сервер.
  prod;

  /// Base URL окружения. Все пути в API-слое задаются относительно него.
  String get baseUrl => switch (this) {
    AppUrl.dev => 'http://localhost:8080/v1',
    AppUrl.prod => 'http://localhost:8080/v1',
  };
}
