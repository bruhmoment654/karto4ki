import 'package:quizzerg/core/feature/core/entity/request_operation.dart';
import 'package:quizzerg/core/feature/data/repository/base_repository.dart';
import 'package:quizzerg/feature/group_detail/domain/repository/i_group_detail_repository.dart';
import 'package:quizzerg/feature/groups_list/data/converters/test_group_converter.dart';
import 'package:quizzerg/feature/groups_list/data/database/groups_database.dart';
import 'package:quizzerg/feature/groups_list/domain/entity/test_group_entity.dart';
import 'package:quizzerg/feature/tests_list/data/converters/test_converter.dart';
import 'package:quizzerg/feature/tests_list/data/database/tests_database.dart';
import 'package:quizzerg/feature/tests_list/domain/entity/test_entity.dart';

/// Реализация репозитория деталки группы.
class GroupDetailRepository extends BaseRepository
    implements IGroupDetailRepository {
  final GroupsDatabase _groupsDatabase;
  final TestsDatabase _testsDatabase;

  const GroupDetailRepository({
    required GroupsDatabase groupsDatabase,
    required TestsDatabase testsDatabase,
    required super.errorLogger,
  })  : _groupsDatabase = groupsDatabase,
        _testsDatabase = testsDatabase;

  @override
  RequestOperation<TestGroupEntity?> getGroupById(int groupId) =>
      makeCall(() async {
        final dto = await _groupsDatabase.getGroupById(groupId);
        if (dto == null) return null;
        final testCount =
            await _groupsDatabase.getTestCountByGroupId(groupId);
        return TestGroupConverter.fromDto(dto, testCount: testCount);
      });

  @override
  RequestOperation<List<TestEntity>> getTestsByGroupId(int groupId) =>
      makeCall(() async {
        final testIds = await _groupsDatabase.getTestIdsByGroupId(groupId);
        final tests = <TestEntity>[];
        for (final testId in testIds) {
          final dto = await _testsDatabase.getTestById(testId);
          if (dto != null) {
            tests.add(TestConverter.fromDto(dto));
          }
        }
        return tests;
      });

  @override
  RequestOperation<void> addTestToGroup({
    required int groupId,
    required String title,
    String? description,
  }) =>
      makeCall(() async {
        final testId = await _testsDatabase.insertTest(
          TestConverter.toNewCompanion(
            title: title,
            description: description,
          ),
        );
        await _groupsDatabase.addTestToGroup(groupId, testId);
      });

  @override
  RequestOperation<void> removeTestFromGroup({
    required int groupId,
    required int testId,
  }) =>
      makeCall(() async {
        await _groupsDatabase.removeTestFromGroup(groupId, testId);
      });

  @override
  RequestOperation<void> updateGroupTitle({
    required int groupId,
    required String title,
  }) =>
      makeCall(() async {
        final dto = await _groupsDatabase.getGroupById(groupId);
        if (dto != null) {
          await _groupsDatabase.updateGroup(
            dto.copyWith(title: title, updatedAt: DateTime.now()),
          );
        }
      });

  @override
  RequestOperation<int> getGroupCountForTest(int testId) =>
      makeCall(() async {
        return _groupsDatabase.getGroupCountByTestId(testId);
      });
}
