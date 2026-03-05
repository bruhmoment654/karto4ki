part of 'tinder_test_bloc.dart';

/// Tinder test events.
@freezed
sealed class TinderTestEvent with _$TinderTestEvent {
  /// Start test with given test ID.
  const factory TinderTestEvent.started({
    required int testId,
    @Default(false) bool swapSides,
    @Default(false) bool mixup,
    @Default(1) int mixupMin,
    @Default(5) int mixupMax,
  }) = _TinderTestEvent$Started;

  /// Swipe left (incorrect answer).
  const factory TinderTestEvent.swipedLeft({
    required String cardId,
  }) = _TinderTestEvent$SwipedLeft;

  /// Swipe right (correct answer).
  const factory TinderTestEvent.swipedRight({
    required String cardId,
  }) = _TinderTestEvent$SwipedRight;

  /// Force complete the test.
  const factory TinderTestEvent.completed() = _TinderTestEvent$Completed;

  /// Discard the last answer.
  const factory TinderTestEvent.discard() = _TinderTestEvent$Discard;

  /// Restart the test.
  const factory TinderTestEvent.restarted() = _TinderTestEvent$Restarted;
}
