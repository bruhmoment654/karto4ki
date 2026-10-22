import 'package:quizzerg/feature/main/domain/entity/card_entity.dart';
import 'package:quizzerg/feature/question_stats/domain/util/question_key_normalizer.dart';
import 'package:quizzerg/feature/test_execution/domain/entity/attempt_summary.dart';
import 'package:quizzerg/feature/test_execution/domain/entity/test_attempt_entity.dart';
import 'package:quizzerg/feature/tinder_test/domain/entity/test_session.dart';

/// Собирает [AttemptSummary] из завершённой сессии и истории прохождений.
abstract final class AttemptSummaryBuilder {
  /// [recentAttempts] — от старых к новым, последнее — текущее.
  /// [previousAnswers] — ответы на вопрос в прошлых прохождениях теста,
  /// от старых к новым, по ключу [questionKeyOf].
  static AttemptSummary build({
    required TestSession session,
    required List<TestAttemptEntity> recentAttempts,
    required int totalAttempts,
    required Map<String, List<bool>> previousAnswers,
  }) {
    final cards = {for (final card in session.cards) card.id: card};
    final questions = <QuestionResult>[];

    for (final result in session.results) {
      final card = cards[result.cardId];
      if (card == null) continue;

      final previous = previousAnswers[questionKeyOf(card)] ?? const [];
      questions.add(
        QuestionResult(
          card: card,
          isCorrect: result.isCorrect,
          history: [
            ..._takeLast(previous, AttemptSummary.historyLength - 1),
            result.isCorrect,
          ],
          trend: trendOf(previous, isCorrect: result.isCorrect),
        ),
      );
    }

    return AttemptSummary(
      recentAttempts: recentAttempts,
      totalAttempts: totalAttempts,
      questions: questions,
    );
  }

  /// Сводка без истории — когда записать прохождение не удалось.
  static AttemptSummary withoutHistory(TestSession session) => build(
    session: session,
    recentAttempts: const [],
    totalAttempts: 0,
    previousAnswers: const {},
  );

  /// Тренд по прошлым ответам [previous] (от старых к новым).
  ///
  /// «Впервые верно» проверяется по всем [previous], а не только по
  /// последнему ответу. В [previous] — ответы последних
  /// [AttemptSummary.historyLength] прохождений теста, поэтому «впервые» —
  /// в их пределах.
  static QuestionTrend? trendOf(
    List<bool> previous, {
    required bool isCorrect,
  }) {
    if (previous.isEmpty) return null;

    final wasCorrect = previous.last;
    if (isCorrect && !previous.contains(true)) {
      return QuestionTrend.firstCorrect;
    }
    if (isCorrect) {
      return wasCorrect ? QuestionTrend.stable : QuestionTrend.fixed;
    }
    return wasCorrect ? QuestionTrend.forgot : QuestionTrend.repeatedMistake;
  }

  /// Ключ вопроса — тот же, что в статистике.
  static String questionKeyOf(CardEntity card) =>
      QuestionKeyNormalizer.normalize(card.front, card.answers);

  static List<bool> _takeLast(List<bool> values, int count) =>
      values.length > count ? values.sublist(values.length - count) : values;
}
