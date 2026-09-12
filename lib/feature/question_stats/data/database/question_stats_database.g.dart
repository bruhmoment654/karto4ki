// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_stats_database.dart';

// ignore_for_file: type=lint
mixin _$QuestionStatsDatabaseMixin on DatabaseAccessor<AppDatabase> {
  QuestionStats get questionStats => attachedDatabase.questionStats;
  QuestionStatsDatabaseManager get managers =>
      QuestionStatsDatabaseManager(this);
}

class QuestionStatsDatabaseManager {
  final _$QuestionStatsDatabaseMixin _db;
  QuestionStatsDatabaseManager(this._db);
  $QuestionStatsTableManager get questionStats =>
      $QuestionStatsTableManager(_db.attachedDatabase, _db.questionStats);
}
