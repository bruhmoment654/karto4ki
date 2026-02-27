import 'package:drift/drift.dart';

import 'package:quizzerg/persistence/database/app_database.dart';

part 'question_stats_database.g.dart';

@DriftAccessor(
  include: {
    'package:quizzerg/feature/question_stats/data/database/question_stats.drift',
  },
)
class QuestionStatsDatabase extends DatabaseAccessor<AppDatabase>
    with _$QuestionStatsDatabaseMixin {
  QuestionStatsDatabase(super.attachedDatabase);

  Future<QuestionStatsDatabaseDto?> getByQuestionKey(String key) =>
      (select(questionStats)..where((t) => t.questionKey.equals(key)))
          .getSingleOrNull();

  Future<List<QuestionStatsDatabaseDto>> getLeastRemembered(int limit) =>
      (select(questionStats)
            ..orderBy([
              (t) => OrderingTerm.asc(t.streak),
              (t) => OrderingTerm.desc(t.totalIncorrect),
            ])
            ..limit(limit))
          .get();

  Future<void> upsertStat({
    required String questionKey,
    required String frontText,
    required String backText,
    required bool isCorrect,
  }) async {
    final now = DateTime.now();
    final existing = await getByQuestionKey(questionKey);

    if (existing != null) {
      await (update(questionStats)
            ..where((t) => t.questionKey.equals(questionKey)))
          .write(
        QuestionStatsCompanion(
          frontText: Value(frontText),
          backText: Value(backText),
          streak: Value(existing.streak + (isCorrect ? 1 : -1)),
          totalCorrect: Value(
            existing.totalCorrect + (isCorrect ? 1 : 0),
          ),
          totalIncorrect: Value(
            existing.totalIncorrect + (isCorrect ? 0 : 1),
          ),
          totalShown: Value(existing.totalShown + 1),
          lastAnsweredAt: Value(now),
          lastShownAt: Value(now),
          updatedAt: Value(now),
        ),
      );
    } else {
      await into(questionStats).insert(
        QuestionStatsCompanion.insert(
          questionKey: questionKey,
          frontText: frontText,
          backText: backText,
          streak: Value(isCorrect ? 1 : -1),
          totalCorrect: Value(isCorrect ? 1 : 0),
          totalIncorrect: Value(isCorrect ? 0 : 1),
          totalShown: const Value(1),
          lastAnsweredAt: Value(now),
          lastShownAt: Value(now),
          createdAt: now,
          updatedAt: now,
        ),
      );
    }
  }

  Future<List<QuestionStatsDatabaseDto>> getStatsByKeys(
    List<String> keys,
  ) =>
      (select(questionStats)..where((t) => t.questionKey.isIn(keys))).get();

  Future<void> upsertStats(
    List<
            ({
              String questionKey,
              String frontText,
              String backText,
              bool isCorrect
            })>
        results,
  ) async {
    await transaction(() async {
      for (final result in results) {
        await upsertStat(
          questionKey: result.questionKey,
          frontText: result.frontText,
          backText: result.backText,
          isCorrect: result.isCorrect,
        );
      }
    });
  }
}
