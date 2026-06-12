// ignore_for_file: do_not_use_environment
// --dart-define — штатный механизм передачи окружения сборки; конфиг бэкенда
// не хранится в коде и не должен попадать в репозиторий.

/// Конфигурация бэкенда.
///
/// Значения передаются при сборке через `--dart-define`:
/// ```
/// flutter run \
///   --dart-define=API_BASE_URL=https://api.example.com \
///   --dart-define=AUTH_TOKEN=katp_... \
///   --dart-define=AUTH_USER_ID=<uuid>
/// ```
/// `AUTH_TOKEN` — тестовая авторизация: Supabase JWT или PAT со scope'ами
/// `sync:read`/`sync:write`. Полноценный вход (Supabase, экран авторизации)
/// будет добавлен позже. Без конфигурации приложение работает полностью
/// локально (синк выключен).
abstract final class BackendConfig {
  /// Базовый URL API (без `/v1`).
  static const apiBaseUrl = String.fromEnvironment('API_BASE_URL');

  /// Тестовый токен авторизации (JWT или PAT).
  static const authToken = String.fromEnvironment('AUTH_TOKEN');

  /// userId, соответствующий токену (для детекта смены аккаунта).
  static const authUserId = String.fromEnvironment('AUTH_USER_ID');

  /// Бэкенд сконфигурирован — синхронизация доступна.
  static bool get isConfigured =>
      apiBaseUrl.isNotEmpty && authToken.isNotEmpty;
}
