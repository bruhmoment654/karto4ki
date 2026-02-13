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

  /// Get all tests.
  Future<List<TestDatabaseDto>> getAllTests() => select(tests).get();

  /// Get test by id.
  Future<TestDatabaseDto?> getTestById(int id) =>
      (select(tests)..where((t) => t.id.equals(id))).getSingleOrNull();

  /// Watch all tests.
  Stream<List<TestDatabaseDto>> watchAllTests() => select(tests).watch();

  /// Watch test by id.
  Stream<TestDatabaseDto?> watchTestById(int id) =>
      (select(tests)..where((t) => t.id.equals(id))).watchSingleOrNull();

  /// Insert a new test.
  Future<int> insertTest(TestsCompanion test) => into(tests).insert(test);

  /// Update an existing test.
  Future<bool> updateTest(TestDatabaseDto test) => update(tests).replace(test);

  /// Delete a test by id.
  Future<int> deleteTestById(int id) =>
      (delete(tests)..where((t) => t.id.equals(id))).go();

  /// Delete all tests.
  Future<int> deleteAllTests() => delete(tests).go();
}
