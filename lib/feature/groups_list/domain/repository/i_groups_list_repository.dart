import 'package:quizzerg/core/feature/core/entity/request_operation.dart';
import 'package:quizzerg/feature/groups_list/domain/entity/test_group_entity.dart';

/// Интерфейс репозитория списка групп.
abstract interface class IGroupsListRepository {
  /// Stream изменений в таблицах групп и связей.
  Stream<void> get groupChanges;
  /// Получить все группы.
  RequestOperation<List<TestGroupEntity>> getGroups();

  /// Добавить новую группу.
  RequestOperation<void> addGroup({required String title});

  /// Удалить группу по id.
  RequestOperation<void> deleteGroup(int groupId);

  /// Обновить привязки теста к группам.
  RequestOperation<void> updateTestGroups({
    required int testId,
    required List<int> groupIds,
  });

  /// Получить id групп, в которых состоит тест.
  RequestOperation<List<int>> getGroupIdsForTest(int testId);
}
