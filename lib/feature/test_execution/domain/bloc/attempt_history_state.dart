part of 'attempt_history_bloc.dart';

/// Чем закончилась очистка истории.
enum AttemptHistoryClearResult { cleared, failed }

/// Состояние блока истории прохождений.
@freezed
sealed class AttemptHistoryState with _$AttemptHistoryState {
  /// Размер ещё считается.
  const factory AttemptHistoryState.loading() = AttemptHistoryState$Loading;

  const factory AttemptHistoryState.loaded({
    /// `null` — размер посчитать не удалось; очистка всё равно доступна.
    AttemptHistoryUsage? usage,

    /// Идёт очистка: кнопка показывает прогресс и не нажимается.
    @Default(false) bool isClearing,

    /// Одноразовый результат очистки — показывается снеком.
    SideEffectValue<AttemptHistoryClearResult>? clearResult,
  }) = AttemptHistoryState$Loaded;
}
