import 'dart:math';

import 'package:quizzerg/core/feature/core/entity/result.dart';
import 'package:quizzerg/feature/card_detail/domain/repository/i_card_repository.dart';
import 'package:quizzerg/feature/groups_list/data/database/groups_database.dart';
import 'package:quizzerg/feature/main/domain/entity/card_entity.dart';
import 'package:quizzerg/feature/question_stats/domain/entity/question_stats_entity.dart';
import 'package:quizzerg/feature/question_stats/domain/repository/i_question_stats_repository.dart';
import 'package:quizzerg/feature/question_stats/domain/util/question_key_normalizer.dart';

class QuestionMixupService {
  final ICardRepository _cardRepository;
  final GroupsDatabase _groupsDatabase;
  final IQuestionStatsRepository _questionStatsRepository;

  const QuestionMixupService({
    required ICardRepository cardRepository,
    required GroupsDatabase groupsDatabase,
    required IQuestionStatsRepository questionStatsRepository,
  })  : _cardRepository = cardRepository,
        _groupsDatabase = groupsDatabase,
        _questionStatsRepository = questionStatsRepository;

  Future<List<CardEntity>> getMixupCards({
    required int testId,
    required List<CardEntity> mainCards,
  }) async {
    final groupIds = await _groupsDatabase.getGroupIdsByTestId(testId);
    if (groupIds.isEmpty) return [];

    final otherTestIds = <int>{};
    for (final groupId in groupIds) {
      final testIds = await _groupsDatabase.getTestIdsByGroupId(groupId);
      otherTestIds.addAll(testIds);
    }
    otherTestIds.remove(testId);
    if (otherTestIds.isEmpty) return [];

    final mainKeys = mainCards
        .map((c) => QuestionKeyNormalizer.normalize(c.front, c.back))
        .toSet();

    final candidates = <CardEntity>[];
    for (final id in otherTestIds) {
      final result = await _cardRepository.getCardsByTestId(id);
      if (result case ResultOk(:final data)) {
        for (final card in data) {
          final key = QuestionKeyNormalizer.normalize(card.front, card.back);
          if (!mainKeys.contains(key)) {
            candidates.add(card);
          }
        }
      }
    }

    if (candidates.isEmpty) return [];

    final candidateKeys = candidates
        .map((c) => QuestionKeyNormalizer.normalize(c.front, c.back))
        .toList();

    final statsResult =
        await _questionStatsRepository.getStatsByKeys(candidateKeys);
    final statsMap = <String, QuestionStatsEntity>{};
    if (statsResult case ResultOk(:final data)) {
      for (final stat in data) {
        statsMap[stat.questionKey] = stat;
      }
    }

    final hasNegativeStreak = statsMap.values.any((s) => s.streak < 0);

    final random = Random();
    final int count;

    if (hasNegativeStreak) {
      count = random.nextInt(4) + 2;

      candidates.sort((a, b) {
        final keyA = QuestionKeyNormalizer.normalize(a.front, a.back);
        final keyB = QuestionKeyNormalizer.normalize(b.front, b.back);
        final statA = statsMap[keyA];
        final statB = statsMap[keyB];

        if (statA == null && statB == null) return 0;
        if (statA == null) return 1;
        if (statB == null) return -1;

        final streakCmp = statA.streak.compareTo(statB.streak);
        if (streakCmp != 0) return streakCmp;

        return statB.totalIncorrect.compareTo(statA.totalIncorrect);
      });
    } else {
      count = random.nextInt(2) + 1;

      candidates.sort((a, b) {
        final keyA = QuestionKeyNormalizer.normalize(a.front, a.back);
        final keyB = QuestionKeyNormalizer.normalize(b.front, b.back);
        final statA = statsMap[keyA];
        final statB = statsMap[keyB];

        if (statA == null && statB == null) return 0;
        if (statA == null) return -1;
        if (statB == null) return 1;

        final shownAtA = statA.lastShownAt;
        final shownAtB = statB.lastShownAt;

        if (shownAtA == null && shownAtB == null) {
          return statA.totalShown.compareTo(statB.totalShown);
        }
        if (shownAtA == null) return -1;
        if (shownAtB == null) return 1;

        final shownAtCmp = shownAtA.compareTo(shownAtB);
        if (shownAtCmp != 0) return shownAtCmp;

        return statA.totalShown.compareTo(statB.totalShown);
      });
    }

    return candidates
        .take(min(count, candidates.length))
        .map((c) => c.copyWith(isMixedIn: true))
        .toList();
  }
}
