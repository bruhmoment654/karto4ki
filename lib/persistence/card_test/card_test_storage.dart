import 'package:karto4ki/persistence/card_test/i_card_test_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Реализация хранилища для данных тестирования карточек.
class CardTestStorage implements ICardTestStorage {
  final SharedPreferences _prefs;

  const CardTestStorage(this._prefs);

  // TODO: Добавить реализации методов
}

/// Ключи для хранения данных.
enum CardTestStorageKeys {
  // TODO: Добавить ключи
  placeholder('card_test_placeholder');

  final String keyName;

  const CardTestStorageKeys(this.keyName);
}
