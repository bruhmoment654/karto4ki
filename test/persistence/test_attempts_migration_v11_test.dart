import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quizzerg/persistence/database/app_database.dart';
import 'package:sqlite3/sqlite3.dart' as raw;

/// База схемы 10: актуальная схема без таблиц истории прохождений.
Future<File> _createSchema10Database() async {
  final directory = Directory.systemTemp.createTempSync('karto4ki_v11_');
  final file = File('${directory.path}/v10.sqlite');

  final current = AppDatabase.forTesting(NativeDatabase(file));
  await current.customSelect('SELECT 1').get();
  await current.close();

  raw.sqlite3.open(file.path)
    ..execute('DROP INDEX idx_test_attempt_answers_attempt')
    ..execute('DROP INDEX idx_test_attempts_test')
    ..execute('DROP TABLE test_attempt_answers')
    ..execute('DROP TABLE test_attempts')
    ..execute("INSERT INTO active_sessions (id, data) VALUES (1, '{}')")
    ..execute('PRAGMA user_version = 10')
    ..close();

  return file;
}

void main() {
  test('10 → 11: таблицы истории созданы, прежние данные на месте', () async {
    final file = await _createSchema10Database();
    final database = AppDatabase.forTesting(NativeDatabase(file));
    addTearDown(database.close);

    final tables = await database
        .customSelect(
          "SELECT name FROM sqlite_master WHERE type IN ('table', 'index') "
          "AND name LIKE '%test_attempt%'",
        )
        .map((row) => row.read<String>('name'))
        .get();
    final sessions = await database.select(database.activeSessions).get();

    expect(
      tables,
      containsAll([
        'test_attempts',
        'test_attempt_answers',
        'idx_test_attempts_test',
        'idx_test_attempt_answers_attempt',
      ]),
    );
    expect(sessions, hasLength(1));
  });
}
