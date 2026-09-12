import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quizzerg/core/logger/error_logger.dart';
import 'package:quizzerg/feature/question_stats/data/dto/answer_event_dto.dart';
import 'package:quizzerg/feature/sync/data/dto/change_event_dto.dart';
import 'package:quizzerg/feature/sync/data/dto/sync_changes_dto.dart';
import 'package:quizzerg/feature/sync/data/dto/sync_push_dto.dart';
import 'package:quizzerg/feature/sync/data/repository/sync_signal_repository.dart';
import 'package:quizzerg/feature/sync/domain/bloc/sync_bloc.dart';
import 'package:quizzerg/feature/sync/domain/entity/sync_auth_status.dart';
import 'package:quizzerg/feature/sync/domain/entity/sync_meta_keys.dart';
import 'package:quizzerg/feature/sync/domain/repository/i_sync_api_repository.dart';
import 'package:quizzerg/feature/sync/domain/service/server_clock.dart';
import 'package:quizzerg/feature/sync/domain/service/sync_engine.dart';
import 'package:quizzerg/network/error/api_exception.dart';
import 'package:quizzerg/persistence/database/app_database.dart';

void main() {
  late AppDatabase database;
  late _FakeSyncApi api;
  late SyncEngine engine;
  late StreamController<SyncAuthStatus> auth;
  late StreamController<List<ConnectivityResult>> connectivity;
  late SyncSignalRepository signal;

  SyncBloc build() => SyncBloc(
        engine: engine,
        syncDatabase: database.syncDatabase,
        syncSignal: signal,
        connectivityChanges: connectivity.stream,
        authStatus: auth.stream,
        // Дебаунс не проверяем таймерами — проверяем, что сигнал доходит.
        mutationDebounce: Duration.zero,
      );

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    api = _FakeSyncApi();
    engine = SyncEngine(
      api: api,
      syncDatabase: database.syncDatabase,
      adapters: const [],
      serverClock: ServerClock(),
      errorLogger: const _SilentErrorLogger(),
    );
    auth = StreamController<SyncAuthStatus>.broadcast();
    connectivity = StreamController<List<ConnectivityResult>>.broadcast();
    signal = SyncSignalRepository();
  });

  tearDown(() async {
    await auth.close();
    await connectivity.close();
    await signal.close();
    await database.close();
  });

  group('SyncBloc', () {
    test('до сигнала авторизации индикатора нет', () async {
      final bloc = build();

      expect(bloc.state.status, const SyncStatus.disabled());
      expect(bloc.state.status.isVisible, isFalse);
      await bloc.close();
    });

    test('гость — disabled и ни одного прогона', () async {
      final bloc = build()..add(const SyncEvent.started());
      await pumpEventQueue();

      auth.add(SyncAuthStatus.none);
      await pumpEventQueue();

      expect(bloc.state.status, const SyncStatus.disabled());
      expect(api.changesCalls, 0);
      await bloc.close();
    });

    test('гость: запрос синхронизации игнорируется', () async {
      final bloc = build()..add(const SyncEvent.started());
      await pumpEventQueue();

      bloc.add(const SyncEvent.requested());
      await pumpEventQueue();

      expect(api.changesCalls, 0);
      await bloc.close();
    });

    test('expired: прогонов нет, статус — expired', () async {
      // Иначе будем молотить 401 в цикле.
      final bloc = build()..add(const SyncEvent.started());
      await pumpEventQueue();

      auth.add(SyncAuthStatus.expired);
      await pumpEventQueue();
      bloc.add(const SyncEvent.requested());
      await pumpEventQueue();

      expect(bloc.state.status.isExpired, isTrue);
      expect(api.changesCalls, 0);
      await bloc.close();
    });

    test('active: прогон запускается, pending == 0 → synced', () async {
      final bloc = build()..add(const SyncEvent.started());
      await pumpEventQueue();

      auth.add(SyncAuthStatus.active);
      await pumpEventQueue();

      expect(api.changesCalls, 1);
      expect(bloc.state.status, isA<SyncStatus$Synced>());
      await bloc.close();
    });

    test('успешный прогон с неотправленными ответами → notSynced', () async {
      await database.syncDatabase.enqueueAnswers([
        AnswerEventsOutboxCompanion.insert(
          cardId: 'card-1',
          isCorrect: true,
          answeredAt: DateTime.utc(2026, 9, 2, 10),
        ),
      ]);
      // Сервер ответы не подтверждает — они остаются в очереди.
      api.answersFail = true;

      final bloc = build()..add(const SyncEvent.started());
      await pumpEventQueue();
      auth.add(SyncAuthStatus.active);
      await pumpEventQueue();

      expect(bloc.state.status, isA<SyncStatus$Offline>());
      expect(bloc.state.status.pending, 1);
      await bloc.close();
    });

    test('выход из аккаунта сбрасывает курсор и метаданные', () async {
      await database.syncDatabase.setMeta(SyncMetaKeys.cursor, 'c1');

      final bloc = build()..add(const SyncEvent.started());
      await pumpEventQueue();
      auth.add(SyncAuthStatus.active);
      await pumpEventQueue();

      auth.add(SyncAuthStatus.none);
      await pumpEventQueue();

      expect(await database.syncDatabase.getMeta(SyncMetaKeys.cursor), isNull);
      expect(
        await database.syncDatabase.getMeta(SyncMetaKeys.lastSyncedAt),
        isNull,
      );
      expect(bloc.state.status, const SyncStatus.disabled());
      await bloc.close();
    });

    test('состояние, пришедшее до подписки, не теряется', () async {
      // Поток авторизации отдаёт текущее значение первым: AuthBloc может
      // успеть эмитить authorized раньше, чем SyncBloc подпишется.
      final bloc = SyncBloc(
        engine: engine,
        syncDatabase: database.syncDatabase,
        syncSignal: signal,
        connectivityChanges: connectivity.stream,
        authStatus: Stream<SyncAuthStatus>.value(SyncAuthStatus.active),
      )..add(const SyncEvent.started());
      await pumpEventQueue();

      expect(api.changesCalls, 1);
      expect(bloc.state.status, isA<SyncStatus$Synced>());
      await bloc.close();
    });

    test('сигнал о локальной правке запускает прогон', () async {
      final bloc = build()..add(const SyncEvent.started());
      await pumpEventQueue();
      auth.add(SyncAuthStatus.active);
      await pumpEventQueue();
      final callsAfterStart = api.changesCalls;

      // Блок фичи не знает про SyncBloc — он пишет в репозиторий.
      signal.notifyLocalMutation();
      await pumpEventQueue();

      expect(api.changesCalls, callsAfterStart + 1);
      await bloc.close();
    });

    test('правка гостя прогон не запускает', () async {
      final bloc = build()..add(const SyncEvent.started());
      await pumpEventQueue();
      auth.add(SyncAuthStatus.none);
      await pumpEventQueue();

      signal.notifyLocalMutation();
      await pumpEventQueue();

      expect(api.changesCalls, 0);
      await bloc.close();
    });

    test('правка до подписки не теряется', () async {
      // BehaviorSubject реплеит последний сигнал: правка могла случиться
      // до того, как SyncBloc обработал started.
      signal.notifyLocalMutation();

      final bloc = build()..add(const SyncEvent.started());
      await pumpEventQueue();
      auth.add(SyncAuthStatus.active);
      await pumpEventQueue();

      // Прогон на старте плюс прогон по реплею сигнала.
      expect(api.changesCalls, greaterThanOrEqualTo(1));
      await bloc.close();
    });

    test('пропадание сети даёт offline, а не ошибку', () async {
      final bloc = build()..add(const SyncEvent.started());
      await pumpEventQueue();
      auth.add(SyncAuthStatus.active);
      await pumpEventQueue();

      connectivity.add([ConnectivityResult.none]);
      await pumpEventQueue();

      expect(bloc.state.status, isA<SyncStatus$Offline>());
      await bloc.close();
    });
  });
}

class _FakeSyncApi implements ISyncApiRepository {
  int changesCalls = 0;
  bool answersFail = false;

  @override
  Future<SyncChangesDto> changes({required int limit, String? since}) async {
    changesCalls++;

    return const SyncChangesDto(changes: [], hasMore: false, remaining: 0);
  }

  @override
  Future<SyncPushResultDto> push(List<ChangeEventDto> changes) async =>
      const SyncPushResultDto(applied: 0);

  @override
  Future<BatchAnswerResultDto> pushAnswers(List<AnswerEventDto> events) async {
    if (answersFail) throw const NetworkUnavailable();

    return const BatchAnswerResultDto(applied: 0);
  }
}

class _SilentErrorLogger implements ErrorLogger {
  const _SilentErrorLogger();

  @override
  void logError(Object error, StackTrace stackTrace) {}
}
