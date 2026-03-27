part of 'mixup_bloc.dart';

/// События подмешивания вопросов.
@freezed
sealed class MixupEvent with _$MixupEvent {
  /// Переключить состояние подмешивания.
  const factory MixupEvent.toggled({
    required bool enabled,
  }) = _MixupEvent$Toggled;

  /// Изменить диапазон подмешивания.
  const factory MixupEvent.rangeChanged({
    required int min,
    required int max,
  }) = _MixupEvent$RangeChanged;

  /// Изменить алгоритм подмешивания.
  const factory MixupEvent.algorithmChanged({
    required MixupAlgorithm algorithm,
  }) = _MixupEvent$AlgorithmChanged;

  /// Изменить коэффициенты streak.
  const factory MixupEvent.streakCoefficientsChanged({
    required double negativeBonus,
    required double positivePenalty,
  }) = _MixupEvent$StreakCoefficientsChanged;
}
