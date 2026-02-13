import 'package:quizzerg/feature/card_detail/data/converters/card_converter.dart';
import 'package:quizzerg/feature/card_detail/data/database/cards_database.dart';
import 'package:quizzerg/feature/card_detail/domain/repository/i_card_repository.dart';
import 'package:quizzerg/feature/main/domain/entity/card_entity.dart';

/// Repository implementation for working with cards.
class CardRepository implements ICardRepository {
  final CardsDatabase _cardsDatabase;

  const CardRepository({required CardsDatabase cardsDatabase})
      : _cardsDatabase = cardsDatabase;

  @override
  Future<List<CardEntity>> getCards() async {
    final dtos = await _cardsDatabase.getAllCards();
    return dtos.map(CardConverter.fromDto).toList();
  }

  @override
  Future<CardEntity?> getCardById(int id) async {
    final dto = await _cardsDatabase.getCardById(id);
    if (dto == null) return null;
    return CardConverter.fromDto(dto);
  }

  @override
  Future<List<CardEntity>> getCardsByTestId(int testId) async {
    final dtos = await _cardsDatabase.getCardsByTestId(testId);
    return dtos.map(CardConverter.fromDto).toList();
  }

  @override
  Future<void> createCard(CardEntity card) async {
    await _cardsDatabase.insertCard(CardConverter.toCompanion(card));
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
  Future<void> deleteCard(int id) async {
    await _cardsDatabase.deleteCardById(id);
  }
}
