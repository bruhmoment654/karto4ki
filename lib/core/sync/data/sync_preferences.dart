import 'package:shared_preferences/shared_preferences.dart';

/// Хранилище служебного состояния синхронизации (SharedPreferences).
class SyncPreferences {
  static const _cursorKey = 'sync_cursor';
  static const _lastSyncedAtKey = 'sync_last_synced_at';
  static const _lastUserIdKey = 'sync_last_user_id';

  final SharedPreferences _prefs;

  const SyncPreferences(this._prefs);

  /// Курсор `GET /sync/changes` (opaque, выданный бэкендом).
  String? get cursor => _prefs.getString(_cursorKey);

  Future<void> setCursor(String? value) => value == null
      ? _prefs.remove(_cursorKey)
      : _prefs.setString(_cursorKey, value);

  /// Момент последней успешной синхронизации.
  DateTime? get lastSyncedAt {
    final millis = _prefs.getInt(_lastSyncedAtKey);
    return millis == null ? null : DateTime.fromMillisecondsSinceEpoch(millis);
  }

  Future<void> setLastSyncedAt(DateTime value) =>
      _prefs.setInt(_lastSyncedAtKey, value.millisecondsSinceEpoch);

  /// userId последнего авторизованного пользователя
  /// (для детекта смены аккаунта).
  String? get lastUserId => _prefs.getString(_lastUserIdKey);

  Future<void> setLastUserId(String value) =>
      _prefs.setString(_lastUserIdKey, value);
}
