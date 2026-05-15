part of 'active_session_bloc.dart';

/// Состояние блока активной сессии.
@freezed
sealed class ActiveSessionState with _$ActiveSessionState {
  /// Активной сессии нет (или ещё не загружена).
  const factory ActiveSessionState.none() = ActiveSessionState$None;

  /// Активная сессия доступна для возобновления.
  const factory ActiveSessionState.available({
    required ActiveTestSession session,
  }) = ActiveSessionState$Available;
}
