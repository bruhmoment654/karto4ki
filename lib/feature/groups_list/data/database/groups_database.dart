import 'package:drift/drift.dart';
import 'package:quizzerg/persistence/database/app_database.dart';
import 'package:rxdart/rxdart.dart';

part 'groups_database.g.dart';

@DriftAccessor(
  include: {
    'package:quizzerg/feature/groups_list/data/database/test_groups.drift',
    'package:quizzerg/feature/groups_list/data/database/test_group_entries.drift',
  },
)
class GroupsDatabase extends DatabaseAccessor<AppDatabase>
    with _$GroupsDatabaseMixin {
  GroupsDatabase(super.attachedDatabase);

  /// Получить все группы.
  Future<List<TestGroupDatabaseDto>> getAllGroups() =>
      select(testGroups).get();

  /// Получить группу по id.
  Future<TestGroupDatabaseDto?> getGroupById(int id) =>
      (select(testGroups)..where((g) => g.id.equals(id))).getSingleOrNull();

  /// Вставить новую группу.
  Future<int> insertGroup(TestGroupsCompanion group) =>
      into(testGroups).insert(group);

  /// Обновить группу.
  Future<bool> updateGroup(TestGroupDatabaseDto group) =>
      update(testGroups).replace(group);

  /// Удалить группу по id.
  Future<int> deleteGroupById(int id) =>
      (delete(testGroups)..where((g) => g.id.equals(id))).go();

  /// Получить id тестов в группе.
  Future<List<int>> getTestIdsByGroupId(int groupId) async {
    final entries = await (select(testGroupEntries)
          ..where((e) => e.groupId.equals(groupId)))
        .get();
    return entries.map((e) => e.testId).toList();
  }

  /// Получить id групп, в которых состоит тест.
  Future<List<int>> getGroupIdsByTestId(int testId) async {
    final entries = await (select(testGroupEntries)
          ..where((e) => e.testId.equals(testId)))
        .get();
    return entries.map((e) => e.groupId).toList();
  }

  /// Добавить тест в группу (игнорировать если уже есть).
  Future<void> addTestToGroup(int groupId, int testId) =>
      into(testGroupEntries).insert(
        TestGroupEntriesCompanion.insert(
          groupId: groupId,
          testId: testId,
        ),
        mode: InsertMode.insertOrIgnore,
      );

  /// Убрать тест из группы.
  Future<int> removeTestFromGroup(int groupId, int testId) =>
      (delete(testGroupEntries)
            ..where(
              (e) => e.groupId.equals(groupId) & e.testId.equals(testId),
            ))
          .go();

  /// Количество тестов в группе.
  Future<int> getTestCountByGroupId(int groupId) async {
    final count = countAll();
    final query = selectOnly(testGroupEntries)
      ..addColumns([count])
      ..where(testGroupEntries.groupId.equals(groupId));
    final result = await query.getSingle();
    return result.read(count) ?? 0;
  }

  /// Обновить привязки теста к группам (в транзакции).
  Future<void> updateTestGroups(int testId, List<int> groupIds) =>
      transaction(() async {
        await (delete(testGroupEntries)
              ..where((e) => e.testId.equals(testId)))
            .go();
        for (final groupId in groupIds) {
          await into(testGroupEntries).insert(
            TestGroupEntriesCompanion.insert(
              groupId: groupId,
              testId: testId,
            ),
          );
        }
      });

  /// Количество групп, в которых состоит тест.
  Future<int> getGroupCountByTestId(int testId) async {
    final count = countAll();
    final query = selectOnly(testGroupEntries)
      ..addColumns([count])
      ..where(testGroupEntries.testId.equals(testId));
    final result = await query.getSingle();
    return result.read(count) ?? 0;
  }

  /// Stream, эмитящий при изменении таблиц групп или связей.
  Stream<void> watchGroupChanges() => Rx.merge([
        select(testGroups).watch().map((_) {}),
        select(testGroupEntries).watch().map((_) {}),
      ]);
}
