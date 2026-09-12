part of 'settings_bloc.dart';

/// Состояние настроек приложения.
@freezed
sealed class SettingsState with _$SettingsState {
  const SettingsState._();

  const factory SettingsState({
    /// Сохранённые настройки.
    required SettingsDto settings,

    /// Версия приложения — пусто, пока не прочитан `PackageInfo`.
    @Default('') String appVersion,

    /// Оттенок, который тянут прямо сейчас: показывается до записи.
    double? pendingHue,

    /// Идёт выгрузка статистики.
    @Default(false) bool isExporting,

    /// Одноразовый результат выгрузки — показывается снеком.
    SideEffectValue<StatsExportResult>? exportResult,
  }) = _SettingsState;

  /// Оттенок для превью: незаписанный имеет приоритет над сохранённым.
  double get accentColorHue => pendingHue ?? settings.accentColorHue;
}
