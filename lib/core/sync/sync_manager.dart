import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:drift/drift.dart';
import 'package:quizzerg/core/auth/i_auth_service.dart';
import 'package:quizzerg/core/logger/error_logger.dart';
import 'package:quizzerg/core/network/dto/stats_dto.dart';
import 'package:quizzerg/core/network/dto/sync_dto.dart';
import 'package:quizzerg/core/network/karto4ki_api.dart';
import 'package:quizzerg/core/sync/data/sync_preferences.dart';
import 'package:quizzerg/core/sync/domain/entity/sync_state.dart';
import 'package:quizzerg/core/sync/domain/entity/sync_status.dart';
import 'package:quizzerg/core/utils/answer_parser.dart';
import 'package:quizzerg/persistence/database/app_database.dart';
import 'package:rxdart/rxdart.dart';

/// Оркестратор offline-first синхронизации с бэкендом.
///
/// Локальная Drift-база — единственный источник правды для UI; менеджер
/// в фоне выполняет цикл pull → reconcile → push (см.
/// `docs/plan-backend-sync.md`). Триггеры: вход в аккаунт, восстановление
/// сети, debounce после локальных мутаций (watch pending-записей),
/// ручной запуск из UI.
class SyncManager {
  static const _pushBatchSize = 500;
  static const _mutationDebounce = Duration(seconds: 3);

  static const _pendingStatuses = [
    'pending',
    'pending_restore',
  ];

  final AppDatabase _db;
  final Karto4kiApi _api;
  final IAuthService _auth;
  final SyncPreferences _prefs;
  final ErrorLogger _errorLogger;

  final _state = BehaviorSubject<SyncState>.seeded(const SyncState());
  final _subscriptions = <StreamSubscription<void>>[];
  Timer? _debounceTimer;
  bool _syncing = false;

  SyncManager({
    required AppDatabase database,
    required Karto4kiApi api,
    required IAuthService authService,
    required SyncPreferences preferences,
    required ErrorLogger errorLogger,
  })  : _db = database,
        _api = api,
        _auth = authService,
        _prefs = preferences,
        _errorLogger = errorLogger;

  /// Состояние синхронизации для UI.
  Stream<SyncState> get state => _state.stream;

  /// Текущее состояние.
  SyncState get currentState => _state.value;

  /// Подписки на триггеры. Вызывать один раз после создания scope.
  void start() {
    _state.add(_state.value.copyWith(lastSyncedAt: _prefs.lastSyncedAt));

    _subscriptions
      ..add(
        _auth.stateChanges.listen((authState) {
          if (authState == AuthState.authenticated) {
            unawaited(_onAuthenticated());
          }
        }),
      )
      ..add(
        Connectivity().onConnectivityChanged.listen((results) {
          final online = results.any((r) => r != ConnectivityResult.none);
          if (online) _scheduleSync();
        }),
      )
      ..add(
        _pendingCountStream.listen((count) {
          _state.add(_state.value.copyWith(pendingCount: count));
          if (count > 0) _scheduleSync();
        }),
      );

    if (_auth.isAuthenticated) {
      unawaited(_onAuthenticated());
    }
  }

  void dispose() {
    _debounceTimer?.cancel();
    for (final sub in _subscriptions) {
      sub.cancel();
    }
    _state.close();
  }

  /// Полный цикл синхронизации. Безопасно вызывать в любой момент:
  /// без авторизации и при уже идущем цикле — no-op.
  Future<void> syncNow() async {
    if (!_auth.isAuthenticated || _syncing) return;
    _syncing = true;
    _state.add(_state.value.copyWith(phase: SyncPhase.syncing));
    try {
      await _pull();
      await _push();
      await _pushAnswerEvents();
      final now = DateTime.now();
      await _prefs.setLastSyncedAt(now);
      _state.add(_state.value.copyWith(
        phase: SyncPhase.idle,
        lastSyncedAt: now,
      ));
    } on Object catch (e, st) {
      _errorLogger.logError(e, st);
      _state.add(_state.value.copyWith(phase: SyncPhase.error));
    } finally {
      _syncing = false;
    }
  }

  // ---- триггеры ----

  void _scheduleSync() {
    if (!_auth.isAuthenticated) return;
    _debounceTimer?.cancel();
    _debounceTimer = Timer(_mutationDebounce, () => unawaited(syncNow()));
  }

  /// Вход в аккаунт: смена пользователя очищает локальную базу,
  /// первый вход выгружает всё локальное на сервер.
  Future<void> _onAuthenticated() async {
    final userId = _auth.userId;
    if (userId == null) return;

    final lastUserId = _prefs.lastUserId;
    if (lastUserId != null && lastUserId != userId) {
      await _wipeLocalData();
    }
    if (lastUserId != userId) {
      await _prefs.setCursor(null);
      await _prefs.setLastUserId(userId);
    }

    await _db.testsDatabase.markAllLocalPending();
    await _db.groupsDatabase.markAllLocalPending();
    await _db.cardsDatabase.markAllLocalPending();

    await syncNow();
  }

  Future<void> _wipeLocalData() async {
    await _db.transaction(() async {
      await _db.delete(_db.testGroupEntries).go();
      await _db.delete(_db.cards).go();
      await _db.delete(_db.tests).go();
      await _db.delete(_db.testGroups).go();
      await _db.delete(_db.answerEvents).go();
      await _db.delete(_db.questionStats).go();
    });
  }

  Stream<int> get _pendingCountStream =>
      Rx.combineLatest3<List<TestGroupDatabaseDto>, List<TestDatabaseDto>,
          List<CardDatabaseDto>, int>(
        (_db.select(_db.testGroups)
              ..where((g) => g.syncStatus.isIn(_pendingStatuses)))
            .watch(),
        (_db.select(_db.tests)
              ..where((t) => t.syncStatus.isIn(_pendingStatuses)))
            .watch(),
        (_db.select(_db.cards)
              ..where((c) => c.syncStatus.isIn(_pendingStatuses)))
            .watch(),
        (g, t, c) => g.length + t.length + c.length,
      );

  // ---- pull ----

  Future<void> _pull() async {
    var cursor = _prefs.cursor;
    while (true) {
      final batch = await _api.syncChanges(since: cursor, limit: 500);
      for (final change in batch.changes) {
        await _applyChange(change);
      }
      if (batch.nextCursor != null) {
        cursor = batch.nextCursor;
        await _prefs.setCursor(cursor);
      }
      if (!batch.hasMore) break;
    }
  }

  Future<void> _applyChange(ChangeEventDto change) async {
    switch (change.entity) {
      case SyncEntityType.group:
        await _applyGroupChange(change);
      case SyncEntityType.test:
        await _applyTestChange(change);
      case SyncEntityType.card:
        await _applyCardChange(change);
      case SyncEntityType.stats:
        await _applyStatsChange(change);
      default:
        // test_session и неизвестные сущности — игнорируем.
        break;
    }
  }

  /// Удаление с сервера: строка не стирается, а замораживается
  /// (`deleted_at` + synced) — UI показывает состояние «Удалён».
  /// Удаление побеждает локальные pending-правки.
  Future<void> _applyGroupChange(ChangeEventDto change) async {
    if (change.op == SyncOpType.delete) {
      await (_db.update(_db.testGroups)
            ..where((g) => g.id.equals(change.id)))
          .write(
        TestGroupsCompanion(
          deletedAt: Value(_parseTime(change.occurredAt) ?? DateTime.now()),
          syncStatus: Value(SyncStatus.synced.dbValue),
        ),
      );
      return;
    }
    final payload = change.payload;
    if (payload == null) return;
    await _upsertGroupFromPayload(change.id, payload);
  }

  Future<void> _upsertGroupFromPayload(
    String id,
    Map<String, dynamic> payload, {
    bool force = false,
  }) async {
    final local = await _db.groupsDatabase.getGroupById(id);
    // Локальные неотправленные правки не перезаписываем — они уйдут в push.
    if (!force &&
        local != null &&
        SyncStatus.fromDb(local.syncStatus).isPending) {
      return;
    }
    await _db.groupsDatabase.upsertFromServer(
      TestGroupsCompanion(
        id: Value(id),
        title: Value(payload['title'] as String),
        syncStatus: Value(SyncStatus.synced.dbValue),
        deletedAt: const Value(null),
        createdAt: Value(_parseTime(payload['createdAt']) ?? DateTime.now()),
        updatedAt: Value(_parseTime(payload['updatedAt']) ?? DateTime.now()),
      ),
    );
  }

  Future<void> _applyTestChange(ChangeEventDto change) async {
    if (change.op == SyncOpType.delete) {
      await (_db.update(_db.tests)..where((t) => t.id.equals(change.id)))
          .write(
        TestsCompanion(
          deletedAt: Value(_parseTime(change.occurredAt) ?? DateTime.now()),
          syncStatus: Value(SyncStatus.synced.dbValue),
        ),
      );
      return;
    }
    final payload = change.payload;
    if (payload == null) return;
    await _upsertTestFromPayload(change.id, payload);
  }

  Future<void> _upsertTestFromPayload(
    String id,
    Map<String, dynamic> payload, {
    bool force = false,
  }) async {
    final local = await _db.testsDatabase.getTestById(id);
    if (!force &&
        local != null &&
        SyncStatus.fromDb(local.syncStatus).isPending) {
      return;
    }
    await _db.testsDatabase.upsertFromServer(
      TestsCompanion(
        id: Value(id),
        title: Value(payload['title'] as String),
        description: Value(payload['description'] as String?),
        type: Value(payload['type'] as String),
        syncStatus: Value(SyncStatus.synced.dbValue),
        deletedAt: const Value(null),
        createdAt: Value(_parseTime(payload['createdAt']) ?? DateTime.now()),
        updatedAt: Value(_parseTime(payload['updatedAt']) ?? DateTime.now()),
      ),
    );

    // Привязки к группам: сервер авторитетен; неизвестные локально
    // группы отбрасываем (их событие придёт раньше создания теста,
    // но страхуемся).
    final groupIds =
        (payload['groupIds'] as List<dynamic>? ?? []).cast<String>();
    final localGroupIds = <String>[];
    for (final groupId in groupIds) {
      final group = await _db.groupsDatabase.getGroupById(groupId);
      if (group != null) localGroupIds.add(groupId);
    }
    await _db.groupsDatabase.updateTestGroups(id, localGroupIds);
  }

  Future<void> _applyCardChange(ChangeEventDto change) async {
    if (change.op == SyncOpType.delete) {
      await (_db.update(_db.cards)..where((c) => c.id.equals(change.id)))
          .write(
        CardsCompanion(
          deletedAt: Value(_parseTime(change.occurredAt) ?? DateTime.now()),
          syncStatus: Value(SyncStatus.synced.dbValue),
        ),
      );
      return;
    }
    final payload = change.payload;
    if (payload == null) return;
    await _upsertCardFromPayload(change.id, payload);
  }

  Future<void> _upsertCardFromPayload(
    String id,
    Map<String, dynamic> payload, {
    bool force = false,
  }) async {
    final testId = payload['testId'] as String;
    // FK: без родительского теста карточку не применить.
    final test = await _db.testsDatabase.getTestById(testId);
    if (test == null) return;

    final local = await _db.cardsDatabase.getCardById(id);
    if (!force &&
        local != null &&
        SyncStatus.fromDb(local.syncStatus).isPending) {
      return;
    }
    final answers =
        (payload['answers'] as List<dynamic>? ?? []).cast<String>();
    await _db.cardsDatabase.upsertFromServer(
      CardsCompanion(
        id: Value(id),
        testId: Value(testId),
        question: Value(payload['front'] as String),
        answer: Value(AnswerParser.format(answers)),
        syncStatus: Value(SyncStatus.synced.dbValue),
        deletedAt: const Value(null),
        createdAt: Value(_parseTime(payload['createdAt']) ?? DateTime.now()),
        updatedAt: Value(_parseTime(payload['updatedAt']) ?? DateTime.now()),
      ),
    );
  }

  Future<void> _applyStatsChange(ChangeEventDto change) async {
    if (change.op != SyncOpType.upsert) return;
    final payload = change.payload;
    if (payload == null) return;
    await _db.questionStatsDatabase.upsertFromServer(
      questionKey: payload['questionKey'] as String,
      frontText: payload['frontText'] as String,
      backText: payload['backText'] as String,
      streak: payload['streak'] as int? ?? 0,
      totalCorrect: payload['totalCorrect'] as int? ?? 0,
      totalIncorrect: payload['totalIncorrect'] as int? ?? 0,
      totalShown: payload['totalShown'] as int? ?? 0,
      lastAnsweredAt: _parseTime(payload['lastAnsweredAt']),
      lastShownAt: _parseTime(payload['lastShownAt']),
    );
  }

  // ---- push ----

  Future<void> _push() async {
    final changes = <ChangeEventDto>[];

    final groups = await _db.groupsDatabase.getPendingGroups();
    for (final group in groups) {
      changes.add(_groupChange(group));
    }

    final tests = await _db.testsDatabase.getPendingTests();
    for (final test in tests) {
      changes.add(await _testChange(test));
    }

    final cards = await _db.cardsDatabase.getPendingCards();
    for (final card in cards) {
      final change = await _cardChange(card);
      if (change != null) changes.add(change);
    }

    for (var i = 0; i < changes.length; i += _pushBatchSize) {
      final batch = changes.sublist(
        i,
        i + _pushBatchSize > changes.length
            ? changes.length
            : i + _pushBatchSize,
      );
      final result = await _api.syncPush(SyncPushDto(changes: batch));
      final conflicts = {
        for (final c in result.conflicts) '${c.entity}:${c.id}': c,
      };
      for (final change in batch) {
        final conflict = conflicts['${change.entity}:${change.id}'];
        if (conflict == null) {
          await _markSynced(change.entity, change.id);
        } else {
          await _handleConflict(change, conflict);
        }
      }
    }
  }

  ChangeEventDto _groupChange(TestGroupDatabaseDto group) {
    if (group.deletedAt != null) {
      return ChangeEventDto(
        entity: SyncEntityType.group,
        op: SyncOpType.delete,
        id: group.id,
      );
    }
    if (SyncStatus.fromDb(group.syncStatus) == SyncStatus.pendingRestore) {
      return ChangeEventDto(
        entity: SyncEntityType.group,
        op: SyncOpType.restore,
        id: group.id,
      );
    }
    return ChangeEventDto(
      entity: SyncEntityType.group,
      op: SyncOpType.upsert,
      id: group.id,
      payload: {
        'id': group.id,
        'title': group.title,
        'testCount': 0,
        'createdAt': _toIso(group.createdAt),
        'updatedAt': _toIso(group.updatedAt),
      },
    );
  }

  Future<ChangeEventDto> _testChange(TestDatabaseDto test) async {
    if (test.deletedAt != null) {
      return ChangeEventDto(
        entity: SyncEntityType.test,
        op: SyncOpType.delete,
        id: test.id,
      );
    }
    if (SyncStatus.fromDb(test.syncStatus) == SyncStatus.pendingRestore) {
      return ChangeEventDto(
        entity: SyncEntityType.test,
        op: SyncOpType.restore,
        id: test.id,
      );
    }
    // В payload — только живые группы: бэкенд отвергает неизвестные id.
    final groupIds = await _db.groupsDatabase.getGroupIdsByTestId(test.id);
    final aliveGroupIds = <String>[];
    for (final groupId in groupIds) {
      final group = await _db.groupsDatabase.getGroupById(groupId);
      if (group != null && group.deletedAt == null) {
        aliveGroupIds.add(groupId);
      }
    }
    return ChangeEventDto(
      entity: SyncEntityType.test,
      op: SyncOpType.upsert,
      id: test.id,
      payload: {
        'id': test.id,
        'title': test.title,
        'type': test.type,
        'description': test.description,
        'questionCount': 0,
        'groupIds': aliveGroupIds,
        'createdAt': _toIso(test.createdAt),
        'updatedAt': _toIso(test.updatedAt),
      },
    );
  }

  /// null — изменение не отправляется (правка по удалённому тесту
  /// игнорируется, п. 4 плана).
  Future<ChangeEventDto?> _cardChange(CardDatabaseDto card) async {
    final test = await _db.testsDatabase.getTestById(card.testId);
    if (test == null || test.deletedAt != null) {
      await _db.cardsDatabase.setSyncStatus(card.id, SyncStatus.synced.dbValue);
      return null;
    }
    if (card.deletedAt != null) {
      return ChangeEventDto(
        entity: SyncEntityType.card,
        op: SyncOpType.delete,
        id: card.id,
      );
    }
    return ChangeEventDto(
      entity: SyncEntityType.card,
      op: SyncOpType.upsert,
      id: card.id,
      payload: {
        'id': card.id,
        'testId': card.testId,
        'front': card.question,
        'answers': AnswerParser.parse(card.answer),
        'createdAt': _toIso(card.createdAt),
        'updatedAt': _toIso(card.updatedAt),
      },
    );
  }

  Future<void> _markSynced(String entity, String id) async {
    switch (entity) {
      case SyncEntityType.group:
        await _db.groupsDatabase.setSyncStatus(id, SyncStatus.synced.dbValue);
      case SyncEntityType.test:
        await _db.testsDatabase.setSyncStatus(id, SyncStatus.synced.dbValue);
      case SyncEntityType.card:
        await _db.cardsDatabase.setSyncStatus(id, SyncStatus.synced.dbValue);
    }
  }

  /// Конфликты: по зафиксированному решению молча принимаем сервер.
  Future<void> _handleConflict(
    ChangeEventDto change,
    SyncConflictDto conflict,
  ) async {
    final server = conflict.server;
    if (conflict.reason == 'server_newer' && server != null) {
      switch (change.entity) {
        case SyncEntityType.group:
          await _upsertGroupFromPayload(change.id, server, force: true);
        case SyncEntityType.test:
          await _upsertTestFromPayload(change.id, server, force: true);
        case SyncEntityType.card:
          await _upsertCardFromPayload(change.id, server, force: true);
      }
      return;
    }
    if (conflict.reason == 'deleted') {
      // Сущность удалена на сервере — замораживаем локально.
      final now = Value(DateTime.now());
      final synced = Value(SyncStatus.synced.dbValue);
      switch (change.entity) {
        case SyncEntityType.group:
          await (_db.update(_db.testGroups)
                ..where((g) => g.id.equals(change.id)))
              .write(TestGroupsCompanion(deletedAt: now, syncStatus: synced));
        case SyncEntityType.test:
          await (_db.update(_db.tests)..where((t) => t.id.equals(change.id)))
              .write(TestsCompanion(deletedAt: now, syncStatus: synced));
        case SyncEntityType.card:
          await (_db.update(_db.cards)..where((c) => c.id.equals(change.id)))
              .write(CardsCompanion(deletedAt: now, syncStatus: synced));
      }
      return;
    }
    // Неизвестная причина: снимаем pending, чтобы не зациклить push;
    // следующий pull выровняет состояние.
    _errorLogger.logError(
      'Sync conflict ${conflict.reason} for ${change.entity}:${change.id}',
      StackTrace.current,
    );
    await _markSynced(change.entity, change.id);
  }

  // ---- статистика ----

  Future<void> _pushAnswerEvents() async {
    while (true) {
      final events = await _db.answerEventsDatabase.getUnsentEvents();
      if (events.isEmpty) break;
      await _api.pushAnswerEvents(
        BatchAnswerEventsDto(
          events: [
            for (final event in events)
              AnswerEventDto(
                cardId: event.cardId,
                isCorrect: event.isCorrect,
                answeredAt: _toIso(event.answeredAt),
              ),
          ],
        ),
      );
      // notFound (карточка удалена на сервере) — события просто дропаются.
      await _db.answerEventsDatabase
          .markSent(events.map((e) => e.id).toList());
    }
    await _db.answerEventsDatabase.deleteSent();
  }

  // ---- утилиты ----

  static String _toIso(DateTime value) => value.toUtc().toIso8601String();

  static DateTime? _parseTime(Object? value) {
    if (value is! String || value.isEmpty) return null;
    return DateTime.tryParse(value)?.toLocal();
  }
}
