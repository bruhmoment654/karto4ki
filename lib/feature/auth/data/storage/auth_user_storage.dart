import 'dart:convert';

import 'package:quizzerg/feature/auth/data/storage/i_auth_user_storage.dart';
import 'package:quizzerg/feature/auth/domain/entity/auth_user_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Реализация [IAuthUserStorage] на `SharedPreferences`.
class AuthUserStorage implements IAuthUserStorage {
  static const _key = 'auth_user';

  final SharedPreferences _prefs;

  const AuthUserStorage(this._prefs);

  @override
  AuthUserEntity? get() {
    final raw = _prefs.getString(_key);
    if (raw == null || raw.isEmpty) return null;

    try {
      final json = jsonDecode(raw) as Map<String, dynamic>;
      final id = json['id'] as String?;
      final email = json['email'] as String?;
      if (id == null || email == null) return null;

      return AuthUserEntity(
        id: id,
        email: email,
        plan: json['plan'] as String? ?? 'free',
        displayName: json['displayName'] as String?,
        avatarUrl: json['avatarUrl'] as String?,
      );
    } on Object {
      return null;
    }
  }

  @override
  Future<void> save(AuthUserEntity user) => _prefs.setString(
        _key,
        jsonEncode({
          'id': user.id,
          'email': user.email,
          'plan': user.plan,
          'displayName': user.displayName,
          'avatarUrl': user.avatarUrl,
        }),
      );

  @override
  Future<void> clear() => _prefs.remove(_key);
}
