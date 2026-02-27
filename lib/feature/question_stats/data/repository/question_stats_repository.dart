import 'package:quizzerg/core/feature/core/entity/request_operation.dart';
import 'package:quizzerg/core/feature/data/repository/base_repository.dart';
import 'package:quizzerg/feature/main/domain/entity/card_entity.dart';
import 'package:quizzerg/feature/question_stats/data/converters/question_stats_converter.dart';
import 'package:quizzerg/feature/question_stats/data/database/question_stats_database.dart';
import 'package:quizzerg/feature/question_stats/domain/entity/question_stats_entity.dart';
import 'package:quizzerg/feature/question_stats/domain/repository/i_question_stats_repository.dart';
import 'package:quizzerg/feature/question_stats/domain/util/question_key_normalizer.dart';
import 'package:quizzerg/feature/tinder_test/domain/entity/card_result.dart';

class QuestionStatsRepository extends BaseRepository
    implements IQuestionStatsRepository {
  final QuestionStatsDatabase _questionStatsDatabase;

  const QuestionStatsRepository({
    required QuestionStatsDatabase questionStatsDatabase,
    required super.errorLogger,
  }) : _questionStatsDatabase = questionStatsDatabase;

  @override
  RequestOperation<void> saveSessionResults({
    required List<CardResult> results,
    required List<CardEntity> cards,
  }) =>
      makeCall(() async {
        final cardMap = {for (final card in cards) card.id: card};

        final upsertData = <({
          String questionKey,
          String frontText,
          String backText,
          bool isCorrect,
        })>[];

        for (final result in results) {
          final card = cardMap[result.cardId];
          if (card == null) continue;

          upsertData.add((
            questionKey:
                QuestionKeyNormalizer.normalize(card.front, card.back),
            frontText: card.front,
            backText: card.back,
            isCorrect: result.isCorrect,
          ));
        }

        await _questionStatsDatabase.upsertStats(upsertData);
      });

  @override
  RequestOperation<List<QuestionStatsEntity>> getLeastRemembered(int limit) =>
      makeCall(() async {
        final dtos = await _questionStatsDatabase.getLeastRemembered(limit);
        return dtos.map(QuestionStatsConverter.fromDto).toList();
      });

  @override
  RequestOperation<List<QuestionStatsEntity>> getStatsByKeys(
    List<String> keys,
  ) =>
      makeCall(() async {
        final dtos = await _questionStatsDatabase.getStatsByKeys(keys);
        return dtos.map(QuestionStatsConverter.fromDto).toList();
      });
}
