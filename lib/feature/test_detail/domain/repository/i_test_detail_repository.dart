import 'package:quizzerg/core/feature/core/entity/request_operation.dart';
import 'package:quizzerg/feature/main/domain/entity/card_entity.dart';
import 'package:quizzerg/feature/tests_list/domain/entity/test_entity.dart';

/// Repository interface for test detail screen.
abstract interface class ITestDetailRepository {
  /// Get test by id.
  RequestOperation<TestEntity?> getTestById(String testId);

  /// Get cards for test.
  RequestOperation<List<CardEntity>> getCardsByTestId(String testId);

  /// Add new card to test.
  RequestOperation<void> addCard({
    required String testId,
    required String front,
    required String back,
  });

  /// Update existing card.
  RequestOperation<void> updateCard(CardEntity card);

  /// Soft delete card by id.
  RequestOperation<void> deleteCard(String cardId);

  /// Update test information.
  RequestOperation<void> updateTest(TestEntity test);

  /// Add multiple cards to test (batch insert).
  RequestOperation<void> addCards({
    required String testId,
    required List<({String front, String back})> cards,
  });
}
