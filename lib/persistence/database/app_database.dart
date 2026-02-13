import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'package:quizzerg/feature/card_detail/data/database/cards_database.dart';
import 'package:quizzerg/feature/question_stats/data/database/question_stats_database.dart';
import 'package:quizzerg/feature/tests_list/data/database/tests_database.dart';

part 'app_database.g.dart';

/// Main application database using Drift.
@DriftDatabase(
  include: {
    'package:quizzerg/feature/tests_list/data/database/tests.drift',
    'package:quizzerg/feature/card_detail/data/database/cards.drift',
    'package:quizzerg/feature/question_stats/data/database/question_stats.drift',
  },
  daos: [TestsDatabase, CardsDatabase, QuestionStatsDatabase],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 2;

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
      },
    );
  }

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'karto4ki_db');
  }
}
