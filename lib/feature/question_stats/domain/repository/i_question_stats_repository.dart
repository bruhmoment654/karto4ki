import 'package:quizzerg/core/feature/core/entity/request_operation.dart';
import 'package:quizzerg/feature/main/domain/entity/card_entity.dart';
import 'package:quizzerg/feature/question_stats/domain/entity/question_stats_entity.dart';
import 'package:quizzerg/feature/tinder_test/domain/entity/card_result.dart';

abstract interface class IQuestionStatsRepository {
  RequestOperation<void> saveSessionResults({
    required List<CardResult> results,
    required List<CardEntity> cards,
  });

  RequestOperation<List<QuestionStatsEntity>> getAllStats();

  RequestOperation<List<QuestionStatsEntity>> getLeastRemembered(int limit);

  RequestOperation<List<QuestionStatsEntity>> getStatsByKeys(List<String> keys);
}
