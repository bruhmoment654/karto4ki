part of 'tests_list_bloc.dart';

/// Tests list screen events.
@freezed
sealed class TestsListEvent with _$TestsListEvent {
  /// Load tests event.
  const factory TestsListEvent.started() = _TestsListEvent$Started;

  /// Add new test event.
  const factory TestsListEvent.testAdded({
    required String title,
    String? description,
  }) = _TestsListEvent$TestAdded;

  /// Delete test event.
  const factory TestsListEvent.testDeleted({
    required int testId,
  }) = _TestsListEvent$TestDeleted;
}
