/// Машинночитаемые коды ошибок API (поле `code` в problem+json).
abstract final class ApiErrorCode {
  static const authMissingToken = 'auth.missing_token';
  static const authInvalidToken = 'auth.invalid_token';

  /// 401 на `/auth/google`: nonce отсутствует, протух или уже использован.
  /// Лечится одним повтором цепочки входа с новым nonce.
  static const authInvalidNonce = 'auth.invalid_nonce';
  static const authExpiredToken = 'auth.expired_token';
  static const authForbidden = 'auth.forbidden';
  static const validationInvalidField = 'validation.invalid_field';
  static const validationMalformedBody = 'validation.malformed_body';
  static const resourceNotFound = 'resource.not_found';
  static const resourceConflict = 'resource.conflict';
  static const importTooLarge = 'import.too_large';
  static const importParseError = 'import.parse_error';
  static const rateLimitExceeded = 'rate_limit.exceeded';
  static const serverInternal = 'server.internal';
  static const serverUnavailable = 'server.unavailable';
}
