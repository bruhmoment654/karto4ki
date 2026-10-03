part of 'attempt_history_bloc.dart';

/// События блока истории прохождений.
@freezed
sealed class AttemptHistoryEvent with _$AttemptHistoryEvent {
  /// Посчитать, сколько места занимает история.
  const factory AttemptHistoryEvent.started() = _AttemptHistoryEvent$Started;

  /// Очистить историю. Подтверждение пользователь уже дал.
  const factory AttemptHistoryEvent.clearRequested() =
      _AttemptHistoryEvent$ClearRequested;
}
