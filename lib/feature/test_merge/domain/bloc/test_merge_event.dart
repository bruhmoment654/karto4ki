part of 'test_merge_bloc.dart';

/// События экрана объединения тестов.
@freezed
sealed class TestMergeEvent with _$TestMergeEvent {
  /// Загрузка списка тестов.
  const factory TestMergeEvent.started({
    required int initialTestId,
  }) = _TestMergeEvent$Started;

  /// Переключение выбора теста.
  const factory TestMergeEvent.testToggled({
    required String testId,
  }) = _TestMergeEvent$TestToggled;

  /// Подтверждение объединения.
  const factory TestMergeEvent.mergeConfirmed({
    required String title,
  }) = _TestMergeEvent$MergeConfirmed;
}
