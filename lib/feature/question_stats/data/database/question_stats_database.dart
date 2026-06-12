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

  Future<List<QuestionStatsDatabaseDto>> getAllStats() =>
      (select(questionStats)..orderBy([(t) => OrderingTerm.desc(t.updatedAt)]))
          .get();

  /// Возвращает отсортированный список уникальных дат (time = 00:00),
  /// в которые был зафиксирован хотя бы один ответ (`last_answered_at`).
  Future<List<DateTime>> getActiveDates() async {
    final query = selectOnly(questionStats, distinct: true)
      ..addColumns([questionStats.lastAnsweredAt])
      ..where(questionStats.lastAnsweredAt.isNotNull());
    final rows = await query.get();
    final dates = <DateTime>{};
    for (final row in rows) {
      final value = row.read(questionStats.lastAnsweredAt);
      if (value == null) continue;
      dates.add(DateTime(value.year, value.month, value.day));
    }
    final result = dates.toList()..sort();
    return result;
  }

  Future<List<QuestionStatsDatabaseDto>> getStatsByKeys(
    List<String> keys,
  ) =>
      (select(questionStats)..where((t) => t.questionKey.isIn(keys))).get();

  /// Применить агрегат, пришедший с бэкенда (pull-синк).
  ///
  /// Серверные агрегаты авторитетны: включают события всех источников
  /// (МП, MCP), поэтому локальные значения перезаписываются целиком.
  Future<void> upsertFromServer({
    required String questionKey,
    required String frontText,
    required String backText,
    required int streak,
    required int totalCorrect,
    required int totalIncorrect,
    required int totalShown,
    DateTime? lastAnsweredAt,
    DateTime? lastShownAt,
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
          streak: Value(streak),
          totalCorrect: Value(totalCorrect),
          totalIncorrect: Value(totalIncorrect),
          totalShown: Value(totalShown),
          lastAnsweredAt: Value(lastAnsweredAt),
          lastShownAt: Value(lastShownAt),
          updatedAt: Value(now),
        ),
      );
    } else {
      await into(questionStats).insert(
        QuestionStatsCompanion.insert(
          questionKey: questionKey,
          frontText: frontText,
          backText: backText,
          streak: Value(streak),
          totalCorrect: Value(totalCorrect),
          totalIncorrect: Value(totalIncorrect),
          totalShown: Value(totalShown),
          lastAnsweredAt: Value(lastAnsweredAt),
          lastShownAt: Value(lastShownAt),
          createdAt: now,
          updatedAt: now,
        ),
      );
    }
  }

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
