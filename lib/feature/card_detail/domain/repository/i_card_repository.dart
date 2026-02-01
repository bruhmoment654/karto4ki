import 'package:karto4ki/feature/main/domain/entity/card_entity.dart';

/// Интерфейс репозитория для работы с карточками.
///
/// Предоставляет CRUD операции для карточек.
// TODO(karto4ki): Добавить поля id и testId в CardEntity для полноценной работы методов.
abstract interface class ICardRepository {
  /// Получить все карточки.
  Future<List<CardEntity>> getCards();

  /// Получить карточку по ID.
  ///
  /// Возвращает `null`, если карточка не найдена.
  // TODO(karto4ki): Требует добавления поля id в CardEntity.
  Future<CardEntity?> getCardById(int id);

  /// Получить карточки по ID теста.
  // TODO(karto4ki): Требует добавления поля testId в CardEntity.
  Future<List<CardEntity>> getCardsByTestId(int testId);

  /// Создать новую карточку.
  Future<void> createCard(CardEntity card);

  /// Обновить существующую карточку.
  // TODO(karto4ki): Требует добавления поля id в CardEntity для идентификации.
  Future<void> updateCard(CardEntity card);

  /// Удалить карточку по ID.
  Future<void> deleteCard(int id);
}
