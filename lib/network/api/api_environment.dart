/// Окружение бэкенда.
enum AppUrl {
  /// Локальный сервер разработки.
  dev,

  /// Боевой сервер.
  prod;

  /// Base URL окружения. Все пути в API-слое задаются относительно него.
  String get baseUrl => switch (this) {
    AppUrl.dev => 'https://185-70-187-14.sslip.io/v1',
    AppUrl.prod => 'https://185-70-187-14.sslip.io/v1',
  };
}
