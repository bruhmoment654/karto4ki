import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quizzerg/core/logger/error_logger.dart';
import 'package:quizzerg/feature/groups_list/data/sync/group_sync_adapter.dart';
import 'package:quizzerg/feature/question_stats/data/dto/answer_event_dto.dart';
import 'package:quizzerg/feature/sync/data/dto/change_event_dto.dart';
import 'package:quizzerg/feature/sync/data/dto/sync_changes_dto.dart';
import 'package:quizzerg/feature/sync/data/dto/sync_push_dto.dart';
import 'package:quizzerg/feature/sync/domain/entity/sync_entity_type.dart';
import 'package:quizzerg/feature/sync/domain/entity/sync_meta_keys.dart';
import 'package:quizzerg/feature/sync/domain/entity/sync_progress.dart';
import 'package:quizzerg/feature/sync/domain/entity/sync_state.dart';
import 'package:quizzerg/feature/sync/domain/repository/i_sync_api_repository.dart';
import 'package:quizzerg/feature/sync/domain/service/server_clock.dart';
import 'package:quizzerg/feature/sync/domain/service/sync_engine.dart';
import 'package:quizzerg/feature/test_detail/data/sync/card_sync_adapter.dart';
import 'package:quizzerg/feature/tests_list/data/sync/test_sync_adapter.dart';
import 'package:quizzerg/persistence/database/app_database.dart';

/// Сетевой слой синхронизации под управлением теста.
class _FakeSyncApi implements ISyncApiRepository {
  /// Страницы, которые отдаёт `GET /sync/changes` по очереди.
  final List<SyncChangesDto> pages = [];

  /// Курсоры, с которыми пришли запросы.
  final List<String?> requestedCursors = [];

  /// Батчи, ушедшие в `POST /sync/push`.
  final List<List<ChangeEventDto>> pushedBatches = [];

  /// Батчи ответов на карточки.
  final List<List<AnswerEventDto>> pushedAnswers = [];

  /// Ответ на push. По умолчанию — «всё применено».
  SyncPushResultDto Function(List<ChangeEventDto> changes)? onPush;

  /// Ответ на push журнала. По умолчанию — «всё применено».
  BatchAnswerResultDto Function(List<AnswerEventDto> events)? onPushAnswers;

  @override
  Future<SyncChangesDto> changes({required int limit, String? since}) async {
    requestedCursors.add(since);
    if (pages.isEmpty) {
      return const SyncChangesDto(changes: [], hasMore: false);
    }

    return pages.removeAt(0);
  }

  @override
  Future<SyncPushResultDto> push(List<ChangeEventDto> changes) async {
    pushedBatches.add(changes);
    final handler = onPush;
    if (handler != null) return handler(changes);

    return SyncPushResultDto(
      applied: changes.length,
      appliedItems: changes
          .map(
            (change) => AppliedChangeDto(
              entity: change.entity,
              id: change.id,
              payload: change.payload,
            ),
          )
          .toList(),
    );
  }

  @override
  Future<BatchAnswerResultDto> pushAnswers(List<AnswerEventDto> events) async {
    pushedAnswers.add(events);
    final handler = onPushAnswers;
    if (handler != null) return handler(events);

    return BatchAnswerResultDto(applied: events.length);
  }
}

class _SilentErrorLogger implements ErrorLogger {
  final List<Object> errors = [];

  @override
  void logError(Object error, StackTrace stackTrace) => errors.add(error);
}

const _iso = '2026-05-17T10:30:00.000Z';

Map<String, dynamic> _testPayload({
  required String id,
  String title = 'Клетка',
  String updatedAt = _iso,
  List<String> groupIds = const [],
}) =>
    {
      'id': id,
      'title': title,
      'type': 'tinder',
      'questionCount': 0,
      'groupIds': groupIds,
      'createdAt': _iso,
      'updatedAt': updatedAt,
    };

void main() {
  late AppDatabase database;
  late _FakeSyncApi api;
  late _SilentErrorLogger errorLogger;
  late ServerClock serverClock;
  late SyncEngine engine;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    api = _FakeSyncApi();
    errorLogger = _SilentErrorLogger();
    serverClock = ServerClock();
    engine = SyncEngine(
      api: api,
      syncDatabase: database.syncDatabase,
      adapters: [
        GroupSyncAdapter(groupsDatabase: database.groupsDatabase),
        TestSyncAdapter(
          testsDatabase: database.testsDatabase,
          cardsDatabase: database.cardsDatabase,
          groupsDatabase: database.groupsDatabase,
        ),
        CardSyncAdapter(cardsDatabase: database.cardsDatabase),
      ],
      serverClock: serverClock,
      errorLogger: errorLogger,
    );
  });

  tearDown(() => database.close());

  Future<void> insertTest({
    required String id,
    required String title,
    SyncState state = SyncState.pending,
    DateTime? deletedAt,
  }) =>
      database.testsDatabase.insertTest(
        TestsCompanion.insert(
          id: id,
          title: title,
          type: 'tinder',
          createdAt: DateTime.utc(2026, 5, 17),
          updatedAt: DateTime.utc(2026, 5, 17),
          syncState: Value(state.dbValue),
          deletedAt: Value(deletedAt),
        ),
      );

  group('pull', () {
    test('bootstrap идёт без курсора и проходит все страницы', () async {
      api.pages.addAll([
        SyncChangesDto(
          nextCursor: 'c1',
          hasMore: true,
          changes: [
            ChangeEventDto(
              entity: SyncEntityType.test,
              op: SyncOp.upsert,
              id: 'test-1',
              payload: _testPayload(id: 'test-1', title: 'Первый'),
              occurredAt: DateTime.utc(2026, 5, 17),
            ),
          ],
        ),
        SyncChangesDto(
          nextCursor: 'c2',
          hasMore: false,
          changes: [
            ChangeEventDto(
              entity: SyncEntityType.test,
              op: SyncOp.upsert,
              id: 'test-2',
              payload: _testPayload(id: 'test-2', title: 'Второй'),
              occurredAt: DateTime.utc(2026, 5, 17),
            ),
          ],
        ),
      ]);

      final result = await engine.sync();

      expect(result.isBootstrap, isTrue);
      expect(result.pulled, 2);
      expect(api.requestedCursors, [null, 'c1']);
      expect(
        await database.syncDatabase.getMeta(SyncMetaKeys.cursor),
        'c2',
      );
      expect((await database.testsDatabase.getAllTests()).length, 2);
    });

    test('эхо своего push не затирает локальную правку', () async {
      await insertTest(id: 'test-1', title: 'Локальный');
      api.pages.add(
        SyncChangesDto(
          hasMore: false,
          changes: [
            ChangeEventDto(
              entity: SyncEntityType.test,
              op: SyncOp.upsert,
              id: 'test-1',
              payload: _testPayload(id: 'test-1', title: 'Серверный'),
              occurredAt: DateTime.utc(2026, 5, 17),
            ),
          ],
        ),
      );

      await engine.sync();

      final test = await database.testsDatabase.getTestById('test-1');
      expect(test?.title, 'Локальный');
    });

    test('upsert с пустым payload не роняет прогон', () async {
      api.pages.add(
        SyncChangesDto(
          hasMore: false,
          changes: [
            ChangeEventDto(
              entity: SyncEntityType.test,
              op: SyncOp.upsert,
              id: 'test-1',
              occurredAt: DateTime.utc(2026, 5, 17),
            ),
          ],
        ),
      );

      final result = await engine.sync();

      expect(result.isSuccess, isTrue);
      expect(result.pulled, 0);
    });

    test('неизвестная сущность пропускается', () async {
      api.pages.add(
        SyncChangesDto(
          hasMore: false,
          changes: [
            ChangeEventDto(
              entity: SyncEntityType.testSession,
              op: SyncOp.upsert,
              id: 'session-1',
              occurredAt: DateTime.utc(2026, 5, 17),
            ),
          ],
        ),
      );

      final result = await engine.sync();

      expect(result.isSuccess, isTrue);
    });

    test('серверное удаление применяется локально', () async {
      await insertTest(
          id: 'test-1', title: 'Локальный', state: SyncState.synced);
      api.pages.add(
        SyncChangesDto(
          hasMore: false,
          changes: [
            ChangeEventDto(
              entity: SyncEntityType.test,
              op: SyncOp.delete,
              id: 'test-1',
              occurredAt: DateTime.utc(2026, 5, 17),
            ),
          ],
        ),
      );

      await engine.sync();

      expect(await database.testsDatabase.getTestByIdRaw('test-1'), isNull);
    });
  });

  group('push', () {
    test('неотправленный тест уезжает и помечается синхронизированным',
        () async {
      await insertTest(id: 'test-1', title: 'Локальный');

      final result = await engine.sync();

      expect(result.pushed, 1);
      expect(api.pushedBatches.single.single.op, SyncOp.upsert);
      final row = await database.testsDatabase.getTestByIdRaw('test-1');
      expect(row?.syncState, SyncState.synced.dbValue);
      expect(row?.serverUpdatedAt, isNotNull);
    });

    test('updatedAt в payload больше последнего серверного', () async {
      await insertTest(id: 'test-1', title: 'Локальный');
      // Часы устройства отстали на сутки от серверного времени.
      final serverTime = DateTime.now().toUtc().add(const Duration(days: 1));
      await database.testsDatabase.writeSyncFields(
        'test-1',
        TestsCompanion(
          serverUpdatedAt: Value(serverTime.toIso8601String()),
        ),
      );

      await engine.sync();

      final payload = api.pushedBatches.single.single.payload;
      final pushedUpdatedAt = DateTime.parse(payload?['updatedAt'] as String);
      expect(pushedUpdatedAt.isAfter(serverTime), isTrue);
    });

    test('tombstone уезжает как delete и чистится физически', () async {
      await insertTest(
          id: 'test-1', title: 'Локальный', state: SyncState.synced);
      await database.testsDatabase.softDeleteTestById('test-1');

      await engine.sync();

      expect(api.pushedBatches.single.single.op, SyncOp.delete);
      expect(await database.testsDatabase.getTestByIdRaw('test-1'), isNull);
    });

    test('потерянный ответ на push не даёт ложного конфликта', () async {
      await insertTest(id: 'test-1', title: 'Локальный');
      api.onPush = (changes) {
        final pushed = changes.single.payload ?? const <String, dynamic>{};

        return SyncPushResultDto(
          applied: 0,
          conflicts: [
            SyncConflictDto(
              entity: SyncEntityType.test,
              id: 'test-1',
              reason: SyncConflictReason.serverNewer,
              // Сервер вернул ровно то, что мы отправляли: push прошёл,
              // потерялся только ответ.
              server: {
                ...pushed,
                'updatedAt': DateTime.now()
                    .toUtc()
                    .add(const Duration(minutes: 1))
                    .toIso8601String(),
              },
            ),
          ],
        );
      };

      final result = await engine.sync();

      expect(result.conflicts, isEmpty);
      final row = await database.testsDatabase.getTestByIdRaw('test-1');
      expect(row?.syncState, SyncState.synced.dbValue);
    });

    test('реальный конфликт по тесту принимает серверную версию', () async {
      await insertTest(id: 'test-1', title: 'Локальный');
      api.onPush = (changes) => SyncPushResultDto(
            applied: 0,
            conflicts: [
              SyncConflictDto(
                entity: SyncEntityType.test,
                id: 'test-1',
                reason: SyncConflictReason.serverNewer,
                server: _testPayload(id: 'test-1', title: 'Серверный'),
              ),
            ],
          );

      final result = await engine.sync();

      expect(result.conflicts.single.id, 'test-1');
      final row = await database.testsDatabase.getTestById('test-1');
      expect(row?.title, 'Серверный');
      expect(row?.syncState, SyncState.synced.dbValue);
    });

    test('reason deleted убирает локальную запись', () async {
      await insertTest(id: 'test-1', title: 'Локальный');
      api.onPush = (changes) => const SyncPushResultDto(
            applied: 0,
            conflicts: [
              SyncConflictDto(
                entity: SyncEntityType.test,
                id: 'test-1',
                reason: SyncConflictReason.deleted,
              ),
            ],
          );

      await engine.sync();

      expect(await database.testsDatabase.getTestByIdRaw('test-1'), isNull);
    });

    test('порядок батча: сначала владельцы, потом зависимые', () async {
      await database.groupsDatabase.insertGroup(
        TestGroupsCompanion.insert(
          id: 'group-1',
          title: 'Группа',
          createdAt: DateTime.utc(2026, 5, 17),
          updatedAt: DateTime.utc(2026, 5, 17),
        ),
      );
      await insertTest(id: 'test-1', title: 'Локальный');
      await database.cardsDatabase.insertCard(
        CardsCompanion.insert(
          id: 'card-1',
          testId: 'test-1',
          front: 'Вопрос',
          answers: '["ответ"]',
          questionKey: 'вопросответ',
          createdAt: DateTime.utc(2026, 5, 17),
          updatedAt: DateTime.utc(2026, 5, 17),
        ),
      );

      await engine.sync();

      expect(
        api.pushedBatches.single.map((it) => it.entity).toList(),
        [SyncEntityType.group, SyncEntityType.test, SyncEntityType.card],
      );
    });
  });

  group('push разгребает очередь целиком', () {
    Future<void> insertTests(int count) => database.transaction(() async {
          for (var i = 0; i < count; i++) {
            await insertTest(id: 'test-$i', title: 'Тест $i');
          }
        });

    test('очередь больше лимита уезжает за несколько батчей', () async {
      await insertTests(SyncEngine.pushBatchLimit + 5);

      final result = await engine.sync();

      expect(api.pushedBatches.length, 2);
      expect(api.pushedBatches.first.length, SyncEngine.pushBatchLimit);
      expect(api.pushedBatches.last.length, 5);
      expect(result.pushed, SyncEngine.pushBatchLimit + 5);
      expect(await engine.pendingCount(), 0);
    });

    test('сервер отверг весь батч — движок не крутится вхолостую', () async {
      await insertTests(SyncEngine.pushBatchLimit + 5);
      // `unknown` оставляет строку pending, поэтому следующий заход соберёт
      // ровно те же изменения. Крутиться до maxPushBatches нельзя.
      api.onPush = (changes) => SyncPushResultDto(
            applied: 0,
            conflicts: changes
                .map(
                  (change) => SyncConflictDto(
                    entity: change.entity,
                    id: change.id,
                    reason: SyncConflictReason.unknown,
                  ),
                )
                .toList(),
          );

      await engine.sync();

      expect(api.pushedBatches.length, 2);
      expect(await engine.pendingCount(), SyncEngine.pushBatchLimit + 5);
    });
  });

  group('ответы на карточки', () {
    test('журнал уезжает батчем и помечается отправленным', () async {
      await database.syncDatabase.enqueueAnswers([
        AnswerEventsOutboxCompanion.insert(
          cardId: 'card-1',
          isCorrect: true,
          answeredAt: DateTime.utc(2026, 5, 17, 10),
        ),
        AnswerEventsOutboxCompanion.insert(
          cardId: 'card-2',
          isCorrect: false,
          answeredAt: DateTime.utc(2026, 5, 17, 11),
        ),
      ]);

      final result = await engine.sync();

      expect(result.answersSent, 2);
      expect(api.pushedAnswers.single.length, 2);
      expect(
        await database.syncDatabase.getUnsentAnswers(limit: 10),
        isEmpty,
      );
    });

    test('ответ по неизвестной серверу карточке остаётся в журнале', () async {
      await database.syncDatabase.enqueueAnswers([
        AnswerEventsOutboxCompanion.insert(
          cardId: 'card-1',
          isCorrect: true,
          answeredAt: DateTime.utc(2026, 5, 17, 10),
        ),
        AnswerEventsOutboxCompanion.insert(
          cardId: 'card-missing',
          isCorrect: false,
          answeredAt: DateTime.utc(2026, 5, 17, 11),
        ),
      ]);
      api.onPushAnswers = (events) => const BatchAnswerResultDto(
            applied: 1,
            notFound: ['card-missing'],
          );

      await engine.sync();

      // Карточка доедет следующим push — ответ должен дождаться её,
      // иначе он потерян навсегда: события есть только в этом журнале.
      final unsent = await database.syncDatabase.getUnsentAnswers(limit: 10);
      expect(unsent.map((it) => it.cardId).toList(), ['card-missing']);
    });

    test('журнал больше лимита уезжает за несколько батчей', () async {
      const extra = 5;
      await database.syncDatabase.enqueueAnswers([
        for (var i = 0; i < SyncEngine.answersBatchLimit + extra; i++)
          AnswerEventsOutboxCompanion.insert(
            cardId: 'card-$i',
            isCorrect: true,
            answeredAt: DateTime.utc(2026, 5, 17).add(Duration(seconds: i)),
          ),
      ]);

      final result = await engine.sync();

      expect(api.pushedAnswers.length, 2);
      expect(api.pushedAnswers.first.length, SyncEngine.answersBatchLimit);
      expect(api.pushedAnswers.last.length, extra);
      expect(result.answersSent, SyncEngine.answersBatchLimit + extra);
      expect(await database.syncDatabase.getUnsentAnswers(limit: 10), isEmpty);
    });

    test('весь батч неизвестен серверу — второго захода нет', () async {
      await database.syncDatabase.enqueueAnswers([
        for (var i = 0; i < SyncEngine.answersBatchLimit; i++)
          AnswerEventsOutboxCompanion.insert(
            cardId: 'card-$i',
            isCorrect: true,
            answeredAt: DateTime.utc(2026, 5, 17).add(Duration(seconds: i)),
          ),
      ]);
      // Журнал не сдвинулся: следующий заход вычитал бы те же строки.
      api.onPushAnswers = (events) => BatchAnswerResultDto(
            applied: 0,
            notFound: events.map((it) => it.cardId).toList(),
          );

      await engine.sync();

      expect(api.pushedAnswers.length, 1);
      expect(
        await database.syncDatabase.countUnsentAnswers(),
        SyncEngine.answersBatchLimit,
      );
    });

    test('повторный ответ на ту же карточку в тот же момент не дублируется',
        () async {
      final answeredAt = DateTime.utc(2026, 5, 17, 10);
      final event = AnswerEventsOutboxCompanion.insert(
        cardId: 'card-1',
        isCorrect: true,
        answeredAt: answeredAt,
      );
      await database.syncDatabase.enqueueAnswers([event, event]);

      expect(
        (await database.syncDatabase.getUnsentAnswers(limit: 10)).length,
        1,
      );
    });
  });

  group('SyncEngine.serverTime', () {
    test('serverTime из ответа попадает в sync_meta', () async {
      final serverTime = DateTime.utc(2026, 9, 2, 13, 22, 4, 117);
      api.pages.add(
        SyncChangesDto(changes: const [], hasMore: false, serverTime: serverTime),
      );

      await engine.sync();

      expect(await engine.lastSyncedAt(), serverTime);
      expect(await engine.lastSyncedSource(), SyncTimeSource.server);
      expect(serverClock.hasServerTime, isTrue);
    });

    test('ответ без serverTime пишет локальное время и source = local',
        () async {
      // Сборка бэкенда до выкатки поля: врать «точно» нельзя.
      api.pages.add(const SyncChangesDto(changes: [], hasMore: false));

      await engine.sync();

      expect(await engine.lastSyncedAt(), isNotNull);
      expect(await engine.lastSyncedSource(), SyncTimeSource.local);
      expect(serverClock.hasServerTime, isFalse);
    });

    test('сдвиг часов переживает перезапуск через sync_meta', () async {
      final serverTime =
          DateTime.now().toUtc().subtract(const Duration(hours: 3));
      api.pages.add(
        SyncChangesDto(changes: const [], hasMore: false, serverTime: serverTime),
      );
      await engine.sync();

      // Новые часы и новый движок — как после холодного старта.
      final restored = ServerClock();
      final restarted = SyncEngine(
        api: api,
        syncDatabase: database.syncDatabase,
        adapters: const [],
        serverClock: restored,
        errorLogger: errorLogger,
      );
      await restarted.restoreClock();

      expect(restored.hasServerTime, isTrue);
      expect(restored.skew.inMinutes, closeTo(-180, 1));
    });
  });

  group('SyncEngine.pull', () {
    test('remaining == 0 завершает цикл без лишнего запроса', () async {
      // Страница ровно в лимит: по hasMore клиент сходил бы ещё раз впустую.
      api.pages.add(
        const SyncChangesDto(
          changes: [],
          hasMore: true,
          nextCursor: 'c1',
          remaining: 0,
        ),
      );

      await engine.sync();

      expect(api.requestedCursors, [null]);
    });

    test('ответ без remaining завершает цикл по hasMore', () async {
      api.pages.addAll([
        const SyncChangesDto(changes: [], hasMore: true, nextCursor: 'c1'),
        const SyncChangesDto(changes: [], hasMore: false, nextCursor: 'c2'),
      ]);

      await engine.sync();

      expect(api.requestedCursors, [null, 'c1']);
    });

    test('не сдвинувшийся курсор при hasMore рвёт цикл', () async {
      api.pages.addAll([
        const SyncChangesDto(changes: [], hasMore: true, nextCursor: 'c1'),
        const SyncChangesDto(changes: [], hasMore: true, nextCursor: 'c1'),
      ]);

      await engine.sync();

      expect(api.requestedCursors, [null, 'c1']);
    });

    test('прогресс считается по remaining и не убывает', () async {
      api.pages.addAll([
        const SyncChangesDto(
          changes: [],
          hasMore: true,
          nextCursor: 'c1',
          remaining: 1000,
        ),
        const SyncChangesDto(
          changes: [],
          hasMore: true,
          nextCursor: 'c2',
          remaining: 600,
        ),
        const SyncChangesDto(
          changes: [],
          hasMore: false,
          nextCursor: 'c3',
          remaining: 0,
        ),
      ]);
      final reported = <SyncProgress?>[];

      await engine.sync(onProgress: reported.add);

      expect(reported.length, 3);
      expect(reported.first?.total, 1000);
      expect(reported.last?.value, 1);
      final values = reported.map((it) => it?.value ?? 0).toList();
      expect(values, orderedEquals(<double>[...values]..sort()));
    });
  });
}
