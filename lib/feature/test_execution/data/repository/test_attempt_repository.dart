import 'package:quizzerg/core/feature/core/entity/request_operation.dart';
import 'package:quizzerg/core/feature/data/repository/base_repository.dart';
import 'package:quizzerg/feature/test_execution/data/converter/test_attempt_converter.dart';
import 'package:quizzerg/feature/test_execution/data/database/test_attempts_database.dart';
import 'package:quizzerg/feature/test_execution/domain/entity/attempt_summary.dart';
import 'package:quizzerg/feature/test_execution/domain/repository/i_test_attempt_repository.dart';
import 'package:quizzerg/feature/test_execution/domain/service/attempt_summary_builder.dart';
import 'package:quizzerg/feature/tinder_test/domain/entity/test_session.dart';
import 'package:quizzerg/persistence/database/app_database.dart';

class TestAttemptRepository extends BaseRepository
    implements ITestAttemptRepository {
  final TestAttemptsDatabase _database;

  const TestAttemptRepository({
    required TestAttemptsDatabase database,
    required super.errorLogger,
  }) : _database = database;

  @override
  RequestOperation<AttemptSummary> recordAttempt(
    TestSession session, {
    required bool mixup,
    required bool swapSides,
  }) => makeCall(() async {
    final attemptId = _attemptIdOf(session);
    final keys = {
      for (final card in session.cards)
        card.id: AttemptSummaryBuilder.questionKeyOf(card),
    };

    await _database.insertAttempt(
      attempt: TestAttemptsCompanion.insert(
        id: attemptId,
        testId: session.testId,
        startedAt: session.startedAt,
        completedAt: session.completedAt ?? DateTime.now(),
        total: session.cards.length,
        correct: session.correctCount,
        mixup: mixup,
        swapSides: swapSides,
      ),
      answers: [
        for (final result in session.results)
          if (keys[result.cardId] case final key?)
            TestAttemptAnswersCompanion.insert(
              attemptId: attemptId,
              questionKey: key,
              isCorrect: result.isCorrect,
            ),
      ],
    );

    // Экрану нужны ответы только последних прохождений — остальные не
    // копим, иначе таблица растёт на ~5 КБ с каждым прохождением.
    await _database.deleteAnswersBeyond(
      session.testId,
      keep: AttemptSummary.historyLength,
    );

    final recent = await _database.getRecentAttempts(
      session.testId,
      limit: AttemptSummary.historyLength,
    );
    final total = await _database.countAttempts(session.testId);
    final answers = await _database.getAnswersByKeys(
      testId: session.testId,
      excludeAttemptId: attemptId,
      questionKeys: keys.values.toSet(),
    );

    final previousAnswers = <String, List<bool>>{};
    for (final answer in answers) {
      (previousAnswers[answer.questionKey] ??= []).add(answer.isCorrect);
    }

    return AttemptSummaryBuilder.build(
      session: session,
      recentAttempts: recent.reversed
          .map(TestAttemptConverter.fromDto)
          .toList(),
      totalAttempts: total,
      previousAnswers: previousAnswers,
    );
  });

  /// Тест + время старта: у восстановленной после перезапуска сессии
  /// время старта то же, и прохождение не запишется второй раз.
  static String _attemptIdOf(TestSession session) =>
      '${session.testId}_${session.startedAt.toUtc().microsecondsSinceEpoch}';
}
