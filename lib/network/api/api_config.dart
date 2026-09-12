import 'package:quizzerg/network/api/api_environment.dart';

/// Настройки транспортного слоя.
class ApiConfig {
  /// Окружение бэкенда.
  final AppUrl environment;

  /// Таймаут установления соединения.
  final Duration connectTimeout;

  /// Таймаут ответа для обычных запросов.
  final Duration receiveTimeout;

  /// Таймаут ответа для заведомо долгих запросов
  /// (`/sync/changes`, `/import/csv`).
  final Duration longReceiveTimeout;

  /// Логировать запросы. Включается только в debug.
  final bool enableLogging;

  /// Максимальное число попыток для идемпотентных запросов.
  final int maxRetries;

  /// Base URL окружения.
  String get baseUrl => environment.baseUrl;

  const ApiConfig({
    required this.environment,
    this.connectTimeout = const Duration(seconds: 10),
    this.receiveTimeout = const Duration(seconds: 30),
    this.longReceiveTimeout = const Duration(seconds: 60),
    this.enableLogging = false,
    this.maxRetries = 3,
  });
}
