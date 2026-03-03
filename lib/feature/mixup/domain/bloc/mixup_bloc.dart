import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

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
        super(MixupState(enabled: settingsStorage.get().mixupEnabled)) {
    on<_MixupEvent$Toggled>(_onToggled);
  }

  void _onToggled(
    _MixupEvent$Toggled event,
    Emitter<MixupState> emit,
  ) {
    emit(MixupState(enabled: event.enabled));

    final current = _settingsStorage.get();
    _settingsStorage.save(SettingsDto(
      animationDurationMs: current.animationDurationMs,
      shaderAnimationEnabled: current.shaderAnimationEnabled,
      accentColorHue: current.accentColorHue,
      mixupEnabled: event.enabled,
    ));
  }
}
