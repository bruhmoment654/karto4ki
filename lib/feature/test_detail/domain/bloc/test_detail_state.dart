part of 'test_detail_bloc.dart';

/// Test detail screen state.
@freezed
sealed class TestDetailState with _$TestDetailState {
  const TestDetailState._();

  /// Initial loading state.
  const factory TestDetailState.loading() = TestDetailState$Loading;

  /// Test and cards loaded state.
  const factory TestDetailState.loaded({
    required TestEntity test,
    required List<CardEntity> cards,
  }) = TestDetailState$Loaded;

  /// Error state.
  const factory TestDetailState.error({
    required Failure failure,
  }) = TestDetailState$Error;

  /// Get test or null if not loaded.
  TestEntity? get testOrNull => switch (this) {
        TestDetailState$Loaded(:final test) => test,
        _ => null,
      };

  /// Get cards list or empty list if not loaded.
  List<CardEntity> get cardsOrEmpty => switch (this) {
        TestDetailState$Loaded(:final cards) => cards,
        _ => [],
      };
}
