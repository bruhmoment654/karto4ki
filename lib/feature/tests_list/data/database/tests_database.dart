import 'package:drift/drift.dart';

import 'package:quizzerg/persistence/database/app_database.dart';

part 'tests_database.g.dart';

/// Data Access Object for Tests table.
@DriftAccessor(
  include: {'package:quizzerg/feature/tests_list/data/database/tests.drift'},
)
class TestsDatabase extends DatabaseAccessor<AppDatabase>
    with _$TestsDatabaseMixin {
  TestsDatabase(super.attachedDatabase);

  /// Get all tests (включая soft-deleted — для UI «Удалён» и синка).
  Future<List<TestDatabaseDto>> getAllTests() => select(tests).get();

  /// Get all alive (not soft-deleted) tests.
  Future<List<TestDatabaseDto>> getAliveTests() =>
      (select(tests)..where((t) => t.deletedAt.isNull())).get();

  /// Get test by id.
  Future<TestDatabaseDto?> getTestById(String id) =>
      (select(tests)..where((t) => t.id.equals(id))).getSingleOrNull();

  /// Watch all alive tests.
  Stream<List<TestDatabaseDto>> watchAllTests() =>
      (select(tests)..where((t) => t.deletedAt.isNull())).watch();

  /// Watch test by id.
  Stream<TestDatabaseDto?> watchTestById(String id) =>
      (select(tests)..where((t) => t.id.equals(id))).watchSingleOrNull();

  /// Insert a new test.
  Future<void> insertTest(TestsCompanion test) => into(tests).insert(test);

  /// Update an existing test.
  Future<bool> updateTest(TestDatabaseDto test) => update(tests).replace(test);

  /// Soft delete: пометить тест удалённым и ожидающим отправки на бэкенд.
  Future<int> softDeleteTestById(String id) =>
      (update(tests)..where((t) => t.id.equals(id))).write(
        TestsCompanion(
          deletedAt: Value(DateTime.now()),
          syncStatus: const Value('pending'),
          updatedAt: Value(DateTime.now()),
        ),
      );

  /// Restore: снять метку удаления, пометить ожидающим восстановления.
  Future<int> restoreTestById(String id) =>
      (update(tests)..where((t) => t.id.equals(id))).write(
        TestsCompanion(
          deletedAt: const Value(null),
          syncStatus: const Value('pending_restore'),
          updatedAt: Value(DateTime.now()),
        ),
      );

  /// Физически удалить тест (после подтверждения бэкендом или для purge).
  Future<int> hardDeleteTestById(String id) =>
      (delete(tests)..where((t) => t.id.equals(id))).go();

  /// Delete all tests.
  Future<int> deleteAllTests() => delete(tests).go();

  /// Тесты, ожидающие отправки на бэкенд.
  Future<List<TestDatabaseDto>> getPendingTests() => (select(tests)
        ..where((t) => t.syncStatus.isIn(['pending', 'pending_restore'])))
      .get();

  /// Установить статус синхронизации.
  Future<int> setSyncStatus(String id, String status) =>
      (update(tests)..where((t) => t.id.equals(id)))
          .write(TestsCompanion(syncStatus: Value(status)));

  /// Пометить все local-записи как pending (первый вход в аккаунт).
  Future<int> markAllLocalPending() =>
      (update(tests)..where((t) => t.syncStatus.equals('local')))
          .write(const TestsCompanion(syncStatus: Value('pending')));

  /// Upsert из pull-синка (запись приходит с бэкенда уже синхронизированной).
  Future<void> upsertFromServer(TestsCompanion test) =>
      into(tests).insertOnConflictUpdate(test);
}
