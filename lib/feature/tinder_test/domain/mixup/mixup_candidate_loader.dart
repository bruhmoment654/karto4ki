import 'package:quizzerg/core/feature/core/entity/result.dart';
import 'package:quizzerg/feature/groups_list/data/database/groups_database.dart';
import 'package:quizzerg/feature/main/domain/entity/card_entity.dart';
import 'package:quizzerg/feature/question_stats/data/database/question_stats_database.dart';
import 'package:quizzerg/feature/question_stats/domain/entity/question_stats_entity.dart';
import 'package:quizzerg/feature/question_stats/domain/repository/i_question_stats_repository.dart';
import 'package:quizzerg/feature/question_stats/domain/util/question_key_normalizer.dart';
import 'package:quizzerg/feature/test_detail/domain/repository/i_card_repository.dart';
import 'package:quizzerg/feature/tests_list/data/database/tests_database.dart';

class MixupCandidates {
  final List<CardEntity> cards;
  final Map<String, QuestionStatsEntity> statsMap;
  final Set<DateTime> activeDates;

  const MixupCandidates({
    required this.cards,
    required this.statsMap,
    required this.activeDates,
  });

  const MixupCandidates.empty()
      : cards = const [],
        statsMap = const {},
        activeDates = const {};
}

class MixupCandidateLoader {
  final ICardRepository _cardRepository;
  final GroupsDatabase _groupsDatabase;
  final TestsDatabase _testsDatabase;
  final IQuestionStatsRepository _questionStatsRepository;
  final QuestionStatsDatabase _questionStatsDatabase;

  const MixupCandidateLoader({
    required ICardRepository cardRepository,
    required GroupsDatabase groupsDatabase,
    required TestsDatabase testsDatabase,
    required IQuestionStatsRepository questionStatsRepository,
    required QuestionStatsDatabase questionStatsDatabase,
  })  : _cardRepository = cardRepository,
        _groupsDatabase = groupsDatabase,
        _testsDatabase = testsDatabase,
        _questionStatsRepository = questionStatsRepository,
        _questionStatsDatabase = questionStatsDatabase;

  Future<MixupCandidates> loadCandidates({
    required String testId,
    required List<CardEntity> mainCards,
  }) async {
    final activeDates = (await _questionStatsDatabase.getActiveDates()).toSet();

    final groupIds = await _groupsDatabase.getGroupIdsByTestId(testId);
    if (groupIds.isEmpty) {
      return const MixupCandidates.empty();
    }

    final otherTestIds = <String>{};
    for (final groupId in groupIds) {
      final testIds = await _groupsDatabase.getTestIdsByGroupId(groupId);
      otherTestIds.addAll(testIds);
    }
    otherTestIds.remove(testId);

    // Подмешиваем только из живых (не soft-deleted) тестов.
    final aliveTestIds =
        (await _testsDatabase.getAliveTests()).map((t) => t.id).toSet();
    otherTestIds.removeWhere((id) => !aliveTestIds.contains(id));

    if (otherTestIds.isEmpty) {
      return const MixupCandidates.empty();
    }

    final mainKeys = mainCards
        .map((c) => QuestionKeyNormalizer.normalize(c.front, c.formattedBack))
        .toSet();

    final candidates = <CardEntity>[];
    for (final id in otherTestIds) {
      final result = await _cardRepository.getCardsByTestId(id);
      if (result case ResultOk(:final data)) {
        for (final card in data) {
          final key =
              QuestionKeyNormalizer.normalize(card.front, card.formattedBack);
          if (!mainKeys.contains(key)) {
            candidates.add(card);
          }
        }
      }
    }

    if (candidates.isEmpty) {
      return MixupCandidates(
        cards: const [],
        statsMap: const {},
        activeDates: activeDates,
      );
    }

    final candidateKeys = candidates
        .map((c) => QuestionKeyNormalizer.normalize(c.front, c.formattedBack))
        .toList();

    final statsResult =
        await _questionStatsRepository.getStatsByKeys(candidateKeys);
    final statsMap = <String, QuestionStatsEntity>{};
    if (statsResult case ResultOk(:final data)) {
      for (final stat in data) {
        statsMap[stat.questionKey] = stat;
      }
    }

    return MixupCandidates(
      cards: candidates,
      statsMap: statsMap,
      activeDates: activeDates,
    );
  }
}
