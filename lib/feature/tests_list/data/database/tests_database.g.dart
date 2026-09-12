// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tests_database.dart';

// ignore_for_file: type=lint
mixin _$TestsDatabaseMixin on DatabaseAccessor<AppDatabase> {
  Tests get tests => attachedDatabase.tests;
  TestsDatabaseManager get managers => TestsDatabaseManager(this);
}

class TestsDatabaseManager {
  final _$TestsDatabaseMixin _db;
  TestsDatabaseManager(this._db);
  $TestsTableManager get tests =>
      $TestsTableManager(_db.attachedDatabase, _db.tests);
}
