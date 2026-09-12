import 'package:quizzerg/core/feature/core/entity/request_operation.dart';
import 'package:quizzerg/feature/main/domain/entity/card_entity.dart';
import 'package:quizzerg/feature/question_stats/domain/entity/question_stats_entity.dart';
import 'package:quizzerg/feature/tinder_test/domain/entity/card_result.dart';

abstract interface class IQuestionStatsRepository {
  /// Эмитит при любом изменении статистики — в том числе из pull-синхронизации.
  Stream<void> get statsChanges;

  RequestOperation<void> saveSessionResults({
    required List<CardResult> results,
    required List<CardEntity> cards,
  });

  RequestOperation<List<QuestionStatsEntity>> getAllStats();

  RequestOperation<List<QuestionStatsEntity>> getLeastRemembered(int limit);

  RequestOperation<List<QuestionStatsEntity>> getStatsByKeys(List<String> keys);

  /// Отсортированные уникальные даты (00:00) с хотя бы одним ответом.
  RequestOperation<List<DateTime>> getActiveDates();
}
