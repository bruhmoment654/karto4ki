import 'dart:convert';

import 'package:quizzerg/persistence/settings/data/settings_dto.dart';
import 'package:quizzerg/persistence/settings/i_settings_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Реализация хранилища настроек на SharedPreferences.
class SettingsStorage implements ISettingsStorage {
  final SharedPreferences _prefs;

  const SettingsStorage(this._prefs);

  @override
  SettingsDto get() {
    final raw = _prefs.getString(_SettingsStorageKeys.settings.keyName);
    if (raw == null) return const SettingsDto();

    final json = jsonDecode(raw) as Map<String, dynamic>;

    return SettingsDto.fromJson(json);
  }

  @override
  void save(SettingsDto dto) {
    _prefs.setString(
      _SettingsStorageKeys.settings.keyName,
      jsonEncode(dto.toJson()),
    );
  }
}

enum _SettingsStorageKeys {
  settings('app_settings');

  final String keyName;

  const _SettingsStorageKeys(this.keyName);
}
