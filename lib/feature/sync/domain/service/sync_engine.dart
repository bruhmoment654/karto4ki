import 'package:quizzerg/core/logger/error_logger.dart';
import 'package:quizzerg/feature/question_stats/data/dto/answer_event_dto.dart';
import 'package:quizzerg/feature/sync/data/database/sync_database.dart';
import 'package:quizzerg/feature/sync/data/dto/change_event_dto.dart';
import 'package:quizzerg/feature/sync/data/dto/sync_push_dto.dart';
import 'package:quizzerg/feature/sync/domain/entity/sync_entity_type.dart';
import 'package:quizzerg/feature/sync/domain/entity/sync_meta_keys.dart';
import 'package:quizzerg/feature/sync/domain/entity/sync_run_result.dart';
import 'package:quizzerg/feature/sync/domain/repository/i_sync_api_repository.dart';
import 'package:quizzerg/feature/sync/domain/service/conflict_policy.dart';
import 'package:quizzerg/feature/sync/domain/service/sync_clock.dart';
import 'package:quizzerg/feature/sync/domain/service/sync_entity_adapter.dart';
import 'package:quizzerg/network/error/api_exception.dart';

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

  /// Порядок сущностей при отправке: сначала владельцы, потом зависимые.
  static const _upsertOrder = [
    SyncEntityType.group,
    SyncEntityType.test,
    SyncEntityType.card,
  ];

  final ISyncApiRepository _api;
  final SyncDatabase _syncDatabase;
  final Map<SyncEntityType, SyncEntityAdapter> _adapters;
  final ErrorLogger _errorLogger;

  SyncEngine({
    required ISyncApiRepository api,
    required SyncDatabase syncDatabase,
    required List<SyncEntityAdapter> adapters,
    required ErrorLogger errorLogger,
  })  : _api = api,
        _syncDatabase = syncDatabase,
        _errorLogger = errorLogger,
        _adapters = {for (final adapter in adapters) adapter.entity: adapter};

  /// Полный цикл синхронизации. Наружу не бросает — ошибка приезжает
  /// в [SyncRunResult.error].
  Future<SyncRunResult> sync() async {
    final isBootstrap =
        await _syncDatabase.getMeta(SyncMetaKeys.cursor) == null;
    final conflicts = <SyncConflictReport>[];
    var pulled = 0;
    var pushed = 0;
    var answersSent = 0;

    try {
      pulled = await _pull();
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

    await _syncDatabase.setMeta(
      SyncMetaKeys.lastSyncedAt,
      SyncClock.format(DateTime.now()),
    );

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

  /// Сбросить состояние синхронизации (например, при смене аккаунта).
  Future<void> resetCursor() => _syncDatabase.removeMeta(SyncMetaKeys.cursor);

  Future<int> _pull() async {
    var cursor = await _syncDatabase.getMeta(SyncMetaKeys.cursor);
    var applied = 0;

    for (var page = 0; page < maxPullPages; page++) {
      final response = await _api.changes(since: cursor, limit: pullPageSize);

      for (final change in response.changes) {
        if (await _apply(change)) applied++;
      }

      final next = response.nextCursor;
      if (next != null && next != cursor) {
        cursor = next;
        await _syncDatabase.setMeta(SyncMetaKeys.cursor, next);
      } else if (response.hasMore) {
        // Сервер говорит «есть ещё», но курсор не сдвинулся — выходим,
        // иначе цикл станет бесконечным.
        break;
      }

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

  Future<int> _pushDirty(List<SyncConflictReport> conflicts) async {
    final changes = await _collectDirty();
    if (changes.isEmpty) return 0;

    final result = await _api.push(changes.map(_toDto).toList());

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
    final rows = await _syncDatabase.getUnsentAnswers(limit: answersBatchLimit);
    if (rows.isEmpty) return 0;

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

    // notFound ретраить бессмысленно: карточки на сервере нет.
    await _syncDatabase.markAnswersSent(rows.map((row) => row.id).toList());
    await _syncDatabase.purgeSentAnswers(
      before: DateTime.now().toUtc().subtract(sentAnswersTtl),
    );

    return result.applied;
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
