import 'package:karto4ki/feature/main/domain/entity/card_entity.dart';

/// Repository interface for main screen.
abstract interface class IMainRepository {
  /// Get card list.
  List<CardEntity> getCardList();

  /// Save card list.
  void updateCardList(List<CardEntity> cards);
}
