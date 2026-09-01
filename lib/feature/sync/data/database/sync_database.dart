import 'package:drift/drift.dart';

import 'package:quizzerg/persistence/database/app_database.dart';

part 'sync_database.g.dart';

/// DAO служебных таблиц синхронизации: курсор и журнал ответов.
@DriftAccessor(
  include: {'package:quizzerg/feature/sync/data/database/sync.drift'},
)
class SyncDatabase extends DatabaseAccessor<AppDatabase>
    with _$SyncDatabaseMixin {
  SyncDatabase(super.attachedDatabase);

  /// Прочитать значение метаданных.
  Future<String?> getMeta(String key) async {
    final row = await (select(syncMeta)
          ..where((meta) => meta.metaKey.equals(key)))
        .getSingleOrNull();
    return row?.metaValue;
  }

  /// Записать значение метаданных.
  Future<void> setMeta(String key, String value) =>
      into(syncMeta).insertOnConflictUpdate(
        SyncMetaCompanion.insert(metaKey: key, metaValue: value),
      );

  /// Удалить значение метаданных.
  Future<int> removeMeta(String key) =>
      (delete(syncMeta)..where((meta) => meta.metaKey.equals(key))).go();

  /// Полностью очистить метаданные (например, при смене аккаунта).
  Future<int> clearMeta() => delete(syncMeta).go();

  /// Положить ответы в журнал.
  ///
  /// Дубли по `(card_id, answered_at)` игнорируются — тем же ключом
  /// дедуплицирует сервер.
  Future<void> enqueueAnswers(List<AnswerEventsOutboxCompanion> events) async {
    if (events.isEmpty) return;

    await batch((batch) {
      batch.insertAll(
        answerEventsOutbox,
        events,
        mode: InsertMode.insertOrIgnore,
      );
    });
  }

  /// Неотправленные ответы.
  Future<List<AnswerEventOutboxDatabaseDto>> getUnsentAnswers({
    required int limit,
  }) =>
      (select(answerEventsOutbox)
            ..where((event) => event.sentAt.isNull())
            ..orderBy([(event) => OrderingTerm.asc(event.answeredAt)])
            ..limit(limit))
          .get();

  /// Отметить ответы отправленными.
  Future<void> markAnswersSent(List<int> ids) async {
    if (ids.isEmpty) return;

    await (update(answerEventsOutbox)..where((event) => event.id.isIn(ids)))
        .write(
      AnswerEventsOutboxCompanion(sentAt: Value(DateTime.now().toUtc())),
    );
  }

  /// Вычистить отправленные ответы старше указанной даты.
  Future<int> purgeSentAnswers({required DateTime before}) =>
      (delete(answerEventsOutbox)
            ..where((event) =>
                event.sentAt.isNotNull() &
                event.sentAt.isSmallerThanValue(before)))
          .go();
}
