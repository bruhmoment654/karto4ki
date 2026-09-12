import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:quizzerg/core/bloc/event_transformers.dart';
import 'package:quizzerg/core/bloc/side_effect_value.dart';
import 'package:quizzerg/feature/question_stats/domain/service/i_stats_export_service.dart';
import 'package:quizzerg/persistence/settings/data/settings_dto.dart';
import 'package:quizzerg/persistence/settings/i_settings_storage.dart';

part 'settings_bloc.freezed.dart';
part 'settings_event.dart';
part 'settings_state.dart';

/// Пауза перед записью оттенка: слайдер тянут непрерывно, писать на каждый
/// кадр в хранилище незачем.
const _hueSaveDebounce = Duration(milliseconds: 500);

/// BLoC настроек приложения.
///
/// Живёт в app-скоупе: настройки читает и экран настроек, и тема приложения,
/// и экран прохождения теста.
final class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final ISettingsStorage _settingsStorage;
  final IStatsExportService _statsExportService;

  SettingsBloc({
    required ISettingsStorage settingsStorage,
    required IStatsExportService statsExportService,
  })  : _settingsStorage = settingsStorage,
        _statsExportService = statsExportService,
        super(SettingsState(settings: settingsStorage.get())) {
    on<_SettingsEvent$Started>(_onStarted);
    on<_SettingsEvent$ThemeModeChanged>(_onThemeModeChanged);
    on<_SettingsEvent$AnimationDurationChanged>(_onAnimationDurationChanged);
    on<_SettingsEvent$CardFontSizeChanged>(_onCardFontSizeChanged);
    on<_SettingsEvent$AccentColorHueChanged>(_onAccentColorHueChanged);
    on<_SettingsEvent$AccentColorHueCommitted>(
      _onAccentColorHueCommitted,
      transformer: debounce(_hueSaveDebounce),
    );
    on<_SettingsEvent$StatsExportRequested>(_onStatsExportRequested);
  }

  Future<void> _onStarted(
    _SettingsEvent$Started event,
    Emitter<SettingsState> emit,
  ) async {
    final info = await PackageInfo.fromPlatform();
    emit(state.copyWith(
      settings: _settingsStorage.get(),
      appVersion: '${info.version} (${info.buildNumber})',
    ));
  }

  void _onThemeModeChanged(
    _SettingsEvent$ThemeModeChanged event,
    Emitter<SettingsState> emit,
  ) {
    _save(emit, (current) => current.copyWith(themeMode: event.mode));
  }

  void _onAnimationDurationChanged(
    _SettingsEvent$AnimationDurationChanged event,
    Emitter<SettingsState> emit,
  ) {
    _save(
      emit,
      (current) => current.copyWith(animationDurationMs: event.value.round()),
    );
  }

  void _onCardFontSizeChanged(
    _SettingsEvent$CardFontSizeChanged event,
    Emitter<SettingsState> emit,
  ) {
    _save(emit, (current) => current.copyWith(cardFontSize: event.value));
  }

  /// Превью цвета обновляем сразу, а запись откладываем.
  void _onAccentColorHueChanged(
    _SettingsEvent$AccentColorHueChanged event,
    Emitter<SettingsState> emit,
  ) {
    emit(state.copyWith(pendingHue: event.value));
    add(SettingsEvent.accentColorHueCommitted(value: event.value));
  }

  void _onAccentColorHueCommitted(
    _SettingsEvent$AccentColorHueCommitted event,
    Emitter<SettingsState> emit,
  ) {
    final updated = _settingsStorage.get().copyWith(accentColorHue: event.value);
    _settingsStorage.save(updated);
    emit(state.copyWith(settings: updated, pendingHue: null));
  }

  Future<void> _onStatsExportRequested(
    _SettingsEvent$StatsExportRequested event,
    Emitter<SettingsState> emit,
  ) async {
    if (state.isExporting) return;

    emit(state.copyWith(isExporting: true));
    final result = await _statsExportService.export();
    emit(state.copyWith(
      isExporting: false,
      exportResult: SideEffectValue(result),
    ));
  }

  void _save(
    Emitter<SettingsState> emit,
    SettingsDto Function(SettingsDto current) update,
  ) {
    final updated = update(_settingsStorage.get());
    _settingsStorage.save(updated);
    emit(state.copyWith(settings: updated));
  }
}
