// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'active_sessions_database.dart';

// ignore_for_file: type=lint
mixin _$ActiveSessionsDatabaseMixin on DatabaseAccessor<AppDatabase> {
  ActiveSessions get activeSessions => attachedDatabase.activeSessions;
  ActiveSessionsDatabaseManager get managers =>
      ActiveSessionsDatabaseManager(this);
}

class ActiveSessionsDatabaseManager {
  final _$ActiveSessionsDatabaseMixin _db;
  ActiveSessionsDatabaseManager(this._db);
  $ActiveSessionsTableManager get activeSessions =>
      $ActiveSessionsTableManager(_db.attachedDatabase, _db.activeSessions);
}
