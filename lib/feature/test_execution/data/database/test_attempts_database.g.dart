// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_attempts_database.dart';

// ignore_for_file: type=lint
mixin _$TestAttemptsDatabaseMixin on DatabaseAccessor<AppDatabase> {
  TestAttempts get testAttempts => attachedDatabase.testAttempts;
  TestAttemptAnswers get testAttemptAnswers =>
      attachedDatabase.testAttemptAnswers;
  TestAttemptsDatabaseManager get managers => TestAttemptsDatabaseManager(this);
}

class TestAttemptsDatabaseManager {
  final _$TestAttemptsDatabaseMixin _db;
  TestAttemptsDatabaseManager(this._db);
  $TestAttemptsTableManager get testAttempts =>
      $TestAttemptsTableManager(_db.attachedDatabase, _db.testAttempts);
  $TestAttemptAnswersTableManager get testAttemptAnswers =>
      $TestAttemptAnswersTableManager(
        _db.attachedDatabase,
        _db.testAttemptAnswers,
      );
}
