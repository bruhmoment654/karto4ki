part of 'active_session_bloc.dart';

/// События блока активной сессии.
@freezed
sealed class ActiveSessionEvent with _$ActiveSessionEvent {
  /// Подписаться на изменения активной сессии в хранилище.
  const factory ActiveSessionEvent.started() = _ActiveSessionEvent$Started;

  /// Внутреннее: пришло обновление из стрима репозитория.
  const factory ActiveSessionEvent.updated({
    ActiveTestSession? session,
  }) = _ActiveSessionEvent$Updated;

  /// Очистить активную сессию.
  const factory ActiveSessionEvent.cleared() = _ActiveSessionEvent$Cleared;
}
