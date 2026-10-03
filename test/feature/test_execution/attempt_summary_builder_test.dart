import 'package:flutter_test/flutter_test.dart';
import 'package:quizzerg/feature/main/domain/entity/card_entity.dart';
import 'package:quizzerg/feature/test_execution/domain/entity/attempt_summary.dart';
import 'package:quizzerg/feature/test_execution/domain/entity/test_attempt_entity.dart';
import 'package:quizzerg/feature/test_execution/domain/service/attempt_summary_builder.dart';
import 'package:quizzerg/feature/tinder_test/domain/entity/card_result.dart';
import 'package:quizzerg/feature/tinder_test/domain/entity/test_session.dart';

final _at = DateTime.utc(2026, 10);

CardEntity _card(String id) => CardEntity(
  id: id,
  testId: 'test',
  front: 'q-$id',
  answers: ['a-$id'],
  createdAt: _at,
  updatedAt: _at,
);

TestSession _session(Map<String, bool> answers) {
  final cards = answers.keys.map(_card).toList();
  return TestSession(
    testId: 'test',
    cards: cards,
    currentIndex: cards.length,
    results: [
      for (final entry in answers.entries)
        CardResult(cardId: entry.key, isCorrect: entry.value, answeredAt: _at),
    ],
    startedAt: _at,
  );
}

TestAttemptEntity _attempt(int correct, {int total = 10}) => TestAttemptEntity(
  id: 'attempt-$correct',
  testId: 'test',
  startedAt: _at,
  completedAt: _at,
  total: total,
  correct: correct,
);

void main() {
  group('trendOf', () {
    QuestionTrend? trend(List<bool> previous, {required bool isCorrect}) =>
        AttemptSummaryBuilder.trendOf(previous, isCorrect: isCorrect);

    test('без прошлых ответов тренда нет', () {
      expect(trend([], isCorrect: true), isNull);
      expect(trend([], isCorrect: false), isNull);
    });

    test('верно после одних ошибок — впервые верно', () {
      expect(
        trend([false, false], isCorrect: true),
        QuestionTrend.firstCorrect,
      );
    });

    test('«впервые» смотрит на всю историю, а не на прошлый раз', () {
      expect(trend([true, false], isCorrect: true), QuestionTrend.fixed);
    });

    test('верно и в прошлый раз — стабильно', () {
      expect(trend([false, true], isCorrect: true), QuestionTrend.stable);
    });

    test('ошибка после верного — забыл', () {
      expect(trend([true], isCorrect: false), QuestionTrend.forgot);
    });

    test('ошибка после ошибки — снова ошибка', () {
      expect(
        trend([true, false], isCorrect: false),
        QuestionTrend.repeatedMistake,
      );
    });
  });

  group('build', () {
    test('история — последние 4 прошлых ответа и текущий', () {
      final session = _session({'1': true});
      final key = AttemptSummaryBuilder.questionKeyOf(_card('1'));

      final summary = AttemptSummaryBuilder.build(
        session: session,
        recentAttempts: [_attempt(5), _attempt(9)],
        totalAttempts: 7,
        previousAnswers: {
          key: [true, false, false, true, false, false],
        },
      );

      final question = summary.questions.single;
      expect(question.history, [false, true, false, false, true]);
      expect(question.trend, QuestionTrend.fixed);
    });

    test('вопрос, которого в тесте не было, — без тренда', () {
      final summary = AttemptSummaryBuilder.build(
        session: _session({'1': false}),
        recentAttempts: [_attempt(5), _attempt(9)],
        totalAttempts: 2,
        previousAnswers: const {},
      );

      final question = summary.questions.single;
      expect(question.history, [false]);
      expect(question.trend, isNull);
    });

    test('порядок вопросов — порядок ответов', () {
      final summary = AttemptSummaryBuilder.withoutHistory(
        _session({'b': true, 'a': false, 'c': true}),
      );

      expect(summary.questions.map((question) => question.card.id), [
        'b',
        'a',
        'c',
      ]);
      expect(summary.hasHistory, isFalse);
    });
  });

  group('AttemptSummary', () {
    test('первое прохождение — без дельты', () {
      final summary = AttemptSummary(
        recentAttempts: [_attempt(7)],
        totalAttempts: 1,
        questions: const [],
      );

      expect(summary.isFirstAttempt, isTrue);
      expect(summary.percentDelta, isNull);
    });

    test('дельта — разница округлённых процентов с прошлым разом', () {
      final summary = AttemptSummary(
        recentAttempts: [_attempt(5), _attempt(7), _attempt(2, total: 3)],
        totalAttempts: 3,
        questions: const [],
      );

      expect(summary.isFirstAttempt, isFalse);
      expect(summary.percentDelta, 67 - 70);
    });
  });
}
