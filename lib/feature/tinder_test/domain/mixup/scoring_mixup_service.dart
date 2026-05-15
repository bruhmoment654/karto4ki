import 'dart:math';

import 'package:quizzerg/feature/main/domain/entity/card_entity.dart';
import 'package:quizzerg/feature/question_stats/domain/util/question_key_normalizer.dart';
import 'package:quizzerg/feature/tinder_test/domain/mixup/i_question_mixup_service.dart';
import 'package:quizzerg/feature/tinder_test/domain/mixup/mixup_candidate_loader.dart';
import 'package:quizzerg/feature/tinder_test/domain/mixup/scoring_calculator.dart';

class ScoringMixupService implements IQuestionMixupService {
  final MixupCandidateLoader _candidateLoader;
  final ScoringWeights _weights;

  ScoringMixupService({
    required MixupCandidateLoader candidateLoader,
    double streakNegativeBonus = 0.35,
    double streakPositivePenalty = 0.35,
  })  : _candidateLoader = candidateLoader,
        _weights = ScoringWeights(
          streakNegativeBonus: streakNegativeBonus,
          streakPositivePenalty: streakPositivePenalty,
        );

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

    final random = Random();
    final count = random.nextInt(mixupMax - mixupMin + 1) + mixupMin;
    final now = DateTime.now();

    final scored = result.cards.map((card) {
      final key =
          QuestionKeyNormalizer.normalize(card.front, card.formattedBack);
      final stat = result.statsMap[key];
      final components = ScoringCalculator.components(
        stat: stat,
        now: now,
        weights: _weights,
        activeDates: result.activeDates,
      );
      final noise = random.nextDouble() * 0.05;
      final score = components.weightedSum(_weights) + noise;
      return (card: card, score: score);
    }).toList()
      ..sort((a, b) => b.score.compareTo(a.score));

    return scored
        .take(min(count, scored.length))
        .map((entry) => entry.card.copyWith(isMixedIn: true))
        .toList();
  }
}
