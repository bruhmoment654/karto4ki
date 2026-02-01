import 'package:karto4ki/feature/main/domain/entity/card_entity.dart';

/// Интерфейс репозитория для главного экрана.
abstract interface class IMainRepository {
  /// Получить список карточек.
  List<CardEntity> getCardList();

  /// Сохранить список карточек.
  void updateCardList(List<CardEntity> cards);
}
