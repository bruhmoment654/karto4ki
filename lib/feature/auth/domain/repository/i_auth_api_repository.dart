import 'package:quizzerg/feature/auth/data/dto/auth_dto.dart';

/// Эндпоинты `/auth/*`.
///
/// Все они публичные: `Authorization` не подставляется, 401 не запускает
/// refresh (иначе получилась бы рекурсия).
abstract interface class IAuthApiRepository {
  /// `POST /auth/nonce` → 201. Одноразовый, живёт 5 минут.
  Future<String> nonce();

  /// `POST /auth/google` → 201.
  Future<TokenPairDto> google(String idToken);

  /// `POST /auth/refresh` → 200. Ротация: старый refresh умирает сразу.
  Future<TokenPairDto> refresh(String refresh);

  /// `POST /auth/logout` → 204. Идемпотентен, на неизвестный токен даёт 401.
  Future<void> logout(String refresh);
}
