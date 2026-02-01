import 'package:karto4ki/feature/card_detail/domain/repository/i_card_repository.dart';
import 'package:karto4ki/feature/main/domain/entity/card_entity.dart';
import 'package:karto4ki/persistence/models/card_dto.dart';

/// Реализация репозитория для работы с карточками.
///
/// Текущая реализация использует заглушки.
// TODO(karto4ki): Интегрировать с Drift для реального хранения данных.
class CardRepository implements ICardRepository {
  const CardRepository();

  @override
  Future<List<CardEntity>> getCards() async {
    // TODO(karto4ki): Реализовать получение карточек из Drift.
    return _getMockCards();
  }

  @override
  Future<CardEntity?> getCardById(int id) async {
    // TODO(karto4ki): Реализовать получение карточки по ID из Drift.
    final cards = _getMockCards();
    if (id >= 0 && id < cards.length) {
      return cards[id];
    }
    return null;
  }

  @override
  Future<List<CardEntity>> getCardsByTestId(int testId) async {
    // TODO(karto4ki): Реализовать фильтрацию по testId после интеграции с Drift.
    return _getMockCards();
  }

  @override
  Future<void> createCard(CardEntity card) async {
    // TODO(karto4ki): Реализовать создание карточки в Drift.
    final dto = _entityToDto(card);
    // Заглушка: просто конвертируем для проверки работы конвертера
    _dtoToEntity(dto);
  }

  @override
  Future<void> updateCard(CardEntity card) async {
    // TODO(karto4ki): Реализовать обновление карточки в Drift.
  }

  @override
  Future<void> deleteCard(int id) async {
    // TODO(karto4ki): Реализовать удаление карточки из Drift.
  }

  /// Конвертирует [CardDto] в [CardEntity].
  CardEntity _dtoToEntity(CardDto dto) {
    return CardEntity(
      front: dto.front,
      back: dto.back,
    );
  }

  /// Конвертирует [CardEntity] в [CardDto].
  CardDto _entityToDto(CardEntity entity) {
    return CardDto(
      front: entity.front,
      back: entity.back,
    );
  }

  /// Возвращает моковые данные для тестирования.
  List<CardEntity> _getMockCards() {
    return const [
      CardEntity(front: 'Столица Франции?', back: 'Париж'),
      CardEntity(front: 'Столица Германии?', back: 'Берлин'),
      CardEntity(front: 'Столица Италии?', back: 'Рим'),
    ];
  }
}
