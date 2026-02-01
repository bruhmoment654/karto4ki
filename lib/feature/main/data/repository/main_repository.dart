import 'dart:convert';

import 'package:karto4ki/feature/main/domain/entity/card_entity.dart';
import 'package:karto4ki/feature/main/domain/repository/i_main_repository.dart';
import 'package:karto4ki/persistence/card_test/i_card_test_storage.dart';
import 'package:karto4ki/persistence/models/card_dto.dart';

class MainRepository implements IMainRepository {
  final ICardTestStorage _cardTestStorage;

  const MainRepository(this._cardTestStorage);

  @override
  List<CardEntity> getCardList() {
    final cards = _cardTestStorage.cardList;
    if (cards == null) return [];

    return cards.map((jsonString) {
      final dto =
          CardDto.fromJson(jsonDecode(jsonString) as Map<String, dynamic>);
      return CardEntity(front: dto.front, back: dto.back);
    }).toList();
  }

  @override
  void updateCardList(List<CardEntity> cards) {
    final jsonList = cards.map((card) {
      final dto = CardDto(front: card.front, back: card.back);
      return jsonEncode(dto.toJson());
    }).toList();
    _cardTestStorage.updateCardList(jsonList);
  }
}
