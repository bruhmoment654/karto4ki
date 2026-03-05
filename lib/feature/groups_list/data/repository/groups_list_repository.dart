import 'package:quizzerg/core/feature/core/entity/request_operation.dart';
import 'package:quizzerg/core/feature/data/repository/base_repository.dart';
import 'package:quizzerg/feature/groups_list/data/converters/test_group_converter.dart';
import 'package:quizzerg/feature/groups_list/data/database/groups_database.dart';
import 'package:quizzerg/feature/groups_list/domain/entity/test_group_entity.dart';
import 'package:quizzerg/feature/groups_list/domain/repository/i_groups_list_repository.dart';

/// Реализация репозитория списка групп.
class GroupsListRepository extends BaseRepository
    implements IGroupsListRepository {
  final GroupsDatabase _groupsDatabase;

  const GroupsListRepository({
    required GroupsDatabase groupsDatabase,
    required super.errorLogger,
  }) : _groupsDatabase = groupsDatabase;

  @override
  Stream<void> get groupChanges => _groupsDatabase.watchGroupChanges();

  @override
  RequestOperation<List<TestGroupEntity>> getGroups() => makeCall(() async {
        final dtos = await _groupsDatabase.getAllGroups();
        final groups = <TestGroupEntity>[];
        for (final dto in dtos) {
          final testCount = await _groupsDatabase.getTestCountByGroupId(dto.id);
          groups.add(TestGroupConverter.fromDto(dto, testCount: testCount));
        }
        return groups;
      });

  @override
  RequestOperation<void> addGroup({required String title}) =>
      makeCall(() async {
        await _groupsDatabase.insertGroup(
          TestGroupConverter.toNewCompanion(title: title),
        );
      });

  @override
  RequestOperation<void> deleteGroup(int groupId) => makeCall(() async {
        await _groupsDatabase.deleteGroupById(groupId);
      });

  @override
  RequestOperation<void> updateTestGroups({
    required int testId,
    required List<int> groupIds,
  }) =>
      makeCall(() async {
        await _groupsDatabase.updateTestGroups(testId, groupIds);
      });

  @override
  RequestOperation<List<int>> getGroupIdsForTest(int testId) =>
      makeCall(() => _groupsDatabase.getGroupIdsByTestId(testId));
}
