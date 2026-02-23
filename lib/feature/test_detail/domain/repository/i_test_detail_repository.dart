import 'package:quizzerg/core/feature/core/entity/request_operation.dart';
import 'package:quizzerg/feature/main/domain/entity/card_entity.dart';
import 'package:quizzerg/feature/tests_list/domain/entity/test_entity.dart';

/// Repository interface for test detail screen.
abstract interface class ITestDetailRepository {
  /// Get test by id.
  RequestOperation<TestEntity?> getTestById(int testId);

  /// Get cards for test.
  RequestOperation<List<CardEntity>> getCardsByTestId(int testId);

  /// Add new card to test.
  RequestOperation<void> addCard({
    required int testId,
    required String front,
    required String back,
  });

  /// Update existing card.
  RequestOperation<void> updateCard(CardEntity card);

  /// Delete card by id.
  RequestOperation<void> deleteCard(int cardId);

  /// Update test information.
  RequestOperation<void> updateTest(TestEntity test);

  /// Add multiple cards to test (batch insert).
  RequestOperation<void> addCards({
    required int testId,
    required List<({String front, String back})> cards,
  });
}
