import 'package:drift/drift.dart';
import 'package:quizzerg/core/sync/domain/entity/sync_status.dart';
import 'package:quizzerg/core/utils/answer_parser.dart';
import 'package:quizzerg/feature/main/domain/entity/card_entity.dart';
import 'package:quizzerg/persistence/database/app_database.dart';
import 'package:uuid/uuid.dart';

/// Converter for [CardEntity] and [CardDatabaseDto].
abstract final class CardConverter {
  static const _uuid = Uuid();

  /// Converts [CardDatabaseDto] to [CardEntity].
  static CardEntity fromDto(CardDatabaseDto dto) {
    return CardEntity(
      id: dto.id,
      testId: dto.testId,
      front: dto.question,
      answers: AnswerParser.parse(dto.answer),
      createdAt: dto.createdAt,
      updatedAt: dto.updatedAt,
      syncStatus: SyncStatus.fromDb(dto.syncStatus),
    );
  }

  /// Converts [CardEntity] to [CardsCompanion] for insert/update.
  ///
  /// Локальная мутация помечает карточку как ожидающую отправки на бэкенд.
  static CardsCompanion toCompanion(
    CardEntity entity, {
    bool updateTimestamp = true,
  }) {
    final now = DateTime.now();
    return CardsCompanion(
      id: Value(entity.id.isNotEmpty ? entity.id : _uuid.v4()),
      testId: Value(entity.testId),
      question: Value(entity.front),
      answer: Value(AnswerParser.format(entity.answers)),
      syncStatus: Value(SyncStatus.pending.dbValue),
      createdAt: Value(entity.createdAt),
      updatedAt: updateTimestamp ? Value(now) : Value(entity.updatedAt),
    );
  }

  /// Creates a new [CardsCompanion] for inserting a new card.
  static CardsCompanion toNewCompanion({
    required String testId,
    required String front,
    required String back,
  }) {
    final now = DateTime.now();
    return CardsCompanion.insert(
      id: _uuid.v4(),
      testId: testId,
      question: front,
      answer: back,
      syncStatus: Value(SyncStatus.pending.dbValue),
      createdAt: now,
      updatedAt: now,
    );
  }
}
