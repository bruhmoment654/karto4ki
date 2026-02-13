import 'package:quizzerg/feature/main/domain/entity/card_entity.dart';

/// Repository interface for working with cards.
///
/// Provides CRUD operations for cards.
abstract interface class ICardRepository {
  /// Get all cards.
  Future<List<CardEntity>> getCards();

  /// Get card by ID.
  ///
  /// Returns `null` if card not found.
  Future<CardEntity?> getCardById(int id);

  /// Get cards by test ID.
  Future<List<CardEntity>> getCardsByTestId(int testId);

  /// Create new card.
  Future<void> createCard(CardEntity card);

  /// Update existing card.
  Future<void> updateCard(CardEntity card);

  /// Delete card by ID.
  Future<void> deleteCard(int id);
}
