part of 'mixup_bloc.dart';

/// Состояние подмешивания вопросов.
@freezed
sealed class MixupState with _$MixupState {
  const factory MixupState({
    @Default(false) bool enabled,
  }) = _MixupState;
}
