import 'dart:math';

import 'package:quizzerg/feature/main/domain/entity/card_entity.dart';
import 'package:quizzerg/feature/question_stats/domain/util/question_key_normalizer.dart';
import 'package:quizzerg/feature/tinder_test/domain/mixup/i_question_mixup_service.dart';
import 'package:quizzerg/feature/tinder_test/domain/mixup/mixup_candidate_loader.dart';

class ScoringMixupService implements IQuestionMixupService {
  final MixupCandidateLoader _candidateLoader;
  final double _wStreakNegative;
  final double _wStreakPositive;

  static const _wDecay = 0.30;
  static const _wNew = 0.20;
  static const _wFreq = 0.15;

  const ScoringMixupService({
    required MixupCandidateLoader candidateLoader,
    double streakNegativeBonus = 0.35,
    double streakPositivePenalty = 0.35,
  })  : _candidateLoader = candidateLoader,
        _wStreakNegative = streakNegativeBonus,
        _wStreakPositive = streakPositivePenalty;

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

      final double streakContribution;
      if (stat != null && stat.streak < 0) {
        streakContribution =
            _wStreakNegative * (-stat.streak / 5).clamp(0.0, 1.0);
      } else if (stat != null && stat.streak > 0) {
        streakContribution =
            -_wStreakPositive * (stat.streak / 5).clamp(0.0, 1.0);
      } else {
        streakContribution = 0;
      }

      final double decayFactor;
      if (stat?.lastShownAt case final lastShown?) {
        decayFactor =
            (now.difference(lastShown).inDays / 30).clamp(0, 1).toDouble();
      } else {
        decayFactor = 1.0;
      }

      final newFactor = stat != null
          ? 1 - (stat.totalShown / 5).clamp(0, 1)
          : 1.0;

      final frequencyFactor = stat != null && stat.totalShown > 0
          ? stat.totalIncorrect / stat.totalShown
          : 0.5;

      final noise = random.nextDouble() * 0.05;

      final score = streakContribution +
          _wDecay * decayFactor +
          _wNew * newFactor +
          _wFreq * frequencyFactor +
          noise;

      return (card: card, score: score);
    }).toList()
      ..sort((a, b) => b.score.compareTo(a.score));

    return scored
        .take(min(count, scored.length))
        .map((e) => e.card.copyWith(isMixedIn: true))
        .toList();
  }
}
