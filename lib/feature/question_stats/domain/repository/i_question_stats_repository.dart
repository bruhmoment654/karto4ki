import 'package:quizzerg/feature/main/domain/entity/card_entity.dart';
import 'package:quizzerg/feature/question_stats/domain/entity/question_stats_entity.dart';
import 'package:quizzerg/feature/tinder_test/domain/entity/card_result.dart';

abstract interface class IQuestionStatsRepository {
  Future<void> saveSessionResults({
    required List<CardResult> results,
    required List<CardEntity> cards,
  });

  Future<List<QuestionStatsEntity>> getLeastRemembered(int limit);
}
