/// Storage interface for card testing data.
///
/// Will be refactored to Drift.
abstract interface class ICardTestStorage {
  List<String>? get cardList;

  void updateCardList(List<String> cardList);
}
