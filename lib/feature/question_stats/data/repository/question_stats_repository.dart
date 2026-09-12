import 'package:quizzerg/core/feature/core/entity/request_operation.dart';
import 'package:quizzerg/core/feature/data/repository/base_repository.dart';
import 'package:quizzerg/feature/main/domain/entity/card_entity.dart';
import 'package:quizzerg/feature/question_stats/data/converters/question_stats_converter.dart';
import 'package:quizzerg/feature/question_stats/data/database/question_stats_database.dart';
import 'package:quizzerg/feature/question_stats/domain/entity/question_stats_entity.dart';
import 'package:quizzerg/feature/question_stats/domain/repository/i_question_stats_repository.dart';
import 'package:quizzerg/feature/question_stats/domain/util/question_key_normalizer.dart';
import 'package:quizzerg/feature/sync/data/database/sync_database.dart';
import 'package:quizzerg/feature/tinder_test/domain/entity/card_result.dart';
import 'package:quizzerg/persistence/database/app_database.dart';

class QuestionStatsRepository extends BaseRepository
    implements IQuestionStatsRepository {
  final QuestionStatsDatabase _questionStatsDatabase;
  final SyncDatabase _syncDatabase;

  const QuestionStatsRepository({
    required QuestionStatsDatabase questionStatsDatabase,
    required SyncDatabase syncDatabase,
    required super.errorLogger,
  })  : _questionStatsDatabase = questionStatsDatabase,
        _syncDatabase = syncDatabase;

  @override
  Stream<void> get statsChanges => _questionStatsDatabase.watchStatsChanges();

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
                QuestionKeyNormalizer.normalize(card.front, card.answers),
            frontText: card.front,
            backText: card.formattedBack,
            isCorrect: result.isCorrect,
          ));
        }

        await _questionStatsDatabase.upsertStats(upsertData);
        await _enqueueAnswers(results, cardMap.keys.toSet());
      });

  /// Кладёт ответы в outbox для `POST /stats/answers/batch`.
  ///
  /// Ответы — события: из состояния строк статистики их не вывести,
  /// поэтому нужен собственный журнал.
  Future<void> _enqueueAnswers(
    List<CardResult> results,
    Set<String> knownCardIds,
  ) async {
    final events = results
        .where((result) => knownCardIds.contains(result.cardId))
        .map(
          (result) => AnswerEventsOutboxCompanion.insert(
            cardId: result.cardId,
            isCorrect: result.isCorrect,
            answeredAt: result.answeredAt.toUtc(),
          ),
        )
        .toList();

    await _syncDatabase.enqueueAnswers(events);
  }

  @override
  RequestOperation<List<QuestionStatsEntity>> getAllStats() =>
      makeCall(() async {
        final dtos = await _questionStatsDatabase.getAllStats();
        return dtos.map(QuestionStatsConverter.fromDto).toList();
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

  @override
  RequestOperation<List<DateTime>> getActiveDates() =>
      makeCall(_questionStatsDatabase.getActiveDates);
}
