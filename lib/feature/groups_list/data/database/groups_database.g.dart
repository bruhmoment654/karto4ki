// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'groups_database.dart';

// ignore_for_file: type=lint
mixin _$GroupsDatabaseMixin on DatabaseAccessor<AppDatabase> {
  TestGroups get testGroups => attachedDatabase.testGroups;
  Tests get tests => attachedDatabase.tests;
  TestGroupEntries get testGroupEntries => attachedDatabase.testGroupEntries;
  GroupsDatabaseManager get managers => GroupsDatabaseManager(this);
}

class GroupsDatabaseManager {
  final _$GroupsDatabaseMixin _db;
  GroupsDatabaseManager(this._db);
  $TestGroupsTableManager get testGroups =>
      $TestGroupsTableManager(_db.attachedDatabase, _db.testGroups);
  $TestsTableManager get tests =>
      $TestsTableManager(_db.attachedDatabase, _db.tests);
  $TestGroupEntriesTableManager get testGroupEntries =>
      $TestGroupEntriesTableManager(_db.attachedDatabase, _db.testGroupEntries);
}
