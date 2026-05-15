import 'package:quizzerg/feature/question_stats/domain/entity/question_stats_entity.dart';

/// Веса score для подмешивания. Должны совпадать с настройками в SettingsDto.
class ScoringWeights {
  final double streakNegativeBonus;
  final double streakPositivePenalty;
  final double decayWeight;
  final double newWeight;
  final double freqWeight;

  const ScoringWeights({
    required this.streakNegativeBonus,
    required this.streakPositivePenalty,
    this.decayWeight = 0.30,
    this.newWeight = 0.20,
    this.freqWeight = 0.15,
  });
}

/// Компоненты score, ещё не свёрнутые в одно число.
class ScoreComponents {
  final double streakContribution;
  final double decayFactor;
  final double newFactor;
  final double frequencyFactor;
  final int activeDaysSinceLastShown;

  const ScoreComponents({
    required this.streakContribution,
    required this.decayFactor,
    required this.newFactor,
    required this.frequencyFactor,
    required this.activeDaysSinceLastShown,
  });

  double weightedSum(ScoringWeights weights) {
    return streakContribution +
        weights.decayWeight * decayFactor +
        weights.newWeight * newFactor +
        weights.freqWeight * frequencyFactor;
  }
}

abstract final class ScoringCalculator {
  /// Кэп активных дней без показа, после которого decay = 1.
  static const int kActiveDaysCap = 10;

  /// Считает 4 фактора score для вопроса. Без шума, без весов.
  /// Для свободного вопроса (нет [stat]) фактор «new» = 1, «freq» = 0.5, decay = 1.
  /// [activeDates] — нормализованные до дня (time = 00:00) даты, в которые
  /// пользователь хотя бы раз отвечал. Используется для multiplicative decay.
  static ScoreComponents components({
    required QuestionStatsEntity? stat,
    required DateTime now,
    required ScoringWeights weights,
    required Set<DateTime> activeDates,
  }) {
    final activeDaysSinceLastShown = _activeDaysSinceLastShown(
      lastShownAt: stat?.lastShownAt,
      activeDates: activeDates,
    );
    final decayFactor =
        (activeDaysSinceLastShown / kActiveDaysCap).clamp(0.0, 1.0);

    final double streakContribution;
    if (stat != null && stat.streak < 0) {
      streakContribution =
          weights.streakNegativeBonus * (-stat.streak / 5).clamp(0.0, 1.0);
    } else if (stat != null && stat.streak > 0) {
      final basePenalty =
          weights.streakPositivePenalty * (stat.streak / 5).clamp(0.0, 1.0);
      streakContribution = -basePenalty * (1 - decayFactor);
    } else {
      streakContribution = 0;
    }

    final newFactor =
        stat != null ? 1 - (stat.totalShown / 5).clamp(0, 1) : 1.0;

    final frequencyFactor = stat != null && stat.totalShown > 0
        ? stat.totalIncorrect / stat.totalShown
        : 0.5;

    return ScoreComponents(
      streakContribution: streakContribution,
      decayFactor: decayFactor,
      newFactor: newFactor.toDouble(),
      frequencyFactor: frequencyFactor,
      activeDaysSinceLastShown: activeDaysSinceLastShown,
    );
  }

  static int _activeDaysSinceLastShown({
    required DateTime? lastShownAt,
    required Set<DateTime> activeDates,
  }) {
    if (lastShownAt == null) {
      return kActiveDaysCap;
    }
    final lastShownDay =
        DateTime(lastShownAt.year, lastShownAt.month, lastShownAt.day);
    var count = 0;
    for (final date in activeDates) {
      if (date.isAfter(lastShownDay)) {
        count += 1;
      }
    }
    return count;
  }
}
