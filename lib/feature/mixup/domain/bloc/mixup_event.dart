part of 'mixup_bloc.dart';

/// События подмешивания вопросов.
@freezed
sealed class MixupEvent with _$MixupEvent {
  /// Переключить состояние подмешивания.
  const factory MixupEvent.toggled({
    required bool enabled,
  }) = _MixupEvent$Toggled;
}
