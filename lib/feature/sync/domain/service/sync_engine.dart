import 'package:quizzerg/core/logger/error_logger.dart';
import 'package:quizzerg/feature/question_stats/data/dto/answer_event_dto.dart';
import 'package:quizzerg/feature/sync/data/database/sync_database.dart';
import 'package:quizzerg/feature/sync/data/dto/change_event_dto.dart';
import 'package:quizzerg/feature/sync/data/dto/sync_push_dto.dart';
import 'package:quizzerg/feature/sync/domain/entity/sync_entity_type.dart';
import 'package:quizzerg/feature/sync/domain/entity/sync_meta_keys.dart';
import 'package:quizzerg/feature/sync/domain/entity/sync_progress.dart';
import 'package:quizzerg/feature/sync/domain/entity/sync_run_result.dart';
import 'package:quizzerg/feature/sync/domain/repository/i_sync_api_repository.dart';
import 'package:quizzerg/feature/sync/domain/service/conflict_policy.dart';
import 'package:quizzerg/feature/sync/domain/service/server_clock.dart';
import 'package:quizzerg/feature/sync/domain/service/sync_clock.dart';
import 'package:quizzerg/feature/sync/domain/service/sync_entity_adapter.dart';
import 'package:quizzerg/feature/sync/domain/service/sync_pull_progress.dart';
import 'package:quizzerg/network/error/api_exception.dart';
import 'package:quizzerg/persistence/database/app_database.dart';

/// Движок offline-first синхронизации.
///
/// Порядок фиксирован: сначала забираем серверные изменения, потом отдаём
/// свои, потом — журнал ответов. Обратный порядок приводил бы к тому, что
/// свежий pull затирал бы только что отправленные правки.
class SyncEngine {
  /// Размер страницы pull. Лимит сервера — 1000.
  static const pullPageSize = 500;

  /// Максимум изменений в одном push — ограничение сервера.
  static const pushBatchLimit = 1000;

  /// Максимум событий в одном батче ответов — ограничение сервера.
  static const answersBatchLimit = 1000;

  /// Сколько держать отправленные ответы, прежде чем вычистить.
  static const sentAnswersTtl = Duration(days: 7);

  /// Страховка от сервера, который перестал двигать курсор.
  static const maxPullPages = 1000;

  /// Максимум батчей push за один прогон.
  ///
  /// Очередь разгребается циклом: за первый вход в аккаунт накапливается
  /// заметно больше [pushBatchLimit] строк, а следующий прогон запускается
  /// только по внешнему событию — без цикла хвост висел бы до ближайшей
  /// правки или переподключения сети.
  static const maxPushBatches = 20;

  /// Порядок сущностей при отправке: сначала владельцы, потом зависимые.
  ///
  /// Статистика идёт последней: она ни от чего не зависит (сервер находит
  /// строку по `questionKey`), но и торопиться ей некуда.
  static const _upsertOrder = [
    SyncEntityType.group,
    SyncEntityType.test,
    SyncEntityType.card,
    SyncEntityType.stats,
  ];

  final ISyncApiRepository _api;
  final SyncDatabase _syncDatabase;
  final Map<SyncEntityType, SyncEntityAdapter> _adapters;
  final ServerClock _serverClock;
  final ErrorLogger _errorLogger;

  /// Последнее увиденное за прогон серверное время.
  DateTime? _lastServerTime;

  SyncEngine({
    required ISyncApiRepository api,
    required SyncDatabase syncDatabase,
    required List<SyncEntityAdapter> adapters,
    required ServerClock serverClock,
    required ErrorLogger errorLogger,
  })  : _api = api,
        _syncDatabase = syncDatabase,
        _serverClock = serverClock,
        _errorLogger = errorLogger,
        _adapters = {for (final adapter in adapters) adapter.entity: adapter};

  /// Часы сервера, по которым считается относительная подпись «N назад».
  ServerClock get serverClock => _serverClock;

  /// Полный цикл синхронизации. Наружу не бросает — ошибка приезжает
  /// в [SyncRunResult.error].
  Future<SyncRunResult> sync({void Function(SyncProgress? progress)? onProgress}) async {
    final isBootstrap =
        await _syncDatabase.getMeta(SyncMetaKeys.cursor) == null;
    final conflicts = <SyncConflictReport>[];
    _lastServerTime = null;
    var pulled = 0;
    var pushed = 0;
    var answersSent = 0;

    try {
      pulled = await _pull(onProgress: onProgress);
      pushed = await _pushDirty(conflicts);
      answersSent = await _pushAnswers();
    } on ApiException catch (error, stackTrace) {
      _errorLogger.logError(error, stackTrace);

      return SyncRunResult(
        pulled: pulled,
        pushed: pushed,
        answersSent: answersSent,
        conflicts: conflicts,
        error: error,
        isBootstrap: isBootstrap,
      );
    } on Object catch (error, stackTrace) {
      _errorLogger.logError(error, stackTrace);

      return SyncRunResult(
        pulled: pulled,
        pushed: pushed,
        answersSent: answersSent,
        conflicts: conflicts,
        error: UnknownApiException(
          message: error.toString(),
          stackTrace: stackTrace,
        ),
        isBootstrap: isBootstrap,
      );
    }

    await _writeLastSyncedAt();

    return SyncRunResult(
      pulled: pulled,
      pushed: pushed,
      answersSent: answersSent,
      conflicts: conflicts,
      isBootstrap: isBootstrap,
    );
  }

  /// Время последней успешной синхронизации.
  Future<DateTime?> lastSyncedAt() async => SyncClock.parseServerUpdatedAt(
        await _syncDatabase.getMeta(SyncMetaKeys.lastSyncedAt),
      );

  /// Откуда взято [lastSyncedAt]: серверные часы или локальные.
  Future<SyncTimeSource> lastSyncedSource() async => SyncTimeSource.fromDb(
        await _syncDatabase.getMeta(SyncMetaKeys.lastSyncedSource),
      );

  /// Поднять сдвиг часов после холодного старта.
  Future<void> restoreClock() async {
    final raw = await _syncDatabase.getMeta(SyncMetaKeys.clockSkewMs);
    final millis = raw == null ? null : int.tryParse(raw);
    if (millis == null) return;

    _serverClock.restore(Duration(milliseconds: millis));
  }

  /// Сколько локальных изменений ещё не уехало на сервер.
  ///
  /// Статистика в счётчик входит: сервер принимает её на push и сливает со
  /// своим агрегатом, так что pending-строки действительно уедут.
  /// `test_session` адаптера не имеет вовсе — он pull-only.
  Future<int> pendingCount() async =>
      await _syncDatabase.countUnsentAnswers() + await _dirtyCount();

  /// Сбросить состояние синхронизации (например, при смене аккаунта).
  Future<void> resetCursor() => _syncDatabase.removeMeta(SyncMetaKeys.cursor);

  /// Запомнить момент прогона.
  ///
  /// `serverTime` из тела ответа, а не заголовок `Date`: на проде `Date`
  /// ставит последний хоп цепочки, и точность у него секундная.
  Future<void> _writeLastSyncedAt() async {
    final serverTime = _lastServerTime;
    final source = serverTime == null
        ? SyncTimeSource.local
        : SyncTimeSource.server;

    await _syncDatabase.setMeta(
      SyncMetaKeys.lastSyncedAt,
      SyncClock.format(serverTime ?? DateTime.now()),
    );
    await _syncDatabase.setMeta(
      SyncMetaKeys.lastSyncedSource,
      source.dbValue,
    );
  }

  /// Учесть серверное время из очередного ответа.
  Future<void> _noteServerTime(DateTime? serverTime) async {
    if (serverTime == null) return;

    _lastServerTime = serverTime;
    _serverClock.syncWith(serverTime);
    await _syncDatabase.setMeta(
      SyncMetaKeys.clockSkewMs,
      _serverClock.skew.inMilliseconds.toString(),
    );
  }

  Future<int> _pull({void Function(SyncProgress? progress)? onProgress}) async {
    var cursor = await _syncDatabase.getMeta(SyncMetaKeys.cursor);
    final progress = SyncPullProgress();
    var applied = 0;

    for (var page = 0; page < maxPullPages; page++) {
      final response = await _api.changes(since: cursor, limit: pullPageSize);
      await _noteServerTime(response.serverTime);

      for (final change in response.changes) {
        if (await _apply(change)) applied++;
      }

      final remaining = response.remaining;
      onProgress?.call(progress.update(remaining));

      final next = response.nextCursor;
      if (next != null && next != cursor) {
        cursor = next;
        await _syncDatabase.setMeta(SyncMetaKeys.cursor, next);
      } else if (response.hasMore) {
        // Сервер говорит «есть ещё», но курсор не сдвинулся — выходим,
        // иначе цикл станет бесконечным.
        break;
      }

      // `remaining` согласован с `hasMore`, но точнее: на границе страницы
      // ровно в лимит он избавляет от лишнего пустого запроса.
      if (remaining != null && remaining == 0) break;
      if (!response.hasMore) break;
    }

    return applied;
  }

  Future<bool> _apply(ChangeEventDto change) async {
    final adapter = _adapters[change.entity];
    if (adapter == null) return false;

    // Правило 3: локальная правка приоритетнее эха собственного push.
    if (await adapter.isPending(change.id)) return false;

    switch (change.op) {
      case SyncOp.upsert:
        final payload = change.payload;
        // Сущность успела удалиться — снимка нет, падать нельзя.
        if (payload == null) return false;
        await adapter.applyUpsert(change.id, payload);

        return true;
      case SyncOp.delete:
        await adapter.applyDelete(change.id);

        return true;
      case SyncOp.restore:
      case SyncOp.unknown:
        return false;
    }
  }

  /// Отдать все локальные изменения, а не только первый батч.
  ///
  /// `stats` стоит последним в [_upsertOrder], поэтому именно статистику
  /// срезает `take(pushBatchLimit)` в [_collectDirty] — без цикла на первом
  /// входе уезжала бы лишь её часть.
  Future<int> _pushDirty(List<SyncConflictReport> conflicts) async {
    var total = 0;
    var previousDirty = -1;

    for (var batch = 0; batch < maxPushBatches; batch++) {
      final changes = await _collectDirty();
      if (changes.isEmpty) break;

      total += await _pushBatch(changes, conflicts);

      // Собрали меньше лимита — значит собрали всё, что было.
      if (changes.length < pushBatchLimit) break;

      // Очередь не сдвинулась: сервер отклонил весь батч, и следующий заход
      // соберёт ровно те же строки. Крутиться до упора смысла нет.
      final dirty = await _dirtyCount();
      if (dirty == previousDirty) break;
      previousDirty = dirty;
    }

    return total;
  }

  /// Сколько локальных строк ждёт отправки — без учёта журнала ответов.
  Future<int> _dirtyCount() async {
    var total = 0;

    for (final adapter in _adapters.values) {
      total += await adapter.countDirty();
    }

    return total;
  }

  Future<int> _pushBatch(
    List<SyncDirtyChange> changes,
    List<SyncConflictReport> conflicts,
  ) async {
    final result = await _api.push(changes.map(_toDto).toList());
    await _noteServerTime(result.serverTime);

    final pushedById = {
      for (final change in changes) _key(change.entity, change.id): change,
    };
    final conflicted = {
      for (final conflict in result.conflicts)
        _key(conflict.entity, conflict.id),
    };

    await _confirmApplied(result.appliedItems, pushedById, conflicted);
    await _handleConflicts(result.conflicts, pushedById, conflicts);

    return result.applied;
  }

  Future<void> _confirmApplied(
    List<AppliedChangeDto> appliedItems,
    Map<String, SyncDirtyChange> pushedById,
    Set<String> conflicted,
  ) async {
    final confirmed = <String>{};

    for (final applied in appliedItems) {
      final key = _key(applied.entity, applied.id);
      final change = pushedById[key];
      final adapter = _adapters[applied.entity];
      if (change == null || adapter == null) continue;

      confirmed.add(key);
      await _confirm(adapter, change, applied.payload);
    }

    // Фолбэк для сервера без appliedItems: всё, что не попало в конфликты,
    // считаем применённым — иначе строки будут пушиться бесконечно.
    // Включается только когда сервер вообще не прислал снимков.
    if (appliedItems.isNotEmpty) return;

    for (final entry in pushedById.entries) {
      if (conflicted.contains(entry.key)) continue;

      final adapter = _adapters[entry.value.entity];
      if (adapter == null) continue;

      await _confirm(adapter, entry.value, null);
    }
  }

  Future<void> _confirm(
    SyncEntityAdapter adapter,
    SyncDirtyChange change,
    Map<String, dynamic>? payload,
  ) async {
    if (change.op == SyncOp.delete) {
      await adapter.confirmDelete(change.id);

      return;
    }

    await adapter.confirmUpsert(change.id, payload);
  }

  Future<void> _handleConflicts(
    List<SyncConflictDto> serverConflicts,
    Map<String, SyncDirtyChange> pushedById,
    List<SyncConflictReport> reports,
  ) async {
    for (final conflict in serverConflicts) {
      final adapter = _adapters[conflict.entity];
      if (adapter == null) continue;

      final pushed = pushedById[_key(conflict.entity, conflict.id)];
      final decision = ConflictPolicy.resolve(
        conflict: conflict,
        pushedPayload: pushed?.payload,
      );

      await _applyDecision(adapter, conflict, decision, pushed);

      if (decision.shouldReport) {
        reports.add(
          SyncConflictReport(
            entity: conflict.entity,
            id: conflict.id,
            reason: conflict.reason,
          ),
        );
      }
    }
  }

  Future<void> _applyDecision(
    SyncEntityAdapter adapter,
    SyncConflictDto conflict,
    ConflictDecision decision,
    SyncDirtyChange? pushed,
  ) async {
    switch (decision.action) {
      case ConflictAction.acceptServer:
        await _acceptServer(adapter, conflict);
      case ConflictAction.acceptServerAndReupload:
        final payload = pushed?.payload;
        if (payload != null) await adapter.reuploadAsNew(conflict.id, payload);
        await _acceptServer(adapter, conflict);
      case ConflictAction.dropLocal:
        await adapter.dropLocal(conflict.id);
      case ConflictAction.keepPending:
        break;
    }
  }

  Future<void> _acceptServer(
    SyncEntityAdapter adapter,
    SyncConflictDto conflict,
  ) async {
    final server = conflict.server;
    if (server == null) {
      await adapter.confirmUpsert(conflict.id, null);

      return;
    }

    await adapter.applyUpsert(conflict.id, server);
  }

  Future<List<SyncDirtyChange>> _collectDirty() async {
    final upserts = <SyncDirtyChange>[];
    final deletes = <SyncDirtyChange>[];

    for (final entity in _upsertOrder) {
      final adapter = _adapters[entity];
      if (adapter == null) continue;

      final changes = await adapter.collectDirty(limit: pushBatchLimit);
      for (final change in changes) {
        if (change.op == SyncOp.delete) {
          deletes.add(change);
        } else {
          upserts.add(change);
        }
      }
    }

    // Удаления — в обратном порядке зависимостей.
    return [...upserts, ...deletes.reversed].take(pushBatchLimit).toList();
  }

  Future<int> _pushAnswers() async {
    var total = 0;

    for (var batch = 0; batch < maxPushBatches; batch++) {
      final rows =
          await _syncDatabase.getUnsentAnswers(limit: answersBatchLimit);
      if (rows.isEmpty) break;

      final sent = await _sendAnswersBatch(rows);
      total += sent.applied;

      // Ничего не пометили отправленным — весь батч остался в outbox, и
      // следующий заход вычитает те же строки.
      if (!sent.hasProgress) break;
      if (rows.length < answersBatchLimit) break;
    }

    await _syncDatabase.purgeSentAnswers(
      before: DateTime.now().toUtc().subtract(sentAnswersTtl),
    );

    return total;
  }

  Future<({int applied, bool hasProgress})> _sendAnswersBatch(
    List<AnswerEventOutboxDatabaseDto> rows,
  ) async {
    final result = await _api.pushAnswers(
      rows
          .map(
            (row) => AnswerEventDto(
              cardId: row.cardId,
              isCorrect: row.isCorrect,
              answeredAt: row.answeredAt.toUtc(),
            ),
          )
          .toList(),
    );

    // Событие по карточке, которой сервер не знает, остаётся в outbox:
    // карточка доедет следующим push, и ответ применится. Пометить его
    // отправленным — значит потерять ответ навсегда, восстановить его
    // потом нечем: статистику считает сервер, а событий у него нет.
    final missing = result.notFound.toSet();
    final sentIds = rows
        .where((row) => !missing.contains(row.cardId))
        .map((row) => row.id)
        .toList();

    if (sentIds.isNotEmpty) await _syncDatabase.markAnswersSent(sentIds);

    return (applied: result.applied, hasProgress: sentIds.isNotEmpty);
  }

  ChangeEventDto _toDto(SyncDirtyChange change) => ChangeEventDto(
        entity: change.entity,
        op: change.op,
        id: change.id,
        payload: change.payload,
        occurredAt: change.occurredAt,
      );

  String _key(SyncEntityType entity, String id) => '${entity.wireValue}:$id';
}
