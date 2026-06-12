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

  /// Получить все группы (включая soft-deleted — для UI «Удалён» и синка).
  Future<List<TestGroupDatabaseDto>> getAllGroups() => select(testGroups).get();

  /// Получить живые (не soft-deleted) группы.
  Future<List<TestGroupDatabaseDto>> getAliveGroups() =>
      (select(testGroups)..where((g) => g.deletedAt.isNull())).get();

  /// Получить группу по id.
  Future<TestGroupDatabaseDto?> getGroupById(String id) =>
      (select(testGroups)..where((g) => g.id.equals(id))).getSingleOrNull();

  /// Вставить новую группу.
  Future<void> insertGroup(TestGroupsCompanion group) =>
      into(testGroups).insert(group);

  /// Обновить группу.
  Future<bool> updateGroup(TestGroupDatabaseDto group) =>
      update(testGroups).replace(group);

  /// Soft delete: пометить группу удалённой и ожидающей отправки.
  Future<int> softDeleteGroupById(String id) =>
      (update(testGroups)..where((g) => g.id.equals(id))).write(
        TestGroupsCompanion(
          deletedAt: Value(DateTime.now()),
          syncStatus: const Value('pending'),
          updatedAt: Value(DateTime.now()),
        ),
      );

  /// Restore: снять метку удаления, пометить ожидающей восстановления.
  Future<int> restoreGroupById(String id) =>
      (update(testGroups)..where((g) => g.id.equals(id))).write(
        TestGroupsCompanion(
          deletedAt: const Value(null),
          syncStatus: const Value('pending_restore'),
          updatedAt: Value(DateTime.now()),
        ),
      );

  /// Физически удалить группу (после подтверждения бэкендом).
  Future<int> hardDeleteGroupById(String id) =>
      (delete(testGroups)..where((g) => g.id.equals(id))).go();

  /// Получить id тестов в группе.
  Future<List<String>> getTestIdsByGroupId(String groupId) async {
    final entries = await (select(testGroupEntries)
          ..where((e) => e.groupId.equals(groupId)))
        .get();
    return entries.map((e) => e.testId).toList();
  }

  /// Получить id групп, в которых состоит тест.
  Future<List<String>> getGroupIdsByTestId(String testId) async {
    final entries = await (select(testGroupEntries)
          ..where((e) => e.testId.equals(testId)))
        .get();
    return entries.map((e) => e.groupId).toList();
  }

  /// Добавить тест в группу (игнорировать если уже есть).
  Future<void> addTestToGroup(String groupId, String testId) =>
      into(testGroupEntries).insert(
        TestGroupEntriesCompanion.insert(
          groupId: groupId,
          testId: testId,
        ),
        mode: InsertMode.insertOrIgnore,
      );

  /// Убрать тест из группы.
  Future<int> removeTestFromGroup(String groupId, String testId) =>
      (delete(testGroupEntries)
            ..where(
              (e) => e.groupId.equals(groupId) & e.testId.equals(testId),
            ))
          .go();

  /// Количество живых тестов в группе.
  Future<int> getTestCountByGroupId(String groupId) async {
    final count = countAll();
    final query = selectOnly(testGroupEntries).join([
      innerJoin(
        attachedDatabase.tests,
        attachedDatabase.tests.id.equalsExp(testGroupEntries.testId),
      ),
    ])
      ..addColumns([count])
      ..where(
        testGroupEntries.groupId.equals(groupId) &
            attachedDatabase.tests.deletedAt.isNull(),
      );
    final result = await query.getSingle();
    return result.read(count) ?? 0;
  }

  /// Обновить привязки теста к группам (в транзакции).
  Future<void> updateTestGroups(String testId, List<String> groupIds) =>
      transaction(() async {
        await (delete(testGroupEntries)..where((e) => e.testId.equals(testId)))
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
  Future<int> getGroupCountByTestId(String testId) async {
    final count = countAll();
    final query = selectOnly(testGroupEntries)
      ..addColumns([count])
      ..where(testGroupEntries.testId.equals(testId));
    final result = await query.getSingle();
    return result.read(count) ?? 0;
  }

  /// Группы, ожидающие отправки на бэкенд.
  Future<List<TestGroupDatabaseDto>> getPendingGroups() => (select(testGroups)
        ..where((g) => g.syncStatus.isIn(['pending', 'pending_restore'])))
      .get();

  /// Установить статус синхронизации.
  Future<int> setSyncStatus(String id, String status) =>
      (update(testGroups)..where((g) => g.id.equals(id)))
          .write(TestGroupsCompanion(syncStatus: Value(status)));

  /// Пометить все local-записи как pending (первый вход в аккаунт).
  Future<int> markAllLocalPending() =>
      (update(testGroups)..where((g) => g.syncStatus.equals('local')))
          .write(const TestGroupsCompanion(syncStatus: Value('pending')));

  /// Upsert из pull-синка.
  Future<void> upsertFromServer(TestGroupsCompanion group) =>
      into(testGroups).insertOnConflictUpdate(group);

  /// Stream, эмитящий при изменении таблиц групп или связей.
  Stream<void> watchGroupChanges() => Rx.merge([
        select(testGroups).watch().map((_) {}),
        select(testGroupEntries).watch().map((_) {}),
      ]);
}
