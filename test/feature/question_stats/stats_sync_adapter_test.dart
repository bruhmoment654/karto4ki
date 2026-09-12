import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quizzerg/feature/question_stats/data/sync/stats_sync_adapter.dart';
import 'package:quizzerg/feature/question_stats/domain/util/stats_remote_id.dart';
import 'package:quizzerg/feature/sync/domain/entity/sync_entity_type.dart';
import 'package:quizzerg/persistence/database/app_database.dart';

/// Статистика уезжает на сервер: за историю до появления журнала ответов
/// событий не существует, отдать её может только клиентский агрегат.
void main() {
  late AppDatabase database;
  late StatsSyncAdapter adapter;

  const key = 'вопрос^_ответ';

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    adapter = StatsSyncAdapter(
      questionStatsDatabase: database.questionStatsDatabase,
    );
  });

  tearDown(() => database.close());

  Future<void> answer({bool isCorrect = true}) =>
      database.questionStatsDatabase.upsertStat(
        questionKey: key,
        frontText: 'вопрос',
        backText: 'ответ',
        isCorrect: isCorrect,
      );

  Future<void> insertLocal({
    required int shown,
    required int correct,
    required DateTime lastAnsweredAt,
  }) => database
      .into(database.questionStats)
      .insert(
        QuestionStatsCompanion.insert(
          questionKey: key,
          frontText: 'вопрос',
          backText: 'ответ',
          streak: Value(correct),
          totalCorrect: Value(correct),
          totalShown: Value(shown),
          lastAnsweredAt: Value(lastAnsweredAt),
          createdAt: DateTime.utc(2026, 2),
          updatedAt: lastAnsweredAt,
        ),
      );

  Future<void> applySnapshot({
    required int shown,
    required int correct,
    required int incorrect,
    DateTime? lastAnsweredAt,
  }) => adapter.applyUpsert(StatsRemoteId.of(key), {
    'id': StatsRemoteId.of(key),
    'questionKey': key,
    'frontText': 'вопрос',
    'backText': 'ответ',
    'streak': correct,
    'totalCorrect': correct,
    'totalIncorrect': incorrect,
    'totalShown': shown,
    'lastAnsweredAt': lastAnsweredAt?.toIso8601String(),
    'createdAt': '2026-02-01T00:00:00.000Z',
    'updatedAt': '2026-09-08T00:00:00.000Z',
  });

  test('локальный ответ делает строку неотправленной', () async {
    await answer();

    expect(await adapter.countDirty(), 1);
    final dirty = await adapter.collectDirty(limit: 10);
    expect(dirty.single.entity, SyncEntityType.stats);
    expect(dirty.single.op, SyncOp.upsert);
    expect(dirty.single.payload!['questionKey'], key);
    expect(dirty.single.payload!['totalShown'], 1);
  });

  test('id выводится из ключа вопроса и стабилен', () async {
    await answer();

    final first = (await adapter.collectDirty(limit: 10)).single.id;
    await answer();
    final second = (await adapter.collectDirty(limit: 10)).single.id;

    expect(first, second);
    expect(first, StatsRemoteId.of(key));
    expect(first, isNot(StatsRemoteId.of('другой^_ключ')));
  });

  test('подтверждение push снимает строку с отправки', () async {
    await answer();
    await adapter.confirmUpsert(StatsRemoteId.of(key), {'questionKey': key});

    expect(await adapter.countDirty(), 0);
    expect(await adapter.collectDirty(limit: 10), isEmpty);
  });

  test('подтверждение без снимка сервера тоже закрывает отправку', () async {
    await answer();
    // Сервер без appliedItems: движок подтверждает изменение с payload = null.
    await adapter.collectDirty(limit: 10);
    await adapter.confirmUpsert(StatsRemoteId.of(key), null);

    expect(await adapter.countDirty(), 0);
  });

  test('снимок сервера, знающий всё, закрывает отправку', () async {
    final answeredAt = DateTime.utc(2026, 9, 5, 12);
    await insertLocal(shown: 1, correct: 1, lastAnsweredAt: answeredAt);

    await applySnapshot(
      shown: 1,
      correct: 1,
      incorrect: 0,
      lastAnsweredAt: answeredAt,
    );

    expect(await adapter.countDirty(), 0);
  });

  test('снимок беднее локального оставляет строку на отправку', () async {
    await insertLocal(
      shown: 3,
      correct: 3,
      lastAnsweredAt: DateTime.utc(2026, 9, 5, 12),
    );
    await adapter.confirmUpsert(StatsRemoteId.of(key), {'questionKey': key});

    // Сервер знает только один ответ из трёх — остаток надо досылать.
    await applySnapshot(
      shown: 1,
      correct: 1,
      incorrect: 0,
      lastAnsweredAt: DateTime.utc(2026, 9, 5, 12),
    );

    expect(await adapter.countDirty(), 1);
    final row = await database.questionStatsDatabase.getByQuestionKey(key);
    expect(row!.totalShown, 3);
  });

  test('строка, приехавшая только с сервера, отправки не ждёт', () async {
    await applySnapshot(
      shown: 5,
      correct: 4,
      incorrect: 1,
      lastAnsweredAt: DateTime.utc(2026, 9, 5, 12),
    );

    expect(await adapter.countDirty(), 0);
    final row = await database.questionStatsDatabase.getByQuestionKey(key);
    expect(row!.totalShown, 5);
  });

  test(
    'isPending всегда false: слияние не портит локальные счётчики',
    () async {
      await answer();

      expect(await adapter.isPending(StatsRemoteId.of(key)), isFalse);
    },
  );

  test('в payload уходят даты в ISO-8601 UTC', () async {
    await database
        .into(database.questionStats)
        .insert(
          QuestionStatsCompanion.insert(
            questionKey: key,
            frontText: 'вопрос',
            backText: 'ответ',
            totalShown: const Value(2),
            totalCorrect: const Value(2),
            lastAnsweredAt: Value(DateTime.utc(2026, 9, 5, 12, 30)),
            createdAt: DateTime.utc(2026, 2),
            updatedAt: DateTime.utc(2026, 9, 5, 12, 30),
          ),
        );

    final payload = (await adapter.collectDirty(limit: 10)).single.payload!;

    expect(payload['lastAnsweredAt'], '2026-09-05T12:30:00.000Z');
    expect(payload['createdAt'], '2026-02-01T00:00:00.000Z');
    expect(payload['lastShownAt'], isNull);
  });
}
