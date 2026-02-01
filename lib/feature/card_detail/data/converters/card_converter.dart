import 'package:drift/drift.dart';

import 'package:karto4ki/feature/main/domain/entity/card_entity.dart';
import 'package:karto4ki/persistence/database/app_database.dart';

/// Converter for [CardEntity] and [CardDatabaseDto].
abstract final class CardConverter {
  /// Converts [CardDatabaseDto] to [CardEntity].
  static CardEntity fromDto(CardDatabaseDto dto) {
    return CardEntity(
      id: dto.id.toString(),
      testId: dto.testId.toString(),
      front: dto.question,
      back: dto.answer,
      createdAt: dto.createdAt,
      updatedAt: dto.updatedAt,
    );
  }

  /// Converts [CardEntity] to [CardsCompanion] for insert/update.
  static CardsCompanion toCompanion(
    CardEntity entity, {
    bool updateTimestamp = true,
  }) {
    final now = DateTime.now();
    return CardsCompanion(
      id: entity.id.isNotEmpty
          ? Value(int.parse(entity.id))
          : const Value.absent(),
      testId: Value(int.parse(entity.testId)),
      question: Value(entity.front),
      answer: Value(entity.back),
      createdAt: Value(entity.createdAt),
      updatedAt: updateTimestamp ? Value(now) : Value(entity.updatedAt),
    );
  }

  /// Creates a new [CardsCompanion] for inserting a new card.
  static CardsCompanion toNewCompanion({
    required int testId,
    required String front,
    required String back,
  }) {
    final now = DateTime.now();
    return CardsCompanion.insert(
      testId: testId,
      question: front,
      answer: back,
      createdAt: now,
      updatedAt: now,
    );
  }
}
