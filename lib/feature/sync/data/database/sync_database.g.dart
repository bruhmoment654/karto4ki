// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_database.dart';

// ignore_for_file: type=lint
mixin _$SyncDatabaseMixin on DatabaseAccessor<AppDatabase> {
  SyncMeta get syncMeta => attachedDatabase.syncMeta;
  AnswerEventsOutbox get answerEventsOutbox =>
      attachedDatabase.answerEventsOutbox;
  SyncDatabaseManager get managers => SyncDatabaseManager(this);
}

class SyncDatabaseManager {
  final _$SyncDatabaseMixin _db;
  SyncDatabaseManager(this._db);
  $SyncMetaTableManager get syncMeta =>
      $SyncMetaTableManager(_db.attachedDatabase, _db.syncMeta);
  $AnswerEventsOutboxTableManager get answerEventsOutbox =>
      $AnswerEventsOutboxTableManager(
        _db.attachedDatabase,
        _db.answerEventsOutbox,
      );
}
