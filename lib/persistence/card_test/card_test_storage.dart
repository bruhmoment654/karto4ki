import 'package:karto4ki/persistence/card_test/i_card_test_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Storage implementation for card testing data.
class CardTestStorage implements ICardTestStorage {
  final SharedPreferences _prefs;

  const CardTestStorage(this._prefs);

  @override
  List<String>? get cardList =>
      _prefs.getStringList(CardTestStorageKeys.cardList.keyName);

  @override
  void updateCardList(List<String> cardList) {
    _prefs.setStringList(CardTestStorageKeys.cardList.keyName, cardList);
  }
}

/// Storage keys.
enum CardTestStorageKeys {
  cardList('card_test_list');

  final String keyName;

  const CardTestStorageKeys(this.keyName);
}
