part of 'tinder_test_bloc.dart';

/// Tinder test state.
@freezed
sealed class TinderTestState with _$TinderTestState {
  const TinderTestState._();

  /// Initial state before test starts.
  const factory TinderTestState.initial() = TinderTestState$Initial;

  /// Loading state while fetching test data.
  const factory TinderTestState.loading() = TinderTestState$Loading;

  /// Test has no cards.
  const factory TinderTestState.empty() = TinderTestState$Empty;

  /// Test is in progress.
  const factory TinderTestState.inProgress({
    required TestSession session,
    required CardEntity currentCard,
  }) = TinderTestState$InProgress;

  /// Test is completed.
  const factory TinderTestState.completed({
    required TestSession session,
  }) = TinderTestState$Completed;

  /// Error state.
  const factory TinderTestState.error({
    required String message,
  }) = TinderTestState$Error;

  /// Get session if available.
  TestSession? get sessionOrNull => switch (this) {
        TinderTestState$InProgress(:final session) => session,
        TinderTestState$Completed(:final session) => session,
        _ => null,
      };
}
