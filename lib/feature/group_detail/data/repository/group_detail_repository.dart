import 'package:quizzerg/core/feature/core/entity/request_operation.dart';
import 'package:quizzerg/core/feature/data/repository/base_repository.dart';
import 'package:quizzerg/feature/group_detail/domain/repository/i_group_detail_repository.dart';
import 'package:quizzerg/feature/groups_list/data/converters/test_group_converter.dart';
import 'package:quizzerg/feature/groups_list/data/database/groups_database.dart';
import 'package:quizzerg/feature/groups_list/domain/entity/test_group_entity.dart';
import 'package:quizzerg/feature/test_detail/data/database/cards_database.dart';
import 'package:quizzerg/feature/tests_list/data/converters/test_converter.dart';
import 'package:quizzerg/feature/tests_list/data/database/tests_database.dart';
import 'package:quizzerg/feature/tests_list/domain/entity/test_entity.dart';

/// Реализация репозитория деталки группы.
class GroupDetailRepository extends BaseRepository
    implements IGroupDetailRepository {
  final GroupsDatabase _groupsDatabase;
  final TestsDatabase _testsDatabase;
  final CardsDatabase _cardsDatabase;

  const GroupDetailRepository({
    required GroupsDatabase groupsDatabase,
    required TestsDatabase testsDatabase,
    required CardsDatabase cardsDatabase,
    required super.errorLogger,
  })  : _groupsDatabase = groupsDatabase,
        _testsDatabase = testsDatabase,
        _cardsDatabase = cardsDatabase;

  @override
  Stream<void> get groupChanges => _groupsDatabase.watchGroupChanges();

  @override
  RequestOperation<TestGroupEntity?> getGroupById(int groupId) =>
      makeCall(() async {
        final dto = await _groupsDatabase.getGroupById(groupId);
        if (dto == null) return null;
        final testCount = await _groupsDatabase.getTestCountByGroupId(groupId);
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
            final questionCount =
                await _cardsDatabase.getCardCountByTestId(testId);
            tests.add(
              TestConverter.fromDto(dto, questionCount: questionCount),
            );
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
  RequestOperation<int> getGroupCountForTest(int testId) => makeCall(() async {
        return _groupsDatabase.getGroupCountByTestId(testId);
      });

  @override
  RequestOperation<List<TestGroupEntity>> getAllGroups() => makeCall(() async {
        final dtos = await _groupsDatabase.getAllGroups();
        final groups = <TestGroupEntity>[];
        for (final dto in dtos) {
          final testCount = await _groupsDatabase.getTestCountByGroupId(dto.id);
          groups.add(TestGroupConverter.fromDto(dto, testCount: testCount));
        }
        return groups;
      });

  @override
  RequestOperation<List<int>> getGroupIdsForTest(int testId) =>
      makeCall(() => _groupsDatabase.getGroupIdsByTestId(testId));

  @override
  RequestOperation<void> updateTestGroups({
    required int testId,
    required List<int> groupIds,
  }) =>
      makeCall(() async {
        await _groupsDatabase.updateTestGroups(testId, groupIds);
      });
}
