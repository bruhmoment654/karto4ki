import 'dart:convert';

import 'package:quizzerg/core/utils/answer_parser.dart';
import 'package:quizzerg/feature/main/domain/entity/card_entity.dart';
import 'package:quizzerg/feature/main/domain/repository/i_main_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainRepository implements IMainRepository {
  final SharedPreferences _prefs;

  static const _cardListKey = 'card_test_list';

  const MainRepository(this._prefs);

  @override
  List<CardEntity> getCardList() {
    final cards = _prefs.getStringList(_cardListKey);
    if (cards == null) return [];

    final now = DateTime.now();
    return cards.map((jsonString) {
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      return CardEntity(
        id: '',
        testId: '',
        front: json['front'] as String,
        answers: AnswerParser.parse(json['back'] as String),
        createdAt: now,
        updatedAt: now,
      );
    }).toList();
  }

  @override
  void updateCardList(List<CardEntity> cards) {
    final jsonList = cards.map((card) {
      return jsonEncode({'front': card.front, 'back': card.formattedBack});
    }).toList();
    _prefs.setStringList(_cardListKey, jsonList);
  }
}
