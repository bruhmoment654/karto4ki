part of 'mixup_bloc.dart';

/// Состояние подмешивания вопросов.
@freezed
sealed class MixupState with _$MixupState {
  const factory MixupState({
    @Default(false) bool enabled,
    @Default(1) int mixupMin,
    @Default(5) int mixupMax,
    @Default(MixupAlgorithm.classic) MixupAlgorithm algorithm,
    @Default(0.35) double streakNegativeBonus,
    @Default(0.35) double streakPositivePenalty,
  }) = _MixupState;
}
