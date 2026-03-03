import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'package:quizzerg/feature/groups_list/data/database/groups_database.dart';
import 'package:quizzerg/feature/question_stats/data/database/question_stats_database.dart';
import 'package:quizzerg/feature/test_detail/data/database/cards_database.dart';
import 'package:quizzerg/feature/tests_list/data/database/tests_database.dart';

part 'app_database.g.dart';

/// Main application database using Drift.
@DriftDatabase(
  include: {
    'package:quizzerg/feature/tests_list/data/database/tests.drift',
    'package:quizzerg/feature/test_detail/data/database/cards.drift',
    'package:quizzerg/feature/question_stats/data/database/question_stats.drift',
    'package:quizzerg/feature/groups_list/data/database/test_groups.drift',
    'package:quizzerg/feature/groups_list/data/database/test_group_entries.drift',
  },
  daos: [TestsDatabase, CardsDatabase, QuestionStatsDatabase, GroupsDatabase],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 6;

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
      },
    );
  }

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'karto4ki_db');
  }
}
