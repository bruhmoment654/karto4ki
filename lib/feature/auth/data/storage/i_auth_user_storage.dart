import 'package:quizzerg/feature/auth/domain/entity/auth_user_entity.dart';

/// Кеш профиля.
///
/// Не секрет, поэтому обычные префы, а не keychain: читать профиль из
/// защищённого хранилища на каждой отрисовке дорого.
abstract interface class IAuthUserStorage {
  AuthUserEntity? get();

  Future<void> save(AuthUserEntity user);

  Future<void> clear();
}
