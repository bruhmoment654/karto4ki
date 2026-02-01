import 'package:karto4ki/feature/main/domain/entity/card_entity.dart';

/// Repository interface for working with cards.
///
/// Provides CRUD operations for cards.
// TODO(karto4ki): Add id and testId fields to CardEntity for full method functionality.
abstract interface class ICardRepository {
  /// Get all cards.
  Future<List<CardEntity>> getCards();

  /// Get card by ID.
  ///
  /// Returns `null` if card not found.
  // TODO(karto4ki): Requires adding id field to CardEntity.
  Future<CardEntity?> getCardById(int id);

  /// Get cards by test ID.
  // TODO(karto4ki): Requires adding testId field to CardEntity.
  Future<List<CardEntity>> getCardsByTestId(int testId);

  /// Create new card.
  Future<void> createCard(CardEntity card);

  /// Update existing card.
  // TODO(karto4ki): Requires adding id field to CardEntity for identification.
  Future<void> updateCard(CardEntity card);

  /// Delete card by ID.
  Future<void> deleteCard(int id);
}
