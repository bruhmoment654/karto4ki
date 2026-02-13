part of 'test_merge_bloc.dart';

/// Test merge screen state.
@freezed
sealed class TestMergeState with _$TestMergeState {
  const TestMergeState._();

  /// Loading.
  const factory TestMergeState.loading() = TestMergeState$Loading;

  /// Tests list loaded.
  const factory TestMergeState.loaded({
    required List<TestEntity> tests,
    required Set<String> selectedTestIds,
    required String initialTestId,
  }) = TestMergeState$Loaded;

  /// Merging in progress.
  const factory TestMergeState.merging() = TestMergeState$Merging;

  /// Merge succeeded.
  const factory TestMergeState.success({
    required int newTestId,
  }) = TestMergeState$Success;

  /// Error.
  const factory TestMergeState.error({
    required Failure failure,
  }) = TestMergeState$Error;
}
