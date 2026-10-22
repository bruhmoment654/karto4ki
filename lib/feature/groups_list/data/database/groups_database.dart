import 'package:drift/drift.dart';
import 'package:quizzerg/core/utils/uuid_generator.dart';
import 'package:quizzerg/feature/sync/domain/entity/sync_state.dart';
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
  Future<List<TestGroupDatabaseDto>> getAllGroups() => _alive().get();

  /// Получить группу по id.
  Future<TestGroupDatabaseDto?> getGroupById(String id) =>
      (_alive()..where((tbl) => tbl.id.equals(id))).getSingleOrNull();

  /// Вставить новую группу.
  Future<void> insertGroup(TestGroupsCompanion group) =>
      into(testGroups).insert(group);

  /// Обновить группу и пометить строку неотправленной.
  Future<void> updateGroup(TestGroupsCompanion group) async {
    final id = group.id.value;
    await (update(testGroups)..where((tbl) => tbl.id.equals(id))).write(
      group.copyWith(
        updatedAt: Value(DateTime.now().toUtc()),
        syncState: Value(SyncState.pending.dbValue),
      ),
    );
  }

  /// Пометить группу удалённой (tombstone). Связи с тестами снимаются сразу:
  /// на сервере удаление группы тоже чистит связи, сами тесты остаются.
  Future<void> softDeleteGroupById(String id) async {
    final now = DateTime.now().toUtc();
    await transaction(() async {
      await (update(testGroups)..where((tbl) => tbl.id.equals(id))).write(
        TestGroupsCompanion(
          deletedAt: Value(now),
          updatedAt: Value(now),
          syncState: Value(SyncState.pending.dbValue),
        ),
      );
      await (delete(testGroupEntries)
            ..where((entry) => entry.groupId.equals(id)))
          .go();
    });
  }

  /// Физически удалить строку. Только для подтверждённых сервером tombstone.
  Future<int> purgeGroupById(String id) =>
      (delete(testGroups)..where((tbl) => tbl.id.equals(id))).go();

  /// Строка по id без фильтра по tombstone.
  Future<TestGroupDatabaseDto?> getGroupByIdRaw(String id) =>
      (select(testGroups)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();

  /// Группы с неотправленными изменениями.
  Future<List<TestGroupDatabaseDto>> getPendingGroups({required int limit}) =>
      (select(testGroups)
            ..where((tbl) => tbl.syncState.equals(SyncState.pending.dbValue))
            ..orderBy([(tbl) => OrderingTerm.asc(tbl.updatedAt)])
            ..limit(limit))
          .get();

  /// Сколько строк ждёт отправки.
  Future<int> countPendingGroups() {
    final count = testGroups.id.count();
    final query = selectOnly(testGroups)
      ..addColumns([count])
      ..where(testGroups.syncState.equals(SyncState.pending.dbValue));

    return query.map((row) => row.read(count) ?? 0).getSingle();
  }

  /// Перевести все строки из [from] в [to].
  Future<void> replaceSyncState(SyncState from, SyncState to) =>
      (update(testGroups)..where((tbl) => tbl.syncState.equals(from.dbValue)))
          .write(TestGroupsCompanion(syncState: Value(to.dbValue)));

  /// Записать строку целиком (upsert из серверного снимка).
  Future<void> upsertGroup(TestGroupsCompanion group) =>
      into(testGroups).insertOnConflictUpdate(group);

  /// Обновить служебные поля синхронизации.
  ///
  /// [notNewerThan] защищает от гонки «правка во время push»: если строку
  /// успели изменить после отправки, помечать её синхронизированной нельзя.
  Future<void> writeSyncFields(
    String id,
    TestGroupsCompanion fields, {
    DateTime? notNewerThan,
  }) =>
      (update(testGroups)
            ..where(
              (tbl) => notNewerThan == null
                  ? tbl.id.equals(id)
                  : tbl.id.equals(id) &
                      tbl.updatedAt.isSmallerOrEqualValue(notNewerThan),
            ))
          .write(fields);

  /// Получить id тестов в группе.
  Future<List<String>> getTestIdsByGroupId(String groupId) async {
    final entries = await (select(testGroupEntries)
          ..where((entry) => entry.groupId.equals(groupId)))
        .get();
    return entries.map((entry) => entry.testId).toList();
  }

  /// Все связи разом: id группы → id её тестов.
  Future<Map<String, List<String>>> getTestIdsByGroup() async {
    final entries = await select(testGroupEntries).get();
    final result = <String, List<String>>{};
    for (final entry in entries) {
      (result[entry.groupId] ??= []).add(entry.testId);
    }
    return result;
  }

  /// Получить id групп, в которых состоит тест.
  Future<List<String>> getGroupIdsByTestId(String testId) async {
    final entries = await (select(testGroupEntries)
          ..where((entry) => entry.testId.equals(testId)))
        .get();
    return entries.map((entry) => entry.groupId).toList();
  }

  /// Добавить тест в группу (игнорировать если уже есть).
  Future<void> addTestToGroup(String groupId, String testId) =>
      into(testGroupEntries).insert(
        TestGroupEntriesCompanion.insert(
          id: UuidGenerator.v7(),
          groupId: groupId,
          testId: testId,
        ),
        mode: InsertMode.insertOrIgnore,
      );

  /// Убрать тест из группы.
  Future<int> removeTestFromGroup(String groupId, String testId) =>
      (delete(testGroupEntries)
            ..where(
              (entry) =>
                  entry.groupId.equals(groupId) & entry.testId.equals(testId),
            ))
          .go();

  /// Количество тестов в группе (tombstone не считаем).
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
        await (delete(testGroupEntries)
              ..where((entry) => entry.testId.equals(testId)))
            .go();
        for (final groupId in groupIds) {
          await into(testGroupEntries).insert(
            TestGroupEntriesCompanion.insert(
              id: UuidGenerator.v7(),
              groupId: groupId,
              testId: testId,
            ),
            mode: InsertMode.insertOrIgnore,
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

  /// Stream, эмитящий при изменении таблиц групп, связей, а также
  /// карточек, статистики и прохождений — из них считается прогресс групп
  /// и тестов.
  Stream<void> watchGroupChanges() => Rx.merge([
        select(testGroups).watch().map((_) {}),
        select(testGroupEntries).watch().map((_) {}),
        attachedDatabase
            .tableUpdates(
              TableUpdateQuery.onAllTables([
                attachedDatabase.tests,
                attachedDatabase.cards,
                attachedDatabase.questionStats,
                attachedDatabase.testAttempts,
              ]),
            )
            .map((_) {}),
      ]);

  SimpleSelectStatement<TestGroups, TestGroupDatabaseDto> _alive() =>
      select(testGroups)..where((tbl) => tbl.deletedAt.isNull());
}
