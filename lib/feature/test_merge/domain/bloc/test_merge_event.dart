part of 'test_merge_bloc.dart';

/// Test merge screen events.
@freezed
sealed class TestMergeEvent with _$TestMergeEvent {
  /// Load tests list.
  const factory TestMergeEvent.started({
    required int initialTestId,
  }) = _TestMergeEvent$Started;

  /// Toggle test selection.
  const factory TestMergeEvent.testToggled({
    required String testId,
  }) = _TestMergeEvent$TestToggled;

  /// Confirm merge.
  const factory TestMergeEvent.mergeConfirmed({
    required String title,
  }) = _TestMergeEvent$MergeConfirmed;
}
