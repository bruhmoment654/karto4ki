import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;
import 'package:quizzerg/core/feature/core/entity/result.dart';
import 'package:quizzerg/feature/main/domain/entity/card_entity.dart';
import 'package:quizzerg/feature/test_execution/data/database/test_attempts_database.dart';
import 'package:quizzerg/feature/test_execution/data/repository/test_attempt_repository.dart';
import 'package:quizzerg/feature/test_execution/domain/entity/attempt_history_usage.dart';
import 'package:quizzerg/feature/test_execution/domain/entity/attempt_summary.dart';
import 'package:quizzerg/feature/tinder_test/domain/entity/card_result.dart';
import 'package:quizzerg/feature/tinder_test/domain/entity/test_session.dart';
import 'package:quizzerg/persistence/database/app_database.dart';

import '../auth/auth_fakes.dart';

final _now = DateTime.utc(2026, 10);

/// SQLite без `dbstat`: запрос размера падает, как на такой сборке.
class _NoDbstatDatabase extends TestAttemptsDatabase {
  _NoDbstatDatabase(super.attachedDatabase);

  @override
  Future<int> historySizeBytes() => throw SqliteException(
    extendedResultCode: 1,
    message: 'no such table: dbstat',
  );
}

/// Тест [testId] с [cards] карточками: прохождение начато в [startedAt],
/// ответы через одну верные.
TestSession _session(String testId, DateTime startedAt, {int cards = 25}) {
  final cardList = [
    for (var i = 0; i < cards; i++)
      CardEntity(
        id: '$testId-$i',
        testId: testId,
        front: 'question $testId $i',
        answers: ['answer $i'],
        createdAt: _now,
        updatedAt: _now,
      ),
  ];

  return TestSession(
    testId: testId,
    cards: cardList,
    currentIndex: cardList.length,
    results: [
      for (final card in cardList)
        CardResult(
          cardId: card.id,
          isCorrect: card.id.hashCode.isEven,
          answeredAt: startedAt,
        ),
    ],
    startedAt: startedAt,
    completedAt: startedAt.add(const Duration(minutes: 5)),
  );
}

void main() {
  late Directory directory;
  late File file;
  late AppDatabase database;

  TestAttemptRepository repositoryOf(TestAttemptsDatabase dao) =>
      TestAttemptRepository(
        database: dao,
        errorLogger: const SilentErrorLogger(),
      );

  Future<AttemptSummary> record(
    TestAttemptRepository repository,
    TestSession session,
  ) async {
    final result = await repository.recordAttempt(
      session,
      mixup: false,
      swapSides: false,
    );

    return (result as ResultOk<AttemptSummary, Object>).data;
  }

  /// 20 тестов по 25 карточек, по 6 прохождений каждого.
  Future<void> seedHistory(TestAttemptRepository repository) async {
    for (var test = 0; test < 20; test++) {
      for (var day = 1; day <= 6; day++) {
        await record(
          repository,
          _session('test-$test', DateTime.utc(2026, 9, day)),
        );
      }
    }
  }

  AttemptHistoryUsage usageOf(Result<AttemptHistoryUsage, Object> result) =>
      (result as ResultOk<AttemptHistoryUsage, Object>).data;

  Future<int> countOf(String table) async {
    final row = await database
        .customSelect('SELECT COUNT(*) AS count FROM $table')
        .getSingle();

    return row.read<int>('count');
  }

  setUp(() {
    directory = Directory.systemTemp.createTempSync('attempt_history_');
    file = File(p.join(directory.path, 'db.sqlite'));
    database = AppDatabase.forTesting(NativeDatabase(file));
  });

  tearDown(() async {
    await database.close();
    directory.deleteSync(recursive: true);
  });

  test('без истории — пусто', () async {
    final repository = repositoryOf(database.testAttemptsDatabase);

    expect(
      usageOf(await repository.getHistoryUsage()),
      AttemptHistoryUsage.empty,
    );
  });

  test('после прохождений размер посчитан по страницам базы', () async {
    final repository = repositoryOf(database.testAttemptsDatabase);
    await seedHistory(repository);

    final usage = usageOf(await repository.getHistoryUsage());

    expect(usage.isEstimate, isFalse);
    // 120 прохождений и 2500 ответов: не меньше их сырого объёма.
    expect(usage.bytes, greaterThan(120 * 50 + 2500 * 30));
  });

  test('очистка: таблицы пусты, размер 0, файл ужат', () async {
    final repository = repositoryOf(database.testAttemptsDatabase);
    await seedHistory(repository);
    final sizeBefore = file.lengthSync();

    final usage = usageOf(await repository.clearHistory());

    expect(usage, AttemptHistoryUsage.empty);
    expect(await countOf('test_attempts'), 0);
    expect(await countOf('test_attempt_answers'), 0);
    expect(file.lengthSync(), lessThan(sizeBefore));
  });

  test('очистка не трогает остальные данные', () async {
    final repository = repositoryOf(database.testAttemptsDatabase);
    await database
        .into(database.tests)
        .insert(
          TestsCompanion.insert(
            id: 'test',
            title: 'Test',
            type: 'cards',
            createdAt: _now,
            updatedAt: _now,
          ),
        );
    await database
        .into(database.cards)
        .insert(
          CardsCompanion.insert(
            id: 'card',
            testId: 'test',
            front: 'front',
            answers: 'back',
            questionKey: 'front',
            createdAt: _now,
            updatedAt: _now,
          ),
        );
    await database
        .into(database.questionStats)
        .insert(
          QuestionStatsCompanion.insert(
            questionKey: 'front',
            frontText: 'front',
            backText: 'back',
            createdAt: _now,
            updatedAt: _now,
          ),
        );
    await database
        .into(database.activeSessions)
        .insert(ActiveSessionsCompanion.insert(data: '{}'));
    await database
        .into(database.answerEventsOutbox)
        .insert(
          AnswerEventsOutboxCompanion.insert(
            cardId: 'card',
            isCorrect: true,
            answeredAt: _now,
          ),
        );
    await seedHistory(repository);

    await repository.clearHistory();

    for (final table in [
      'tests',
      'cards',
      'question_stats',
      'active_sessions',
      'answer_events_outbox',
    ]) {
      expect(await countOf(table), 1, reason: table);
    }
  });

  test('после очистки прохождение снова первое', () async {
    final repository = repositoryOf(database.testAttemptsDatabase);
    await record(repository, _session('test', DateTime.utc(2026, 9)));
    await record(repository, _session('test', DateTime.utc(2026, 9, 2)));

    await repository.clearHistory();
    final summary = await record(
      repository,
      _session('test', DateTime.utc(2026, 9, 3)),
    );

    expect(summary.isFirstAttempt, isTrue);
    expect(summary.totalAttempts, 1);
  });

  test('без dbstat размер оценивается по числу строк', () async {
    final repository = repositoryOf(_NoDbstatDatabase(database));
    await record(
      repository,
      _session('test', DateTime.utc(2026, 9), cards: 10),
    );
    await record(
      repository,
      _session('test', DateTime.utc(2026, 9, 2), cards: 10),
    );

    final usage = usageOf(await repository.getHistoryUsage());

    expect(usage.isEstimate, isTrue);
    expect(usage.bytes, 2 * 230 + 20 * 180);
  });

  test('без dbstat очистка всё равно работает', () async {
    final repository = repositoryOf(_NoDbstatDatabase(database));
    await record(repository, _session('test', DateTime.utc(2026, 9)));

    final usage = usageOf(await repository.clearHistory());

    expect(usage, AttemptHistoryUsage.empty);
  });
}
