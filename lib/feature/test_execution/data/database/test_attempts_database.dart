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

  /// Сколько строк в таблицах истории.
  Future<({int attempts, int answers})> countRows() async {
    final row = await customSelect(
      'SELECT (SELECT COUNT(*) FROM test_attempts) AS attempts, '
      '(SELECT COUNT(*) FROM test_attempt_answers) AS answers',
    ).getSingle();

    return (
      attempts: row.read<int>('attempts'),
      answers: row.read<int>('answers'),
    );
  }

  /// Сколько байт занимают страницы таблиц истории и их индексов.
  ///
  /// Считает по `dbstat`, поэтому удалённые строки сразу перестают
  /// учитываться, даже если файл ещё не ужат. Если SQLite собран без
  /// `dbstat`, запрос бросит `no such table`.
  Future<int> historySizeBytes() async {
    final row = await customSelect(
      'SELECT COALESCE(SUM(pgsize), 0) AS bytes FROM dbstat '
      'WHERE name IN (SELECT name FROM sqlite_master '
      "WHERE tbl_name IN ('test_attempts', 'test_attempt_answers'))",
    ).getSingle();

    return row.read<int>('bytes');
  }

  /// Удалить всю историю прохождений.
  Future<void> clearAll() => transaction(() async {
    await delete(testAttemptAnswers).go();
    await delete(testAttempts).go();
  });

  /// Последнее завершённое прохождение каждого живого теста:
  /// id теста → время.
  Future<Map<String, DateTime>> getLastCompletedAt() async {
    final tests = attachedDatabase.tests;
    final lastCompleted = testAttempts.completedAt.max();
    final query = selectOnly(testAttempts).join([
      innerJoin(
        tests,
        tests.id.equalsExp(testAttempts.testId) & tests.deletedAt.isNull(),
        useColumns: false,
      ),
    ])
      ..addColumns([testAttempts.testId, lastCompleted])
      ..groupBy([testAttempts.testId]);

    final rows = await query.get();
    return {
      for (final row in rows)
        if ((row.read(testAttempts.testId), row.read(lastCompleted))
            case (final testId?, final completedAt?))
          testId: completedAt,
    };
  }

  /// Доля верных ответов по каждому живому тесту за его последние
  /// [attemptsLimit] прохождений: id теста → 0..1.
  ///
  /// Считаются только ответы на вопросы, которые сейчас есть в тесте: чужие
  /// вопросы из mixup и удалённые карточки не влияют. Тесты без таких
  /// ответов в результат не попадают.
  Future<Map<String, double>> getRecentAccuracy({
    required int attemptsLimit,
  }) async {
    final rows = await customSelect(
      'SELECT recent.test_id AS test_id, '
      'SUM(answer.is_correct) AS correct, COUNT(*) AS total '
      'FROM (SELECT id, test_id, ROW_NUMBER() OVER ( '
      'PARTITION BY test_id ORDER BY completed_at DESC, started_at DESC '
      ') AS position FROM test_attempts) recent '
      'JOIN tests test ON test.id = recent.test_id '
      'AND test.deleted_at IS NULL '
      'JOIN test_attempt_answers answer ON answer.attempt_id = recent.id '
      'WHERE recent.position <= ? AND EXISTS (SELECT 1 FROM cards card '
      'WHERE card.test_id = recent.test_id '
      'AND card.question_key = answer.question_key '
      'AND card.deleted_at IS NULL) '
      'GROUP BY recent.test_id',
      variables: [Variable.withInt(attemptsLimit)],
      readsFrom: {
        testAttempts,
        testAttemptAnswers,
        attachedDatabase.tests,
        attachedDatabase.cards,
      },
    ).get();

    return {
      for (final row in rows)
        row.read<String>('test_id'):
            row.read<int>('correct') / row.read<int>('total'),
    };
  }

  /// Ответы на вопросы [questionKeys] в прохождениях [attemptIds] — от
  /// старых к новым.
  Future<List<({String questionKey, bool isCorrect})>> getAnswersByKeys({
    required Set<String> attemptIds,
    required Set<String> questionKeys,
  }) async {
    if (attemptIds.isEmpty || questionKeys.isEmpty) return const [];

    final query =
        select(testAttemptAnswers).join([
            innerJoin(
              testAttempts,
              testAttempts.id.equalsExp(testAttemptAnswers.attemptId),
            ),
          ])
          ..where(
            testAttempts.id.isIn(attemptIds) &
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
