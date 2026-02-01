part of 'test_detail_bloc.dart';

/// Test detail screen events.
@freezed
sealed class TestDetailEvent with _$TestDetailEvent {
  /// Load test detail event.
  const factory TestDetailEvent.started({
    required int testId,
  }) = _TestDetailEvent$Started;

  /// Add new card to test event.
  const factory TestDetailEvent.cardAdded({
    required String front,
    required String back,
  }) = _TestDetailEvent$CardAdded;

  /// Delete card event.
  const factory TestDetailEvent.cardDeleted({
    required int cardId,
  }) = _TestDetailEvent$CardDeleted;

  /// Update card event.
  const factory TestDetailEvent.cardUpdated({
    required CardEntity card,
  }) = _TestDetailEvent$CardUpdated;

  /// Update test event.
  const factory TestDetailEvent.testUpdated({
    required String title,
    String? description,
  }) = _TestDetailEvent$TestUpdated;
}
