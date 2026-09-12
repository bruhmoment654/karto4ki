/// Настройки авторизации.
abstract final class AuthConfig {
  /// OAuth-клиент типа **Web** — тот же, что бэкенд проверяет как `aud`
  /// (`GOOGLE_JWT_AUDIENCE` в его окружении). Разъедутся — вход сломается
  /// на `/auth/google` с `401 auth.invalid_token`.
  ///
  /// Не секрет: уезжает в claim `aud` подписанного токена и виден в любом
  /// декомпиле. Секрет — client secret, он живёт только на бэкенде.
  ///
  /// Google сам сверяет package name и подпись APK с записью в консоли.
  static const googleServerClientId =
      '1059996835326-a89g7f3o1ia1m92m1pelnoug99k7nskg.apps.googleusercontent.com';
}
