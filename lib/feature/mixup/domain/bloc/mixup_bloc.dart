import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:quizzerg/feature/tinder_test/domain/mixup/mixup_algorithm.dart';
import 'package:quizzerg/persistence/settings/data/settings_dto.dart';
import 'package:quizzerg/persistence/settings/i_settings_storage.dart';

part 'mixup_event.dart';
part 'mixup_state.dart';
part 'mixup_bloc.freezed.dart';

/// BLoC для управления состоянием подмешивания вопросов.
final class MixupBloc extends Bloc<MixupEvent, MixupState> {
  final ISettingsStorage _settingsStorage;

  MixupBloc({required ISettingsStorage settingsStorage})
      : _settingsStorage = settingsStorage,
        super(MixupState(
          enabled: settingsStorage.get().mixupEnabled,
          mixupMin: settingsStorage.get().mixupMin,
          mixupMax: settingsStorage.get().mixupMax,
          algorithm: settingsStorage.get().mixupAlgorithm,
        )) {
    on<_MixupEvent$Toggled>(_onToggled);
    on<_MixupEvent$RangeChanged>(_onRangeChanged);
    on<_MixupEvent$AlgorithmChanged>(_onAlgorithmChanged);
  }

  void _onToggled(
    _MixupEvent$Toggled event,
    Emitter<MixupState> emit,
  ) {
    emit(state.copyWith(enabled: event.enabled));
    _saveSettings(enabled: event.enabled);
  }

  void _onRangeChanged(
    _MixupEvent$RangeChanged event,
    Emitter<MixupState> emit,
  ) {
    emit(state.copyWith(mixupMin: event.min, mixupMax: event.max));
    _saveSettings(mixupMin: event.min, mixupMax: event.max);
  }

  void _onAlgorithmChanged(
    _MixupEvent$AlgorithmChanged event,
    Emitter<MixupState> emit,
  ) {
    emit(state.copyWith(algorithm: event.algorithm));
    _saveSettings(algorithm: event.algorithm);
  }

  void _saveSettings({
    bool? enabled,
    int? mixupMin,
    int? mixupMax,
    MixupAlgorithm? algorithm,
  }) {
    final current = _settingsStorage.get();
    _settingsStorage.save(SettingsDto(
      animationDurationMs: current.animationDurationMs,
      shaderAnimationEnabled: current.shaderAnimationEnabled,
      accentColorHue: current.accentColorHue,
      mixupEnabled: enabled ?? current.mixupEnabled,
      mixupMin: mixupMin ?? current.mixupMin,
      mixupMax: mixupMax ?? current.mixupMax,
      themeMode: current.themeMode,
      mixupAlgorithm: algorithm ?? current.mixupAlgorithm,
    ));
  }
}
