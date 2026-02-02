import 'package:karto4ki/feature/main/domain/entity/card_entity.dart';
import 'package:karto4ki/feature/tests_list/domain/entity/test_entity.dart';

/// Repository interface for test detail screen.
abstract interface class ITestDetailRepository {
  /// Get test by id.
  Future<TestEntity?> getTestById(int testId);

  /// Get cards for test.
  Future<List<CardEntity>> getCardsByTestId(int testId);

  /// Add new card to test.
  Future<void> addCard({
    required int testId,
    required String front,
    required String back,
  });

  /// Update existing card.
  Future<void> updateCard(CardEntity card);

  /// Delete card by id.
  Future<void> deleteCard(int cardId);

  /// Update test information.
  Future<void> updateTest(TestEntity test);
}
