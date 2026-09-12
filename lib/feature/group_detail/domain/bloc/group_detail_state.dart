part of 'group_detail_bloc.dart';

/// Состояние экрана деталки группы.
@freezed
sealed class GroupDetailState with _$GroupDetailState {
  const GroupDetailState._();

  /// Начальное состояние загрузки.
  const factory GroupDetailState.loading() = GroupDetailState$Loading;

  /// Группа и тесты загружены.
  const factory GroupDetailState.loaded({
    required TestGroupEntity group,
    required List<TestEntity> tests,

    /// Все группы приложения — нужны диалогу «добавить в группу».
    required List<TestGroupEntity> allGroups,

    /// Привязки «тест -> id групп». Держим в состоянии, чтобы UI не ходил
    /// в репозиторий за ними при открытии диалогов.
    required Map<String, List<String>> groupIdsByTest,
  }) = GroupDetailState$Loaded;

  /// Ошибка.
  const factory GroupDetailState.error({
    required Failure failure,
  }) = GroupDetailState$Error;

  /// Получить группу или null.
  TestGroupEntity? get groupOrNull => switch (this) {
        GroupDetailState$Loaded(:final group) => group,
        _ => null,
      };

  /// Получить список тестов или пустой список.
  List<TestEntity> get testsOrEmpty => switch (this) {
        GroupDetailState$Loaded(:final tests) => tests,
        _ => [],
      };

  /// Состоит ли тест только в текущей группе.
  bool isLastGroupForTest(String testId) => switch (this) {
        GroupDetailState$Loaded(:final groupIdsByTest) =>
          (groupIdsByTest[testId] ?? const []).length <= 1,
        _ => false,
      };
}
