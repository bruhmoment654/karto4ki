import 'package:drift/drift.dart';

import 'package:quizzerg/feature/sync/domain/entity/sync_state.dart';
import 'package:quizzerg/persistence/database/app_database.dart';

part 'tests_database.g.dart';

/// Data Access Object for Tests table.
///
/// Все чтения отфильтрованы по `deleted_at IS NULL`: удалённая строка живёт
/// как tombstone до подтверждённого push и в UI попадать не должна.
@DriftAccessor(
  include: {'package:quizzerg/feature/tests_list/data/database/tests.drift'},
)
class TestsDatabase extends DatabaseAccessor<AppDatabase>
    with _$TestsDatabaseMixin {
  TestsDatabase(super.attachedDatabase);

  /// Get all tests.
  Future<List<TestDatabaseDto>> getAllTests() => _alive().get();

  /// Get test by id.
  Future<TestDatabaseDto?> getTestById(String id) =>
      (_alive()..where((tbl) => tbl.id.equals(id))).getSingleOrNull();

  /// Watch all tests.
  Stream<List<TestDatabaseDto>> watchAllTests() => _alive().watch();

  /// Watch test by id.
  Stream<TestDatabaseDto?> watchTestById(String id) =>
      (_alive()..where((tbl) => tbl.id.equals(id))).watchSingleOrNull();

  /// Insert a new test.
  Future<void> insertTest(TestsCompanion test) => into(tests).insert(test);

  /// Обновить тест и пометить строку неотправленной.
  Future<void> updateTest(TestsCompanion test) async {
    final id = test.id.value;
    await (update(tests)..where((tbl) => tbl.id.equals(id))).write(
      test.copyWith(
        updatedAt: Value(DateTime.now().toUtc()),
        syncState: Value(SyncState.pending.dbValue),
      ),
    );
  }

  /// Пометить тест изменённым, не трогая его поля.
  ///
  /// Нужен при правке связей с группами: набор групп едет на сервер
  /// внутри payload теста, поэтому неотправленным становится сам тест.
  Future<void> touchTest(String id) async {
    await (update(tests)..where((tbl) => tbl.id.equals(id))).write(
      TestsCompanion(
        updatedAt: Value(DateTime.now().toUtc()),
        syncState: Value(SyncState.pending.dbValue),
      ),
    );
  }

  /// Пометить тест удалённым (tombstone).
  ///
  /// Физическое удаление запрещено: без строки нечего пушить как `delete`,
  /// и сущность вернётся с сервера при следующем pull.
  Future<void> softDeleteTestById(String id) async {
    final now = DateTime.now().toUtc();
    await (update(tests)..where((tbl) => tbl.id.equals(id))).write(
      TestsCompanion(
        deletedAt: Value(now),
        updatedAt: Value(now),
        syncState: Value(SyncState.pending.dbValue),
      ),
    );
  }

  /// Физически удалить строку. Только для подтверждённых сервером tombstone.
  Future<int> purgeTestById(String id) =>
      (delete(tests)..where((tbl) => tbl.id.equals(id))).go();

  /// Все тесты, включая tombstone.
  Future<List<TestDatabaseDto>> getAllTestsRaw() => select(tests).get();

  /// Строка по id без фильтра по tombstone.
  Future<TestDatabaseDto?> getTestByIdRaw(String id) =>
      (select(tests)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();

  /// Тесты с неотправленными изменениями.
  Future<List<TestDatabaseDto>> getPendingTests({required int limit}) =>
      (select(tests)
            ..where((tbl) => tbl.syncState.equals(SyncState.pending.dbValue))
            ..orderBy([(tbl) => OrderingTerm.asc(tbl.updatedAt)])
            ..limit(limit))
          .get();

  /// Сколько строк ждёт отправки.
  Future<int> countPendingTests() {
    final count = tests.id.count();
    final query = selectOnly(tests)
      ..addColumns([count])
      ..where(tests.syncState.equals(SyncState.pending.dbValue));

    return query.map((row) => row.read(count) ?? 0).getSingle();
  }

  /// Записать строку целиком (upsert из серверного снимка).
  Future<void> upsertTest(TestsCompanion test) =>
      into(tests).insertOnConflictUpdate(test);

  /// Обновить служебные поля синхронизации.
  ///
  /// [notNewerThan] защищает от гонки «правка во время push»: если строку
  /// успели изменить после отправки, помечать её синхронизированной нельзя.
  Future<void> writeSyncFields(
    String id,
    TestsCompanion fields, {
    DateTime? notNewerThan,
  }) =>
      (update(tests)
            ..where(
              (tbl) => notNewerThan == null
                  ? tbl.id.equals(id)
                  : tbl.id.equals(id) &
                      tbl.updatedAt.isSmallerOrEqualValue(notNewerThan),
            ))
          .write(fields);

  /// Delete all tests.
  Future<int> deleteAllTests() => delete(tests).go();

  SimpleSelectStatement<Tests, TestDatabaseDto> _alive() =>
      select(tests)..where((tbl) => tbl.deletedAt.isNull());
}
