import 'package:quizzerg/core/feature/core/entity/request_operation.dart';
import 'package:quizzerg/core/feature/data/repository/base_repository.dart';
import 'package:quizzerg/core/sync/domain/entity/sync_status.dart';
import 'package:quizzerg/feature/main/domain/entity/card_entity.dart';
import 'package:quizzerg/feature/test_detail/data/converters/card_converter.dart';
import 'package:quizzerg/feature/test_detail/data/database/cards_database.dart';
import 'package:quizzerg/feature/test_detail/domain/repository/i_card_repository.dart';

/// Repository implementation for working with cards.
class CardRepository extends BaseRepository implements ICardRepository {
  final CardsDatabase _cardsDatabase;

  const CardRepository({
    required CardsDatabase cardsDatabase,
    required super.errorLogger,
  }) : _cardsDatabase = cardsDatabase;

  @override
  RequestOperation<List<CardEntity>> getCards() => makeCall(() async {
        final dtos = await _cardsDatabase.getAllCards();
        return dtos.map(CardConverter.fromDto).toList();
      });

  @override
  RequestOperation<CardEntity?> getCardById(String id) => makeCall(() async {
        final dto = await _cardsDatabase.getCardById(id);
        if (dto == null) return null;
        return CardConverter.fromDto(dto);
      });

  @override
  RequestOperation<List<CardEntity>> getCardsByTestId(String testId) =>
      makeCall(() async {
        final dtos = await _cardsDatabase.getCardsByTestId(testId);
        return dtos.map(CardConverter.fromDto).toList();
      });

  @override
  RequestOperation<void> createCard(CardEntity card) => makeCall(() async {
        await _cardsDatabase.insertCard(CardConverter.toCompanion(card));
      });

  @override
  RequestOperation<void> updateCard(CardEntity card) => makeCall(() async {
        final dto = await _cardsDatabase.getCardById(card.id);
        if (dto != null) {
          await _cardsDatabase.updateCard(
            dto.copyWith(
              question: card.front,
              answer: card.formattedBack,
              syncStatus: SyncStatus.pending.dbValue,
              updatedAt: DateTime.now(),
            ),
          );
        }
      });

  @override
  RequestOperation<void> deleteCard(String id) => makeCall(() async {
        await _cardsDatabase.softDeleteCardById(id);
      });
}
