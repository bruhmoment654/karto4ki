import 'package:quizzerg/core/feature/core/entity/request_operation.dart';
import 'package:quizzerg/feature/groups_list/domain/entity/test_group_entity.dart';
import 'package:quizzerg/feature/tests_list/domain/entity/test_entity.dart';

/// Интерфейс репозитория деталки группы.
abstract interface class IGroupDetailRepository {
  /// Stream изменений в таблицах групп и связей.
  Stream<void> get groupChanges;
  /// Получить группу по id.
  RequestOperation<TestGroupEntity?> getGroupById(int groupId);

  /// Получить тесты в группе.
  RequestOperation<List<TestEntity>> getTestsByGroupId(int groupId);

  /// Добавить тест в группу (создаёт тест и связывает).
  RequestOperation<void> addTestToGroup({
    required int groupId,
    required String title,
    String? description,
  });

  /// Убрать тест из группы (тест остаётся в БД).
  RequestOperation<void> removeTestFromGroup({
    required int groupId,
    required int testId,
  });

  /// Обновить название группы.
  RequestOperation<void> updateGroupTitle({
    required int groupId,
    required String title,
  });

  /// Количество групп, в которых состоит тест.
  RequestOperation<int> getGroupCountForTest(int testId);

  /// Получить все группы.
  RequestOperation<List<TestGroupEntity>> getAllGroups();

  /// Получить id групп, в которых состоит тест.
  RequestOperation<List<int>> getGroupIdsForTest(int testId);

  /// Обновить привязки теста к группам.
  RequestOperation<void> updateTestGroups({
    required int testId,
    required List<int> groupIds,
  });
}
