import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:quizzerg/feature/auth/data/storage/i_auth_token_storage.dart';
import 'package:quizzerg/feature/auth/domain/entity/auth_token_pair.dart';

/// Реализация [IAuthTokenStorage] на `flutter_secure_storage`.
///
/// Пара лежит в одном ключе одной JSON-строкой — так запись атомарна
/// без транзакций, которых у secure storage нет. Два отдельных ключа
/// дали бы окно, в котором access уже новый, а refresh ещё старый.
class AuthTokenStorage implements IAuthTokenStorage {
  static const _key = 'auth_token_pair';

  static const _androidOptions = AndroidOptions(encryptedSharedPreferences: true);
  static const _iosOptions = IOSOptions(
    accessibility: KeychainAccessibility.first_unlock,
  );

  final FlutterSecureStorage _storage;

  const AuthTokenStorage({FlutterSecureStorage storage = const FlutterSecureStorage()})
      : _storage = storage;

  @override
  Future<AuthTokenPair?> read() async {
    final raw = await _storage.read(
      key: _key,
      aOptions: _androidOptions,
      iOptions: _iosOptions,
    );
    if (raw == null || raw.isEmpty) return null;

    try {
      final json = jsonDecode(raw) as Map<String, dynamic>;
      final access = json['accessToken'] as String?;
      final refresh = json['refreshToken'] as String?;
      if (access == null || refresh == null) return null;

      return AuthTokenPair(accessToken: access, refreshToken: refresh);
    } on Object {
      // Битое значение равносильно отсутствию сессии.
      return null;
    }
  }

  @override
  Future<void> write(AuthTokenPair pair) => _storage.write(
        key: _key,
        value: jsonEncode({
          'accessToken': pair.accessToken,
          'refreshToken': pair.refreshToken,
        }),
        aOptions: _androidOptions,
        iOptions: _iosOptions,
      );

  @override
  Future<void> clear() => _storage.delete(
        key: _key,
        aOptions: _androidOptions,
        iOptions: _iosOptions,
      );
}
