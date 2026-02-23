import 'package:drift/drift.dart';
import 'package:quizzerg/core/feature/core/entity/request_operation.dart';
import 'package:quizzerg/core/feature/data/repository/base_repository.dart';
import 'package:quizzerg/feature/card_detail/data/converters/card_converter.dart';
import 'package:quizzerg/feature/card_detail/data/database/cards_database.dart';
import 'package:quizzerg/feature/main/domain/entity/card_entity.dart';
import 'package:quizzerg/feature/test_detail/domain/repository/i_test_detail_repository.dart';
import 'package:quizzerg/feature/tests_list/data/converters/test_converter.dart';
import 'package:quizzerg/feature/tests_list/data/database/tests_database.dart';
import 'package:quizzerg/feature/tests_list/domain/entity/test_entity.dart';

/// Repository implementation for test detail screen.
class TestDetailRepository extends BaseRepository
    implements ITestDetailRepository {
  final TestsDatabase _testsDatabase;
  final CardsDatabase _cardsDatabase;

  const TestDetailRepository({
    required TestsDatabase testsDatabase,
    required CardsDatabase cardsDatabase,
    required super.errorLogger,
  })  : _testsDatabase = testsDatabase,
        _cardsDatabase = cardsDatabase;

  @override
  RequestOperation<TestEntity?> getTestById(int testId) =>
      makeCall(() async {
        final dto = await _testsDatabase.getTestById(testId);
        if (dto == null) return null;
        return TestConverter.fromDto(dto);
      });

  @override
  RequestOperation<List<CardEntity>> getCardsByTestId(int testId) =>
      makeCall(() async {
        final dtos = await _cardsDatabase.getCardsByTestId(testId);
        return dtos.map(CardConverter.fromDto).toList();
      });

  @override
  RequestOperation<void> addCard({
    required int testId,
    required String front,
    required String back,
  }) =>
      makeCall(() async {
        await _cardsDatabase.insertCard(
          CardConverter.toNewCompanion(
            testId: testId,
            front: front,
            back: back,
          ),
        );
      });

  @override
  RequestOperation<void> updateCard(CardEntity card) => makeCall(() async {
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
      });

  @override
  RequestOperation<void> deleteCard(int cardId) => makeCall(() async {
        await _cardsDatabase.deleteCardById(cardId);
      });

  @override
  RequestOperation<void> updateTest(TestEntity test) => makeCall(() async {
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
      });

  @override
  RequestOperation<void> addCards({
    required int testId,
    required List<({String front, String back})> cards,
  }) =>
      makeCall(() async {
        final companions = cards
            .map(
              (card) => CardConverter.toNewCompanion(
                testId: testId,
                front: card.front,
                back: card.back,
              ),
            )
            .toList();

        await _cardsDatabase.insertCards(companions);
      });
}
