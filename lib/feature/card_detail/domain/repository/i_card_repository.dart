import 'package:quizzerg/core/feature/core/entity/request_operation.dart';
import 'package:quizzerg/feature/main/domain/entity/card_entity.dart';

/// Repository interface for working with cards.
///
/// Provides CRUD operations for cards.
abstract interface class ICardRepository {
  /// Get all cards.
  RequestOperation<List<CardEntity>> getCards();

  /// Get card by ID.
  ///
  /// Returns `null` if card not found.
  RequestOperation<CardEntity?> getCardById(int id);

  /// Get cards by test ID.
  RequestOperation<List<CardEntity>> getCardsByTestId(int testId);

  /// Create new card.
  RequestOperation<void> createCard(CardEntity card);

  /// Update existing card.
  RequestOperation<void> updateCard(CardEntity card);

  /// Delete card by ID.
  RequestOperation<void> deleteCard(int id);
}
