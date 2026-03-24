import 'dart:math';

import 'package:quizzerg/feature/main/domain/entity/card_entity.dart';
import 'package:quizzerg/feature/question_stats/domain/util/question_key_normalizer.dart';
import 'package:quizzerg/feature/tinder_test/domain/mixup/i_question_mixup_service.dart';
import 'package:quizzerg/feature/tinder_test/domain/mixup/mixup_candidate_loader.dart';

class QuestionMixupService implements IQuestionMixupService {
  final MixupCandidateLoader _candidateLoader;

  const QuestionMixupService({
    required MixupCandidateLoader candidateLoader,
  }) : _candidateLoader = candidateLoader;

  @override
  Future<List<CardEntity>> getMixupCards({
    required int testId,
    required List<CardEntity> mainCards,
    required int mixupMin,
    required int mixupMax,
  }) async {
    final result = await _candidateLoader.loadCandidates(
      testId: testId,
      mainCards: mainCards,
    );

    if (result.cards.isEmpty) return [];

    final candidates = List<CardEntity>.of(result.cards);
    final hasNegativeStreak = result.statsMap.values.any((s) => s.streak < 0);

    final random = Random();
    final count = random.nextInt(mixupMax - mixupMin + 1) + mixupMin;

    if (hasNegativeStreak) {
      candidates.sort((a, b) {
        final keyA = QuestionKeyNormalizer.normalize(a.front, a.formattedBack);
        final keyB = QuestionKeyNormalizer.normalize(b.front, b.formattedBack);
        final statA = result.statsMap[keyA];
        final statB = result.statsMap[keyB];

        if (statA == null && statB == null) return 0;
        if (statA == null) return 1;
        if (statB == null) return -1;

        final streakCmp = statA.streak.compareTo(statB.streak);
        if (streakCmp != 0) return streakCmp;

        return statB.totalIncorrect.compareTo(statA.totalIncorrect);
      });
    } else {
      candidates.sort((a, b) {
        final keyA = QuestionKeyNormalizer.normalize(a.front, a.formattedBack);
        final keyB = QuestionKeyNormalizer.normalize(b.front, b.formattedBack);
        final statA = result.statsMap[keyA];
        final statB = result.statsMap[keyB];

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
