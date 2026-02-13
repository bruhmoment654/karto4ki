import 'package:quizzerg/persistence/settings/data/settings_dto.dart';

/// Интерфейс хранилища настроек приложения.
abstract interface class ISettingsStorage {
  /// Возвращает текущие настройки. Если нет сохранённых — дефолтные.
  SettingsDto get();

  /// Сохраняет настройки.
  void save(SettingsDto dto);
}
