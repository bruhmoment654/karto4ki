import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'package:quizzerg/feature/groups_list/data/database/groups_database.dart';
import 'package:quizzerg/feature/question_stats/data/database/question_stats_database.dart';
import 'package:quizzerg/feature/sync/data/database/sync_database.dart';
import 'package:quizzerg/feature/test_detail/data/database/cards_database.dart';
import 'package:quizzerg/feature/test_execution/data/database/active_sessions_database.dart';
import 'package:quizzerg/feature/test_execution/data/database/test_attempts_database.dart';
import 'package:quizzerg/feature/tests_list/data/database/tests_database.dart';
import 'package:quizzerg/persistence/database/migration/uuid_migration_v9.dart';

part 'app_database.g.dart';

/// Main application database using Drift.
@DriftDatabase(
  include: {
    'package:quizzerg/feature/tests_list/data/database/tests.drift',
    'package:quizzerg/feature/test_detail/data/database/cards.drift',
    'package:quizzerg/feature/question_stats/data/database/question_stats.drift',
    'package:quizzerg/feature/groups_list/data/database/test_groups.drift',
    'package:quizzerg/feature/groups_list/data/database/test_group_entries.drift',
    'package:quizzerg/feature/test_execution/data/database/active_sessions.drift',
    'package:quizzerg/feature/sync/data/database/sync.drift',
    'package:quizzerg/feature/test_execution/data/database/test_attempts.drift',
  },
  daos: [
    TestsDatabase,
    CardsDatabase,
    QuestionStatsDatabase,
    GroupsDatabase,
    ActiveSessionsDatabase,
    SyncDatabase,
    TestAttemptsDatabase,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 11;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {
        await m.createAll();
      },
      onUpgrade: (m, from, to) async {
        // Колонка `question_stats.sync_state` относится к схеме 10, но
        // добавляется первой: миграция 8 → 9 вызывает `createAll`, а он
        // создаёт индексы актуальной схемы — включая индекс по этой колонке.
        if (from < 10) {
          await _addQuestionStatsSyncState();
        }
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
          await _createLegacyGroupTables();
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
          await _migrateLegacyAnswerSeparators();
        }
        if (from < 8) {
          await m.createTable(activeSessions);
        }
        if (from < 9) {
          await UuidMigrationV9(db: this, migrator: m).run();
        }
        if (from < 11) {
          await _createTestAttemptTables(m);
        }
      },
    );
  }

  /// Схема 9 → 10: статистика стала pushable, ей понадобился `sync_state`.
  ///
  /// Существующие строки получают `pending`: история, накопленная до журнала
  /// ответов, живёт только на устройстве, и первый push отдаёт её серверу.
  /// Шаг идемпотентен — на пути с ранних схем таблицу создаёт `createTable`
  /// уже с колонкой, и второй раз добавлять её нельзя.
  Future<void> _addQuestionStatsSyncState() async {
    final hasTable = await customSelect(
      "SELECT 1 FROM sqlite_master WHERE type = 'table' "
      "AND name = 'question_stats'",
    ).getSingleOrNull();
    // Таблицы ещё нет — её создаст миграция 1 → 2 сразу с колонкой.
    if (hasTable == null) return;

    final hasColumn = await customSelect(
      "SELECT 1 FROM pragma_table_info('question_stats') "
      "WHERE name = 'sync_state'",
    ).getSingleOrNull();
    if (hasColumn != null) return;

    await customStatement(
      'ALTER TABLE question_stats '
      "ADD COLUMN sync_state TEXT NOT NULL DEFAULT 'pending'",
    );
  }

  /// Схема 10 → 11: история прохождений тестов.
  ///
  /// Миграция 8 → 9 вызывает `createAll`, который уже создаёт таблицы
  /// актуальной схемы, поэтому на пути с ранних схем создаём их только
  /// при отсутствии.
  Future<void> _createTestAttemptTables(Migrator migrator) async {
    for (final table in <TableInfo<Table, Object?>>[
      testAttempts,
      testAttemptAnswers,
    ]) {
      final exists = await customSelect(
        "SELECT 1 FROM sqlite_master WHERE type = 'table' AND name = ?",
        variables: [Variable.withString(table.actualTableName)],
      ).getSingleOrNull();
      if (exists == null) await migrator.createTable(table);
    }
    await migrator.createIndex(idxTestAttemptsTest);
    await migrator.createIndex(idxTestAttemptAnswersAttempt);
  }

  /// Схема 3 → 4: группы тестов появились с int-идентификаторами.
  ///
  /// Таблицы создаются сырым SQL: актуальная схема уже на uuid,
  /// а миграция 8 → 9 ниже ждёт именно старый вид таблиц.
  Future<void> _createLegacyGroupTables() async {
    await customStatement(
      'CREATE TABLE IF NOT EXISTS test_groups ( '
      'id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, '
      'title TEXT NOT NULL, '
      'created_at DATETIME NOT NULL, '
      'updated_at DATETIME NOT NULL)',
    );
    await customStatement(
      'CREATE TABLE IF NOT EXISTS test_group_entries ( '
      'id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, '
      'group_id INTEGER NOT NULL REFERENCES test_groups(id) ON DELETE CASCADE, '
      'test_id INTEGER NOT NULL REFERENCES tests(id) ON DELETE CASCADE, '
      'UNIQUE(group_id, test_id))',
    );
    await customStatement(
      'INSERT INTO test_groups (title, created_at, updated_at) '
      "VALUES ('Мои тесты', strftime('%s', 'now'), strftime('%s', 'now'))",
    );
    await customStatement(
      'INSERT INTO test_group_entries (group_id, test_id) '
      'SELECT (SELECT id FROM test_groups LIMIT 1), id FROM tests',
    );
  }

  /// Схема 6 → 7: legacy-разделители вариантов ответа приводятся к `|`.
  Future<void> _migrateLegacyAnswerSeparators() async {
    // "яблоко (яблочко)" → "яблоко | яблочко"
    await customStatement(
      'UPDATE cards '
      "SET answer = TRIM(SUBSTR(answer, 1, INSTR(answer, '(') - 1))"
      " || ' | '"
      " || TRIM(SUBSTR(answer, INSTR(answer, '(') + 1,"
      " INSTR(answer, ')') - INSTR(answer, '(') - 1))"
      " WHERE answer LIKE '%(%)%'",
    );
    // "яблоко - яблочко" → "яблоко | яблочко"
    await customStatement(
      'UPDATE cards '
      "SET answer = TRIM(SUBSTR(answer, 1, INSTR(answer, ' - ') - 1))"
      " || ' | '"
      " || TRIM(SUBSTR(answer, INSTR(answer, ' - ') + 3))"
      " WHERE answer LIKE '% - %'"
      " AND answer NOT LIKE '%|%'",
    );
  }

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'karto4ki_db');
  }
}
