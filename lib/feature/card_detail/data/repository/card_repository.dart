import 'package:karto4ki/feature/card_detail/domain/repository/i_card_repository.dart';
import 'package:karto4ki/feature/main/domain/entity/card_entity.dart';
import 'package:karto4ki/persistence/models/card_dto.dart';

/// Repository implementation for working with cards.
///
/// Current implementation uses stubs.
// TODO(karto4ki): Integrate with Drift for real data storage.
class CardRepository implements ICardRepository {
  const CardRepository();

  @override
  Future<List<CardEntity>> getCards() async {
    // TODO(karto4ki): Implement fetching cards from Drift.
    return _getMockCards();
  }

  @override
  Future<CardEntity?> getCardById(int id) async {
    // TODO(karto4ki): Implement fetching card by ID from Drift.
    final cards = _getMockCards();
    if (id >= 0 && id < cards.length) {
      return cards[id];
    }
    return null;
  }

  @override
  Future<List<CardEntity>> getCardsByTestId(int testId) async {
    // TODO(karto4ki): Implement filtering by testId after Drift integration.
    return _getMockCards();
  }

  @override
  Future<void> createCard(CardEntity card) async {
    // TODO(karto4ki): Implement card creation in Drift.
    final dto = _entityToDto(card);
    // Stub: just convert to verify converter works
    _dtoToEntity(dto);
  }

  @override
  Future<void> updateCard(CardEntity card) async {
    // TODO(karto4ki): Implement card update in Drift.
  }

  @override
  Future<void> deleteCard(int id) async {
    // TODO(karto4ki): Implement card deletion from Drift.
  }

  /// Converts [CardDto] to [CardEntity].
  CardEntity _dtoToEntity(CardDto dto) {
    return CardEntity(
      front: dto.front,
      back: dto.back,
    );
  }

  /// Converts [CardEntity] to [CardDto].
  CardDto _entityToDto(CardEntity entity) {
    return CardDto(
      front: entity.front,
      back: entity.back,
    );
  }

  /// Returns mock data for testing.
  List<CardEntity> _getMockCards() {
    return const [
      CardEntity(front: 'Capital of France?', back: 'Paris'),
      CardEntity(front: 'Capital of Germany?', back: 'Berlin'),
      CardEntity(front: 'Capital of Italy?', back: 'Rome'),
    ];
  }
}
