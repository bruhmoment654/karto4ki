part of 'settings_bloc.dart';

/// События настроек приложения.
@freezed
sealed class SettingsEvent with _$SettingsEvent {
  /// Инициализация: подтянуть версию приложения.
  const factory SettingsEvent.started() = _SettingsEvent$Started;

  /// Сменить режим темы.
  const factory SettingsEvent.themeModeChanged({
    required AppThemeMode mode,
  }) = _SettingsEvent$ThemeModeChanged;

  /// Изменить длительность анимаций.
  const factory SettingsEvent.animationDurationChanged({
    required double value,
  }) = _SettingsEvent$AnimationDurationChanged;

  /// Изменить размер шрифта на карточке.
  const factory SettingsEvent.cardFontSizeChanged({
    required double value,
  }) = _SettingsEvent$CardFontSizeChanged;

  /// Пользователь тянет слайдер оттенка — обновляем превью.
  const factory SettingsEvent.accentColorHueChanged({
    required double value,
  }) = _SettingsEvent$AccentColorHueChanged;

  /// Отложенная запись выбранного оттенка.
  const factory SettingsEvent.accentColorHueCommitted({
    required double value,
  }) = _SettingsEvent$AccentColorHueCommitted;

  /// Выгрузить статистику в CSV.
  const factory SettingsEvent.statsExportRequested() =
      _SettingsEvent$StatsExportRequested;
}
