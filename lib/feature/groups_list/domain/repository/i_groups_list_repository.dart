import 'package:quizzerg/core/feature/core/entity/request_operation.dart';
import 'package:quizzerg/feature/groups_list/domain/entity/test_group_entity.dart';

/// Интерфейс репозитория списка групп.
abstract interface class IGroupsListRepository {
  /// Stream изменений в таблицах групп и связей.
  Stream<void> get groupChanges;

  /// Получить все группы (включая soft-deleted).
  RequestOperation<List<TestGroupEntity>> getGroups();

  /// Добавить новую группу.
  RequestOperation<void> addGroup({required String title});

  /// Soft delete группы по id.
  RequestOperation<void> deleteGroup(String groupId);

  /// Восстановить soft-deleted группу по id.
  RequestOperation<void> restoreGroup(String groupId);

  /// Обновить привязки теста к группам.
  RequestOperation<void> updateTestGroups({
    required String testId,
    required List<String> groupIds,
  });

  /// Получить id групп, в которых состоит тест.
  RequestOperation<List<String>> getGroupIdsForTest(String testId);
}
