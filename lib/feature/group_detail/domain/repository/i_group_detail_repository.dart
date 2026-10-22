import 'package:quizzerg/core/feature/core/entity/request_operation.dart';
import 'package:quizzerg/feature/groups_list/domain/entity/test_group_entity.dart';
import 'package:quizzerg/feature/tests_list/domain/entity/test_entity.dart';

/// Интерфейс репозитория деталки группы.
abstract interface class IGroupDetailRepository {
  /// Stream изменений в таблицах групп и связей.
  Stream<void> get groupChanges;

  /// Получить группу по id.
  RequestOperation<TestGroupEntity?> getGroupById(String groupId);

  /// Получить тесты в группе.
  RequestOperation<List<TestEntity>> getTestsByGroupId(String groupId);

  /// Добавить тест в группу (создаёт тест и связывает).
  RequestOperation<void> addTestToGroup({
    required String groupId,
    required String title,
    String? description,
  });

  /// Убрать тест из группы (тест остаётся в БД).
  RequestOperation<void> removeTestFromGroup({
    required String groupId,
    required String testId,
  });

  /// Переименовать тест.
  RequestOperation<void> renameTest({
    required String testId,
    required String title,
  });

  /// Обновить название группы.
  RequestOperation<void> updateGroupTitle({
    required String groupId,
    required String title,
  });

  /// Получить все группы.
  RequestOperation<List<TestGroupEntity>> getAllGroups();

  /// Получить id групп для каждого из тестов [testIds].
  ///
  /// Одним вызовом, чтобы деталка группы держала привязки прямо в состоянии
  /// и не ходила в репозиторий из UI при открытии диалогов.
  RequestOperation<Map<String, List<String>>> getGroupIdsForTests(
    List<String> testIds,
  );

  /// Обновить привязки теста к группам.
  RequestOperation<void> updateTestGroups({
    required String testId,
    required List<String> groupIds,
  });
}
