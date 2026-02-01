import 'package:drift/drift.dart';
import 'package:karto4ki/feature/card_detail/data/converters/card_converter.dart';
import 'package:karto4ki/feature/card_detail/data/database/cards_database.dart';
import 'package:karto4ki/feature/main/domain/entity/card_entity.dart';
import 'package:karto4ki/feature/test_detail/domain/repository/i_test_detail_repository.dart';
import 'package:karto4ki/feature/tests/data/converters/test_converter.dart';
import 'package:karto4ki/feature/tests/data/database/tests_database.dart';
import 'package:karto4ki/feature/tests/domain/entity/test_entity.dart';

/// Repository implementation for test detail screen.
class TestDetailRepository implements ITestDetailRepository {
  final TestsDatabase _testsDatabase;
  final CardsDatabase _cardsDatabase;

  const TestDetailRepository({
    required TestsDatabase testsDatabase,
    required CardsDatabase cardsDatabase,
  })  : _testsDatabase = testsDatabase,
        _cardsDatabase = cardsDatabase;

  @override
  Future<TestEntity?> getTestById(int testId) async {
    final dto = await _testsDatabase.getTestById(testId);
    if (dto == null) return null;
    return TestConverter.fromDto(dto);
  }

  @override
  Future<List<CardEntity>> getCardsByTestId(int testId) async {
    final dtos = await _cardsDatabase.getCardsByTestId(testId);
    return dtos.map(CardConverter.fromDto).toList();
  }

  @override
  Future<void> addCard({
    required int testId,
    required String front,
    required String back,
  }) async {
    await _cardsDatabase.insertCard(
      CardConverter.toNewCompanion(
        testId: testId,
        front: front,
        back: back,
      ),
    );
  }

  @override
  Future<void> updateCard(CardEntity card) async {
    final dto = await _cardsDatabase.getCardById(int.parse(card.id));
    if (dto != null) {
      await _cardsDatabase.updateCard(
        dto.copyWith(
          question: card.front,
          answer: card.back,
          updatedAt: DateTime.now(),
        ),
      );
    }
  }

  @override
  Future<void> deleteCard(int cardId) async {
    await _cardsDatabase.deleteCardById(cardId);
  }

  @override
  Future<void> updateTest(TestEntity test) async {
    final dto = await _testsDatabase.getTestById(int.parse(test.id));
    if (dto != null) {
      await _testsDatabase.updateTest(
        dto.copyWith(
          title: test.title,
          description: Value(test.description),
          updatedAt: DateTime.now(),
        ),
      );
    }
  }
}
