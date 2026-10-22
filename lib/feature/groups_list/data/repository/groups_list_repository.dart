import 'package:drift/drift.dart';
import 'package:quizzerg/core/feature/core/entity/request_operation.dart';
import 'package:quizzerg/core/feature/data/repository/base_repository.dart';
import 'package:quizzerg/feature/groups_list/data/converters/test_group_converter.dart';
import 'package:quizzerg/feature/groups_list/data/database/groups_database.dart';
import 'package:quizzerg/feature/groups_list/domain/entity/test_group_entity.dart';
import 'package:quizzerg/feature/groups_list/domain/repository/i_groups_list_repository.dart';
import 'package:quizzerg/feature/question_stats/data/service/study_progress_reader.dart';
import 'package:quizzerg/feature/tests_list/data/database/tests_database.dart';
import 'package:quizzerg/persistence/database/app_database.dart';

/// Реализация репозитория списка групп.
class GroupsListRepository extends BaseRepository
    implements IGroupsListRepository {
  final GroupsDatabase _groupsDatabase;
  final TestsDatabase _testsDatabase;
  final StudyProgressReader _progressReader;

  const GroupsListRepository({
    required GroupsDatabase groupsDatabase,
    required TestsDatabase testsDatabase,
    required StudyProgressReader progressReader,
    required super.errorLogger,
  })  : _groupsDatabase = groupsDatabase,
        _testsDatabase = testsDatabase,
        _progressReader = progressReader;

  @override
  Stream<void> get groupChanges => _groupsDatabase.watchGroupChanges();

  @override
  RequestOperation<List<TestGroupEntity>> getGroups() => makeCall(() async {
        final dtos = await _groupsDatabase.getAllGroups();
        final testIdsByGroup = await _groupsDatabase.getTestIdsByGroup();
        final progress = await _progressReader.read();
        final groups = <TestGroupEntity>[];
        for (final dto in dtos) {
          final testCount = await _groupsDatabase.getTestCountByGroupId(dto.id);
          groups.add(
            TestGroupConverter.fromDto(
              dto,
              testCount: testCount,
              progress: progress.of(testIdsByGroup[dto.id] ?? const []),
            ),
          );
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
  RequestOperation<void> renameGroup({
    required String groupId,
    required String title,
  }) =>
      makeCall(() async {
        await _groupsDatabase.updateGroup(
          TestGroupsCompanion(id: Value(groupId), title: Value(title)),
        );
      });

  @override
  RequestOperation<void> deleteGroup(String groupId) => makeCall(() async {
        await _groupsDatabase.softDeleteGroupById(groupId);
      });

  @override
  RequestOperation<void> updateTestGroups({
    required String testId,
    required List<String> groupIds,
  }) =>
      makeCall(() async {
        await _groupsDatabase.updateTestGroups(testId, groupIds);
        // Набор групп едет на сервер внутри payload теста — правка связей
        // делает неотправленным сам тест.
        await _testsDatabase.touchTest(testId);
      });

  @override
  RequestOperation<List<String>> getGroupIdsForTest(String testId) =>
      makeCall(() => _groupsDatabase.getGroupIdsByTestId(testId));
}
