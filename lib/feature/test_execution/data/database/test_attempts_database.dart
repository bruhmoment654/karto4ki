import 'package:drift/drift.dart';

import 'package:quizzerg/persistence/database/app_database.dart';

part 'test_attempts_database.g.dart';

/// DAO истории прохождений тестов.
@DriftAccessor(
  include: {
    'package:quizzerg/feature/test_execution/data/database/test_attempts.drift',
  },
)
class TestAttemptsDatabase extends DatabaseAccessor<AppDatabase>
    with _$TestAttemptsDatabaseMixin {
  TestAttemptsDatabase(super.attachedDatabase);

  /// Записать прохождение вместе с ответами.
  ///
  /// Уже записанное прохождение (тот же `id`) не трогает и возвращает
  /// `false` — так повторная запись восстановленной сессии не задвоит ответы.
  Future<bool> insertAttempt({
    required TestAttemptsCompanion attempt,
    required List<TestAttemptAnswersCompanion> answers,
  }) => transaction(() async {
    final id = attempt.id.value;
    final existing = await (select(
      testAttempts,
    )..where((row) => row.id.equals(id))).getSingleOrNull();
    if (existing != null) return false;

    await into(testAttempts).insert(attempt);
    await batch((batch) => batch.insertAll(testAttemptAnswers, answers));
    return true;
  });

  /// Удалить ответы всех прохождений теста, кроме [keep] последних.
  ///
  /// Сами прохождения остаются: строка маленькая, а по ним считается,
  /// сколько раз тест пройден. Порядок — как в [getRecentAttempts].
  Future<int> deleteAnswersBeyond(String testId, {required int keep}) =>
      customUpdate(
        'DELETE FROM test_attempt_answers WHERE attempt_id IN ( '
        'SELECT id FROM test_attempts WHERE test_id = ? '
        'ORDER BY completed_at DESC, started_at DESC LIMIT -1 OFFSET ?)',
        variables: [Variable.withString(testId), Variable.withInt(keep)],
        updates: {testAttemptAnswers},
        updateKind: UpdateKind.delete,
      );

  /// Последние [limit] прохождений теста, от свежих к старым.
  Future<List<TestAttemptDatabaseDto>> getRecentAttempts(
    String testId, {
    required int limit,
  }) =>
      (select(testAttempts)
            ..where((row) => row.testId.equals(testId))
            ..orderBy([
              (row) => OrderingTerm.desc(row.completedAt),
              (row) => OrderingTerm.desc(row.startedAt),
            ])
            ..limit(limit))
          .get();

  /// Сколько раз тест пройден.
  Future<int> countAttempts(String testId) {
    final count = testAttempts.id.count();
    final query = selectOnly(testAttempts)
      ..addColumns([count])
      ..where(testAttempts.testId.equals(testId));

    return query.map((row) => row.read(count) ?? 0).getSingle();
  }

  /// Ответы на вопросы [questionKeys] во всех прохождениях теста, кроме
  /// [excludeAttemptId], — от старых к новым.
  Future<List<({String questionKey, bool isCorrect})>> getAnswersByKeys({
    required String testId,
    required String excludeAttemptId,
    required Set<String> questionKeys,
  }) async {
    if (questionKeys.isEmpty) return const [];

    final query =
        select(testAttemptAnswers).join([
            innerJoin(
              testAttempts,
              testAttempts.id.equalsExp(testAttemptAnswers.attemptId),
            ),
          ])
          ..where(
            testAttempts.testId.equals(testId) &
                testAttempts.id.equals(excludeAttemptId).not() &
                testAttemptAnswers.questionKey.isIn(questionKeys),
          )
          ..orderBy([
            OrderingTerm.asc(testAttempts.completedAt),
            OrderingTerm.asc(testAttempts.startedAt),
            OrderingTerm.asc(testAttemptAnswers.id),
          ]);

    final rows = await query.get();
    return rows.map((row) {
      final answer = row.readTable(testAttemptAnswers);
      return (questionKey: answer.questionKey, isCorrect: answer.isCorrect);
    }).toList();
  }
}
