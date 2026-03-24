import 'package:quizzerg/feature/main/domain/entity/card_entity.dart';

abstract interface class IQuestionMixupService {
  Future<List<CardEntity>> getMixupCards({
    required int testId,
    required List<CardEntity> mainCards,
    required int mixupMin,
    required int mixupMax,
  });
}
