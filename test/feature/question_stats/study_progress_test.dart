import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quizzerg/feature/question_stats/data/service/study_progress_reader.dart';
import 'package:quizzerg/feature/question_stats/domain/entity/study_progress_entity.dart';
import 'package:quizzerg/feature/question_stats/domain/service/study_progress_calculator.dart';
import 'package:quizzerg/feature/question_stats/domain/util/question_key_normalizer.dart';
import 'package:quizzerg/persistence/database/app_database.dart';

final _created = DateTime.utc(2026, 9);

QuestionProgressRow _row(String key, {int? streak, int? shown}) =>
    (questionKey: key, streak: streak, totalShown: shown);

String _key(String id) => QuestionKeyNormalizer.normalize('q-$id', ['a-$id']);

void main() {
  group('StudyProgressCalculator', () {
    StudyProgressEntity calculate(
      List<String> testIds,
      Map<String, List<QuestionProgressRow>> questions, {
      Map<String, double> accuracy = const {},
      Map<String, DateTime> lastCompleted = const {},
    }) => StudyProgressCalculator.calculate(
      testIds: testIds,
      questionsByTest: questions,
      accuracyByTest: accuracy,
      lastCompletedByTest: lastCompleted,
    );

    test('раскладывает вопросы по состояниям', () {
      final progress = calculate(
        ['test'],
        {
          'test': [
            _row('new-no-stats'),
            _row('new-not-shown', streak: 0, shown: 0),
            _row('weak', streak: -1, shown: 3),
            _row('learning', streak: 2, shown: 4),
            _row('mastered', streak: 3, shown: 5),
          ],
        },
      );

      expect(progress.newCount, 2);
      expect(progress.weakCount, 1);
      expect(progress.learningCount, 1);
      expect(progress.masteredCount, 1);
      expect(progress.total, 5);
      expect(progress.isNotStarted, isFalse);
    });

    test('вопрос из нескольких тестов группы считается один раз', () {
      final progress = calculate(
        ['a', 'b'],
        {
          'a': [_row('shared', streak: 1, shown: 1), _row('only-a')],
          'b': [_row('shared', streak: 1, shown: 1)],
          'other': [_row('foreign')],
        },
      );

      expect(progress.total, 2);
      expect(progress.learningCount, 1);
      expect(progress.newCount, 1);
    });

    test('точность — среднее тестов, дата — самое свежее прохождение', () {
      final progress = calculate(
        ['a', 'b', 'c'],
        const {},
        accuracy: {'a': 0.5, 'b': 1.0},
        lastCompleted: {
          'a': DateTime.utc(2026, 10, 2),
          'c': DateTime.utc(2026, 10, 5),
        },
      );

      expect(progress.accuracy, 0.75);
      expect(progress.lastStudiedAt, DateTime.utc(2026, 10, 5));
    });

    test('не начат — только если все вопросы новые', () {
      expect(
        calculate(
          ['t'],
          {
            't': [_row('x')],
          },
        ).isNotStarted,
        isTrue,
      );
      expect(calculate(['t'], const {}).isNotStarted, isFalse);
      expect(
        calculate(
          ['t'],
          {
            't': [_row('x', streak: -1, shown: 1)],
          },
        ).isNotStarted,
        isFalse,
      );
    });

    test('отличная точность — от 90%', () {
      expect(const StudyProgressEntity(accuracy: 0.9).isGreatAccuracy, isTrue);
      expect(
        const StudyProgressEntity(accuracy: 0.89).isGreatAccuracy,
        isFalse,
      );
      expect(StudyProgressEntity.empty.isGreatAccuracy, isFalse);
    });
  });

  group('StudyProgressReader', () {
    late AppDatabase database;
    late StudyProgressReader reader;

    setUp(() {
      database = AppDatabase.forTesting(NativeDatabase.memory());
      reader = StudyProgressReader(
        cardsDatabase: database.cardsDatabase,
        testAttemptsDatabase: database.testAttemptsDatabase,
      );
    });

    tearDown(() => database.close());

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
            questionKey: _key(id),
            createdAt: _created,
            updatedAt: _created,
          ),
      ]);
    }

    Future<void> seedAttempt(String testId, DateTime completedAt) =>
        database.testAttemptsDatabase.insertAttempt(
          attempt: TestAttemptsCompanion.insert(
            id: '$testId-${completedAt.millisecondsSinceEpoch}',
            testId: testId,
            startedAt: completedAt,
            completedAt: completedAt,
            total: 1,
            correct: 1,
            mixup: false,
            swapSides: false,
          ),
          answers: const [],
        );

    test('вопросы живых карточек со статистикой', () async {
      await seedTest('test', ['1', '2', '3']);
      await database
          .into(database.questionStats)
          .insert(
            QuestionStatsCompanion.insert(
              questionKey: _key('1'),
              frontText: 'q-1',
              backText: 'a-1',
              streak: const Value(2),
              totalShown: const Value(4),
              createdAt: _created,
              updatedAt: _created,
            ),
          );
      await database.cardsDatabase.softDeleteCardById('test-3');

      final snapshot = await reader.read();

      expect(snapshot.questionsByTest['test'], [
        (questionKey: _key('1'), streak: 2, totalShown: 4),
        (questionKey: _key('2'), streak: null, totalShown: null),
      ]);
    });

    test('удалённый тест не попадает ни в вопросы, ни в прохождения', () async {
      await seedTest('alive', ['1']);
      await seedTest('deleted', ['1']);
      await seedAttempt('alive', DateTime.utc(2026, 10, 2));
      await seedAttempt('alive', DateTime.utc(2026, 10, 3));
      await seedAttempt('deleted', DateTime.utc(2026, 10, 4));
      await database.testsDatabase.softDeleteTestById('deleted');

      final snapshot = await reader.read();

      expect(snapshot.questionsByTest.keys, ['alive']);
      expect(snapshot.lastCompletedByTest.keys, ['alive']);
      expect(
        snapshot.lastCompletedByTest['alive']!.toUtc(),
        DateTime.utc(2026, 10, 3),
      );
    });
  });
}
