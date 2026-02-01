/// Интерфейс хранилища для данных тестирования карточек.
///
/// Будет переделан на Drift.
abstract interface class ICardTestStorage {
  List<String>? get cardList;

  void updateCardList(List<String> cardList);
}
