part of 'test_merge_bloc.dart';

/// Состояние экрана объединения тестов.
@freezed
sealed class TestMergeState with _$TestMergeState {
  const TestMergeState._();

  /// Загрузка.
  const factory TestMergeState.loading() = TestMergeState$Loading;

  /// Список тестов загружен.
  const factory TestMergeState.loaded({
    required List<TestEntity> tests,
    required Set<String> selectedTestIds,
    required String initialTestId,
  }) = TestMergeState$Loaded;

  /// Процесс объединения.
  const factory TestMergeState.merging() = TestMergeState$Merging;

  /// Успешное объединение.
  const factory TestMergeState.success({
    required int newTestId,
  }) = TestMergeState$Success;

  /// Ошибка.
  const factory TestMergeState.error({
    required Failure failure,
  }) = TestMergeState$Error;
}
