import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quizzerg/core/feature/core/entity/result.dart';
import 'package:quizzerg/feature/main/domain/entity/card_entity.dart';
import 'package:quizzerg/feature/question_stats/domain/util/question_key_normalizer.dart';
import 'package:quizzerg/feature/test_execution/data/repository/test_attempt_repository.dart';
import 'package:quizzerg/feature/test_execution/domain/entity/attempt_summary.dart';
import 'package:quizzerg/feature/test_execution/domain/service/accuracy_calculator.dart';
import 'package:quizzerg/feature/tinder_test/domain/entity/card_result.dart';
import 'package:quizzerg/feature/tinder_test/domain/entity/test_session.dart';
import 'package:quizzerg/persistence/database/app_database.dart';

import '../auth/auth_fakes.dart';

final _created = DateTime.utc(2026, 9);

CardEntity _card(String id, {String testId = 'test'}) => CardEntity(
  id: id,
  testId: testId,
  front: 'q-$id',
  answers: ['a-$id'],
  createdAt: _created,
  updatedAt: _created,
);

/// Сессия теста [testId], начатая в [startedAt]; [answers] — id карточки →
/// верно ли ответили.
TestSession _session(
  DateTime startedAt,
  Map<String, bool> answers, {
  String testId = 'test',
}) {
  final cards = [for (final id in answers.keys) _card(id, testId: testId)];
  return TestSession(
    testId: testId,
    cards: cards,
    currentIndex: cards.length,
    results: [
      for (final entry in answers.entries)
        CardResult(
          cardId: entry.key,
          isCorrect: entry.value,
          answeredAt: startedAt,
        ),
    ],
    startedAt: startedAt,
    completedAt: startedAt.add(const Duration(minutes: 5)),
  );
}

void main() {
  late AppDatabase database;
  late TestAttemptRepository repository;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    repository = TestAttemptRepository(
      database: database.testAttemptsDatabase,
      errorLogger: const SilentErrorLogger(),
    );
  });

  tearDown(() => database.close());

  Future<AttemptSummary> record(TestSession session) async {
    final result = await repository.recordAttempt(
      session,
      mixup: false,
      swapSides: false,
    );
    return (result as ResultOk<AttemptSummary, Object>).data;
  }

  test('первое прохождение: одна попытка, вопросы без тренда', () async {
    final summary = await record(
      _session(DateTime.utc(2026, 10), {'1': true, '2': false}),
    );

    expect(summary.isFirstAttempt, isTrue);
    expect(summary.totalAttempts, 1);
    expect(summary.questions.map((question) => question.trend), [null, null]);
  });

  test('повтор: динамика по попыткам и тренды по прошлому разу', () async {
    await record(_session(DateTime.utc(2026, 10), {'1': false, '2': true}));
    final summary = await record(
      _session(DateTime.utc(2026, 10, 2), {'1': true, '2': false, '3': true}),
    );

    expect(summary.recentAttempts.map((a) => a.percent), [50, 67]);
    expect(summary.percentDelta, 17);
    expect(summary.totalAttempts, 2);
    expect(
      {
        for (final question in summary.questions)
          question.card.id: question.trend,
      },
      {'1': QuestionTrend.firstCorrect, '2': QuestionTrend.forgot, '3': null},
    );
    expect(summary.questions.first.history, [false, true]);
  });

  test('повторная запись той же сессии не задваивает попытку', () async {
    final session = _session(DateTime.utc(2026, 10), {'1': true});

    await record(session);
    final summary = await record(session);

    expect(summary.totalAttempts, 1);
    expect(summary.isFirstAttempt, isTrue);
    expect(summary.questions.single.trend, isNull);
  });

  test('история только своего теста', () async {
    await record(
      _session(DateTime.utc(2026, 10), {'1': false}, testId: 'other'),
    );
    final summary = await record(
      _session(DateTime.utc(2026, 10, 2), {'1': true}),
    );

    expect(summary.isFirstAttempt, isTrue);
    expect(summary.questions.single.trend, isNull);
  });

  test('в динамике не больше пяти последних попыток', () async {
    for (var day = 1; day <= 7; day++) {
      await record(_session(DateTime.utc(2026, 10, day), {'1': day.isEven}));
    }
    final summary = await record(
      _session(DateTime.utc(2026, 10, 8), {'1': true}),
    );

    expect(summary.totalAttempts, 8);
    expect(summary.recentAttempts.map((a) => a.startedAt.toUtc().day), [
      4,
      5,
      6,
      7,
      8,
    ]);
    expect(summary.questions.single.history, [true, false, true, false, true]);
  });

  group('хранение', () {
    Future<List<String>> answerAttemptIds() async {
      final rows = await database.select(database.testAttemptAnswers).get();
      return rows.map((row) => row.attemptId).toSet().toList();
    }

    test('ответы — только последних десяти прохождений теста', () async {
      for (var day = 1; day <= 13; day++) {
        await record(
          _session(DateTime.utc(2026, 10, day), {'1': true, '2': false}),
        );
      }
      final attempts = await database.select(database.testAttempts).get();
      final kept = await answerAttemptIds();

      expect(attempts, hasLength(13));
      expect(kept, hasLength(AccuracyCalculator.attemptsWindow));
      expect(
        kept.every(
          (id) => attempts
              .where((a) => a.startedAt.toUtc().day > 3)
              .any((a) => a.id == id),
        ),
        isTrue,
      );
    });

    test('чужие тесты не трогает', () async {
      await record(
        _session(DateTime.utc(2026, 9), {'1': true}, testId: 'other'),
      );
      for (var day = 1; day <= 6; day++) {
        await record(_session(DateTime.utc(2026, 10, day), {'1': true}));
      }

      final rows = await database.select(database.testAttempts).get();
      final other = rows.singleWhere((row) => row.testId == 'other');

      expect(await answerAttemptIds(), contains(other.id));
    });

    test('«впервые верно» — в пределах пяти последних прохождений', () async {
      // Верно 6 прохождений назад — ответ хранится, но в историю не входит.
      await record(_session(DateTime.utc(2026, 10), {'1': true}));
      for (var day = 2; day <= 5; day++) {
        await record(_session(DateTime.utc(2026, 10, day), {'1': false}));
      }
      final summary = await record(
        _session(DateTime.utc(2026, 10, 6), {'1': true}),
      );

      expect(summary.questions.single.trend, QuestionTrend.firstCorrect);
      expect(summary.questions.single.history, [
        false,
        false,
        false,
        false,
        true,
      ]);
    });
  });

  group('точность', () {
    /// Живой тест [testId] с карточками [cardIds] — как у [_card].
    Future<void> seedTest(String testId, List<String> cardIds) async {
      await database.testsDatabase.insertTest(
        TestsCompanion.insert(
          id: testId,
          title: testId,
          type: 'tinder',
          createdAt: _created,
          updatedAt: _created,
        ),
      );
      await database.cardsDatabase.insertCards([
        for (final id in cardIds)
          CardsCompanion.insert(
            id: '$testId-$id',
            testId: testId,
            front: 'q-$id',
            answers: '["a-$id"]',
            questionKey: QuestionKeyNormalizer.normalize('q-$id', ['a-$id']),
            createdAt: _created,
            updatedAt: _created,
          ),
      ]);
    }

    Future<Map<String, double>> accuracy() =>
        database.testAttemptsDatabase.getRecentAccuracy(
          attemptsLimit: AccuracyCalculator.attemptsWindow,
        );

    test('доля верных ответов только за последние десять прохождений',
        () async {
      await seedTest('test', ['1', '2']);
      for (var day = 1; day <= 2; day++) {
        await record(
          _session(DateTime.utc(2026, 10, day), {'1': false, '2': false}),
        );
      }
      for (var day = 3; day <= 12; day++) {
        await record(
          _session(DateTime.utc(2026, 10, day), {'1': true, '2': day.isOdd}),
        );
      }

      expect(await accuracy(), {'test': 0.75});
    });

    test('ответы на вопросы не из теста не учитываются', () async {
      await seedTest('test', ['1']);
      await record(
        _session(DateTime.utc(2026, 10), {'1': true, 'mixup': false}),
      );

      expect(await accuracy(), {'test': 1.0});
    });

    test('без прохождений и у удалённого теста точности нет', () async {
      await seedTest('test', ['1']);
      await seedTest('deleted', ['1']);
      await record(
        _session(DateTime.utc(2026, 10), {'1': true}, testId: 'deleted'),
      );
      await database.testsDatabase.softDeleteTestById('deleted');

      expect(await accuracy(), isEmpty);
    });

    test('точность группы — среднее по тестам с прохождениями', () {
      expect(AccuracyCalculator.groupAccuracy([0.5, null, 1.0]), 0.75);
      expect(AccuracyCalculator.groupAccuracy([null]), isNull);
      expect(AccuracyCalculator.groupAccuracy(const []), isNull);
    });
  });
}
