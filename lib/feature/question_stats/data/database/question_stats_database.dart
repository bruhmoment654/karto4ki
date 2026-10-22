import 'dart:math';

import 'package:drift/drift.dart';

import 'package:quizzerg/feature/sync/domain/entity/sync_state.dart';
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
          syncState: Value(SyncState.pending.dbValue),
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
          syncState: Value(SyncState.pending.dbValue),
        ),
      );
    }
  }

  /// Строки с неотправленными счётчиками.
  Future<List<QuestionStatsDatabaseDto>> getPendingStats({
    required int limit,
  }) =>
      (select(questionStats)
            ..where((t) => t.syncState.equals(SyncState.pending.dbValue))
            ..orderBy([(t) => OrderingTerm.asc(t.updatedAt)])
            ..limit(limit))
          .get();

  /// Сколько строк ждёт отправки.
  Future<int> countPendingStats() {
    final count = questionStats.id.count();
    final query = selectOnly(questionStats)
      ..addColumns([count])
      ..where(questionStats.syncState.equals(SyncState.pending.dbValue));

    return query.map((row) => row.read(count) ?? 0).getSingle();
  }

  /// Перевести все строки из [from] в [to].
  Future<void> replaceSyncState(SyncState from, SyncState to) =>
      (update(questionStats)..where((t) => t.syncState.equals(from.dbValue)))
          .write(QuestionStatsCompanion(syncState: Value(to.dbValue)));

  /// Пометить строку синхронизированной.
  Future<void> markSynced(String questionKey) =>
      (update(questionStats)..where((t) => t.questionKey.equals(questionKey)))
          .write(
        QuestionStatsCompanion(syncState: Value(SyncState.synced.dbValue)),
      );

  /// Влить серверный снимок статистики в локальную строку.
  ///
  /// Снимок не перезаписывает строку, а сливается с ней. Сервер считает
  /// счётчики только по событиям, которые до него дошли, а локально живёт
  /// вся история: ответы, записанные до появления outbox, и всё, что
  /// приехало из бэкапа старой версии. Перезапись обнуляла бы эту историю
  /// при первом же pull после ответа на вопрос.
  Future<void> applyServerSnapshot({
    required String questionKey,
    required String frontText,
    required String backText,
    required int streak,
    required int totalCorrect,
    required int totalIncorrect,
    required int totalShown,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? lastAnsweredAt,
    DateTime? lastShownAt,
  }) async {
    final existing = await getByQuestionKey(questionKey);

    if (existing == null) {
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
          createdAt: createdAt,
          updatedAt: updatedAt,
          syncState: Value(SyncState.synced.dbValue),
        ),
      );

      return;
    }

    await (update(questionStats)
          ..where((t) => t.questionKey.equals(questionKey)))
        .write(
      _merged(
        existing: existing,
        frontText: frontText,
        backText: backText,
        streak: streak,
        totalCorrect: totalCorrect,
        totalIncorrect: totalIncorrect,
        totalShown: totalShown,
        createdAt: createdAt,
        updatedAt: updatedAt,
        lastAnsweredAt: lastAnsweredAt,
        lastShownAt: lastShownAt,
      ),
    );
  }

  /// Строка, слитая из локальных счётчиков и серверного снимка.
  ///
  /// Счётчики берутся по максимуму: сервер не может знать меньше, чем
  /// реально было, а локальная строка — может знать больше. Стрик по
  /// максимуму брать нельзя, это длина серии, а не сумма: он приезжает из
  /// той версии, где ответ свежее.
  QuestionStatsCompanion _merged({
    required QuestionStatsDatabaseDto existing,
    required String frontText,
    required String backText,
    required int streak,
    required int totalCorrect,
    required int totalIncorrect,
    required int totalShown,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? lastAnsweredAt,
    DateTime? lastShownAt,
  }) {
    final correct = max(existing.totalCorrect, totalCorrect);
    final incorrect = max(existing.totalIncorrect, totalIncorrect);
    final shown = max(max(existing.totalShown, totalShown), correct + incorrect);
    final isServerFresher = _isAfter(lastAnsweredAt, existing.lastAnsweredAt);
    // Если после слияния ничего своего не осталось — серверу нечего досылать.
    final isServerComplete = correct == totalCorrect &&
        incorrect == totalIncorrect &&
        shown == totalShown &&
        !_isAfter(existing.lastAnsweredAt, lastAnsweredAt);

    return QuestionStatsCompanion(
      frontText: Value(frontText),
      backText: Value(backText),
      streak: Value(isServerFresher ? streak : existing.streak),
      totalCorrect: Value(correct),
      totalIncorrect: Value(incorrect),
      // Показов не может быть меньше, чем верных и неверных вместе.
      totalShown: Value(shown),
      lastAnsweredAt: Value(_latest(lastAnsweredAt, existing.lastAnsweredAt)),
      lastShownAt: Value(_latest(lastShownAt, existing.lastShownAt)),
      createdAt: Value(
        createdAt.isBefore(existing.createdAt) ? createdAt : existing.createdAt,
      ),
      updatedAt: Value(
        updatedAt.isAfter(existing.updatedAt) ? updatedAt : existing.updatedAt,
      ),
      syncState: Value(
        isServerComplete
            ? SyncState.synced.dbValue
            : SyncState.pending.dbValue,
      ),
    );
  }

  /// Свежее ли [candidate] относительно [current]. `null` не свежее ничего.
  bool _isAfter(DateTime? candidate, DateTime? current) {
    if (candidate == null) return false;

    return current == null || candidate.isAfter(current);
  }

  /// Позднейшая из двух дат; `null` считается «нет данных».
  DateTime? _latest(DateTime? first, DateTime? second) =>
      _isAfter(first, second) ? first : second;

  Future<List<QuestionStatsDatabaseDto>> getAllStats() =>
      (select(questionStats)..orderBy([(t) => OrderingTerm.desc(t.updatedAt)]))
          .get();

  /// Stream, эмитящий при любом изменении таблицы статистики.
  ///
  /// Нужен экранам: статистику пишет не только UI, но и pull синхронизации,
  /// и без подписки экран показывал бы снимок на момент открытия таба.
  Stream<void> watchStatsChanges() => select(questionStats).watch().map((_) {});

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
