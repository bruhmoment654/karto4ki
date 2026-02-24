import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:quizzerg/persistence/settings/data/settings_dto.dart';
import 'package:quizzerg/persistence/settings/i_settings_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Реализация хранилища настроек на SharedPreferences.
class SettingsStorage implements ISettingsStorage {
  final SharedPreferences _prefs;
  late final ValueNotifier<SettingsDto> _notifier;

  SettingsStorage(this._prefs) {
    _notifier = ValueNotifier<SettingsDto>(get());
  }

  @override
  ValueListenable<SettingsDto> get listenable => _notifier;

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
    _notifier.value = dto;
  }
}

enum _SettingsStorageKeys {
  settings('app_settings');

  final String keyName;

  const _SettingsStorageKeys(this.keyName);
}
