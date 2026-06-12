import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:quizzerg/feature/groups_list/data/database/groups_database.dart';
import 'package:quizzerg/feature/question_stats/data/database/answer_events_database.dart';
import 'package:quizzerg/feature/question_stats/data/database/question_stats_database.dart';
import 'package:quizzerg/feature/test_detail/data/database/cards_database.dart';
import 'package:quizzerg/feature/test_execution/data/database/active_sessions_database.dart';
import 'package:quizzerg/feature/tests_list/data/database/tests_database.dart';
import 'package:uuid/uuid.dart';

part 'app_database.g.dart';

/// Main application database using Drift.
@DriftDatabase(
  include: {
    'package:quizzerg/feature/tests_list/data/database/tests.drift',
    'package:quizzerg/feature/test_detail/data/database/cards.drift',
    'package:quizzerg/feature/question_stats/data/database/question_stats.drift',
    'package:quizzerg/feature/question_stats/data/database/answer_events.drift',
    'package:quizzerg/feature/groups_list/data/database/test_groups.drift',
    'package:quizzerg/feature/groups_list/data/database/test_group_entries.drift',
    'package:quizzerg/feature/test_execution/data/database/active_sessions.drift',
  },
  daos: [
    TestsDatabase,
    CardsDatabase,
    QuestionStatsDatabase,
    AnswerEventsDatabase,
    GroupsDatabase,
    ActiveSessionsDatabase,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 9;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {
        await m.createAll();
      },
      onUpgrade: (m, from, to) async {
        if (from < 2) {
          await m.createTable(questionStats);
          await customStatement(
            'CREATE INDEX IF NOT EXISTS idx_question_stats_streak '
            'ON question_stats(streak)',
          );
        }
        if (from < 3) {
          await customStatement(
            'ALTER TABLE question_stats ADD COLUMN total_shown INTEGER NOT NULL DEFAULT 0',
          );
          await customStatement(
            'UPDATE question_stats SET total_shown = total_correct + total_incorrect',
          );
        }
        if (from < 4) {
          await m.createTable(testGroups);
          await m.createTable(testGroupEntries);
          await customStatement(
            'INSERT INTO test_groups (title, created_at, updated_at) '
            "VALUES ('Мои тесты', strftime('%s', 'now'), strftime('%s', 'now'))",
          );
          await customStatement(
            'INSERT INTO test_group_entries (group_id, test_id) '
            'SELECT (SELECT id FROM test_groups LIMIT 1), id FROM tests',
          );
        }
        if (from < 5) {
          await customStatement(
            'UPDATE test_groups '
            "SET created_at = strftime('%s', created_at), "
            "    updated_at = strftime('%s', updated_at) "
            "WHERE typeof(created_at) = 'text' "
            "  AND created_at LIKE '____-__-__ __:__:__'",
          );
        }
        if (from < 6) {
          await customStatement(
            'ALTER TABLE question_stats ADD COLUMN last_shown_at DATETIME',
          );
          await customStatement(
            'UPDATE question_stats SET last_shown_at = last_answered_at '
            'WHERE last_answered_at IS NOT NULL',
          );
        }
        if (from < 7) {
          // Миграция: "яблоко (яблочко)" → "яблоко | яблочко"
          await customStatement(
            'UPDATE cards '
            "SET answer = TRIM(SUBSTR(answer, 1, INSTR(answer, '(') - 1))"
            " || ' | '"
            " || TRIM(SUBSTR(answer, INSTR(answer, '(') + 1,"
            " INSTR(answer, ')') - INSTR(answer, '(') - 1))"
            " WHERE answer LIKE '%(%)%'",
          );
          // Миграция: "яблоко - яблочко" → "яблоко | яблочко"
          await customStatement(
            'UPDATE cards '
            "SET answer = TRIM(SUBSTR(answer, 1, INSTR(answer, ' - ') - 1))"
            " || ' | '"
            " || TRIM(SUBSTR(answer, INSTR(answer, ' - ') + 3))"
            " WHERE answer LIKE '% - %'"
            " AND answer NOT LIKE '%|%'",
          );
        }
        if (from < 8) {
          await m.createTable(activeSessions);
        }
        if (from < 9) {
          await _migrateToUuidIds(m);
        }
      },
    );
  }

  /// v9: INTEGER AUTOINCREMENT id → клиентский TEXT UUID + колонки
  /// `sync_status`/`deleted_at` (offline-first синхронизация с бэкендом).
  ///
  /// SQLite не умеет менять тип колонки — таблицы пересоздаются, данные
  /// переносятся с маппингом старых int-id на новые UUID.
  Future<void> _migrateToUuidIds(Migrator m) async {
    const uuid = Uuid();

    await customStatement('PRAGMA foreign_keys = OFF');

    await customStatement('ALTER TABLE tests RENAME TO tests_old');
    await customStatement('ALTER TABLE cards RENAME TO cards_old');
    await customStatement('ALTER TABLE test_groups RENAME TO test_groups_old');
    await customStatement(
      'ALTER TABLE test_group_entries RENAME TO test_group_entries_old',
    );

    await m.createTable(tests);
    await m.createTable(cards);
    await m.createTable(testGroups);
    await m.createTable(testGroupEntries);
    await m.createTable(answerEvents);

    final testIds = <int, String>{};
    final groupIds = <int, String>{};

    final oldTests = await customSelect('SELECT * FROM tests_old').get();
    for (final row in oldTests) {
      final newId = uuid.v4();
      testIds[row.read<int>('id')] = newId;
      await customInsert(
        'INSERT INTO tests (id, title, description, type, created_at, updated_at) '
        'VALUES (?, ?, ?, ?, ?, ?)',
        variables: [
          Variable<String>(newId),
          Variable<String>(row.read<String>('title')),
          Variable<String>(row.readNullable<String>('description')),
          Variable<String>(row.read<String>('type')),
          Variable<int>(row.read<int>('created_at')),
          Variable<int>(row.read<int>('updated_at')),
        ],
      );
    }

    final oldGroups = await customSelect('SELECT * FROM test_groups_old').get();
    for (final row in oldGroups) {
      final newId = uuid.v4();
      groupIds[row.read<int>('id')] = newId;
      await customInsert(
        'INSERT INTO test_groups (id, title, created_at, updated_at) '
        'VALUES (?, ?, ?, ?)',
        variables: [
          Variable<String>(newId),
          Variable<String>(row.read<String>('title')),
          Variable<int>(row.read<int>('created_at')),
          Variable<int>(row.read<int>('updated_at')),
        ],
      );
    }

    final oldCards = await customSelect('SELECT * FROM cards_old').get();
    for (final row in oldCards) {
      final testId = testIds[row.read<int>('test_id')];
      if (testId == null) continue;
      await customInsert(
        'INSERT INTO cards (id, test_id, question, answer, created_at, updated_at) '
        'VALUES (?, ?, ?, ?, ?, ?)',
        variables: [
          Variable<String>(uuid.v4()),
          Variable<String>(testId),
          Variable<String>(row.read<String>('question')),
          Variable<String>(row.read<String>('answer')),
          Variable<int>(row.read<int>('created_at')),
          Variable<int>(row.read<int>('updated_at')),
        ],
      );
    }

    final oldEntries =
        await customSelect('SELECT * FROM test_group_entries_old').get();
    for (final row in oldEntries) {
      final groupId = groupIds[row.read<int>('group_id')];
      final testId = testIds[row.read<int>('test_id')];
      if (groupId == null || testId == null) continue;
      await customInsert(
        'INSERT OR IGNORE INTO test_group_entries (group_id, test_id) '
        'VALUES (?, ?)',
        variables: [
          Variable<String>(groupId),
          Variable<String>(testId),
        ],
      );
    }

    await customStatement('DROP TABLE test_group_entries_old');
    await customStatement('DROP TABLE cards_old');
    await customStatement('DROP TABLE tests_old');
    await customStatement('DROP TABLE test_groups_old');

    // Снапшот активной сессии ссылается на старые int-id — сбрасываем.
    await customStatement('DELETE FROM active_sessions');

    await customStatement('PRAGMA foreign_keys = ON');
  }

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'karto4ki_db');
  }
}
