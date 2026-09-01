import 'dart:convert';

import 'package:drift/drift.dart';

import 'package:quizzerg/core/utils/answers_codec.dart';
import 'package:quizzerg/core/utils/uuid_generator.dart';
import 'package:quizzerg/feature/question_stats/domain/util/question_key_normalizer.dart';
import 'package:quizzerg/feature/sync/domain/entity/sync_entity_type.dart';
import 'package:quizzerg/feature/sync/domain/entity/sync_state.dart';
import 'package:quizzerg/feature/sync/domain/service/sync_clock.dart';
import 'package:quizzerg/feature/sync/domain/service/sync_entity_adapter.dart';
import 'package:quizzerg/feature/test_detail/data/database/cards_database.dart';
import 'package:quizzerg/feature/test_detail/data/dto/card_dto.dart';
import 'package:quizzerg/persistence/database/app_database.dart';

/// Адаптер синхронизации карточек.
class CardSyncAdapter implements SyncEntityAdapter {
  final CardsDatabase _cardsDatabase;

  const CardSyncAdapter({required CardsDatabase cardsDatabase})
      : _cardsDatabase = cardsDatabase;

  @override
  SyncEntityType get entity => SyncEntityType.card;

  @override
  Future<List<SyncDirtyChange>> collectDirty({required int limit}) async {
    final rows = await _cardsDatabase.getPendingCards(limit: limit);

    return rows.map(_toChange).toList();
  }

  @override
  Future<bool> isPending(String id) async {
    final row = await _cardsDatabase.getCardByIdRaw(id);

    return row != null && SyncState.fromDb(row.syncState) == SyncState.pending;
  }

  @override
  Future<void> applyUpsert(String id, Map<String, dynamic> payload) async {
    final dto = CardDto.fromJson(payload);

    await _cardsDatabase.upsertCard(
      CardsCompanion.insert(
        id: dto.id,
        testId: dto.testId,
        front: dto.front,
        answers: AnswersCodec.encode(dto.answers),
        questionKey: dto.questionKey ??
            QuestionKeyNormalizer.normalize(dto.front, dto.answers),
        createdAt: dto.createdAt,
        updatedAt: dto.updatedAt,
        basePayload: Value(jsonEncode(payload)),
        serverUpdatedAt: Value(SyncClock.format(dto.updatedAt)),
        syncState: Value(SyncState.synced.dbValue),
      ),
    );
  }

  @override
  Future<void> applyDelete(String id) => _cardsDatabase.purgeCardById(id);

  @override
  Future<void> confirmUpsert(String id, Map<String, dynamic>? payload) async {
    if (payload == null) {
      await _cardsDatabase.writeSyncFields(
        id,
        CardsCompanion(syncState: Value(SyncState.synced.dbValue)),
      );

      return;
    }

    final dto = CardDto.fromJson(payload);
    await _cardsDatabase.writeSyncFields(
      id,
      CardsCompanion(
        updatedAt: Value(dto.updatedAt),
        basePayload: Value(jsonEncode(payload)),
        serverUpdatedAt: Value(SyncClock.format(dto.updatedAt)),
        syncState: Value(SyncState.synced.dbValue),
      ),
      notNewerThan: dto.updatedAt,
    );
  }

  @override
  Future<void> confirmDelete(String id) => _cardsDatabase.purgeCardById(id);

  @override
  Future<void> dropLocal(String id) => _cardsDatabase.purgeCardById(id);

  /// Локальный текст карточки заливается новой карточкой с новым uuid.
  ///
  /// Дубли на сервере чистятся дедупом по `(front, answers)`.
  @override
  Future<void> reuploadAsNew(
    String id,
    Map<String, dynamic> localPayload,
  ) async {
    final testId = localPayload['testId'] as String?;
    final front = localPayload['front'] as String?;
    final rawAnswers = localPayload['answers'];
    if (testId == null || front == null || rawAnswers is! List) return;

    final answers = rawAnswers.map((it) => it.toString()).toList();
    final now = DateTime.now().toUtc();

    await _cardsDatabase.insertCard(
      CardsCompanion.insert(
        id: UuidGenerator.v7(),
        testId: testId,
        front: front,
        answers: AnswersCodec.encode(answers),
        questionKey: QuestionKeyNormalizer.normalize(front, answers),
        createdAt: now,
        updatedAt: now,
      ),
    );
  }

  SyncDirtyChange _toChange(CardDatabaseDto row) {
    final occurredAt = row.updatedAt.toUtc();

    if (row.deletedAt != null) {
      return SyncDirtyChange(
        entity: entity,
        op: SyncOp.delete,
        id: row.id,
        occurredAt: occurredAt,
      );
    }

    final updatedAt = SyncClock.bumpedUpdatedAt(
      SyncClock.parseServerUpdatedAt(row.serverUpdatedAt),
    );

    return SyncDirtyChange(
      entity: entity,
      op: SyncOp.upsert,
      id: row.id,
      occurredAt: occurredAt,
      payload: {
        'id': row.id,
        'testId': row.testId,
        'front': row.front,
        'answers': AnswersCodec.decode(row.answers),
        'createdAt': SyncClock.format(row.createdAt),
        'updatedAt': SyncClock.format(updatedAt),
      },
    );
  }
}
