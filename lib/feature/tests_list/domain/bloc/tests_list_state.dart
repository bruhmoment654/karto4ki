part of 'tests_list_bloc.dart';

/// Tests list screen state.
@freezed
sealed class TestsListState with _$TestsListState {
  const TestsListState._();

  /// Initial loading state.
  const factory TestsListState.loading() = TestsListState$Loading;

  /// Tests loaded state.
  const factory TestsListState.loaded({
    required List<TestEntity> tests,
  }) = TestsListState$Loaded;

  /// Error state.
  const factory TestsListState.error({
    required Object? error,
  }) = TestsListState$Error;

  /// Get tests list or empty list if not loaded.
  List<TestEntity> get testsOrEmpty => switch (this) {
        TestsListState$Loaded(:final tests) => tests,
        _ => [],
      };
}
