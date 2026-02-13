import 'dart:convert';

import 'package:quizzerg/feature/main/domain/entity/card_entity.dart';
import 'package:quizzerg/feature/main/domain/repository/i_main_repository.dart';
import 'package:quizzerg/persistence/card_test/i_card_test_storage.dart';

class MainRepository implements IMainRepository {
  final ICardTestStorage _cardTestStorage;

  const MainRepository(this._cardTestStorage);

  @override
  List<CardEntity> getCardList() {
    final cards = _cardTestStorage.cardList;
    if (cards == null) return [];

    final now = DateTime.now();
    return cards.map((jsonString) {
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      return CardEntity(
        id: '',
        testId: '',
        front: json['front'] as String,
        back: json['back'] as String,
        createdAt: now,
        updatedAt: now,
      );
    }).toList();
  }

  @override
  void updateCardList(List<CardEntity> cards) {
    final jsonList = cards.map((card) {
      return jsonEncode({'front': card.front, 'back': card.back});
    }).toList();
    _cardTestStorage.updateCardList(jsonList);
  }
}
