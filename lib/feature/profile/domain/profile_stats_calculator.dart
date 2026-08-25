import 'package:quizzerg/feature/profile/domain/entity/profile_summary_entity.dart';
import 'package:quizzerg/feature/question_stats/domain/entity/question_stats_entity.dart';

/// Чистый калькулятор агрегированной статистики профиля.
///
/// Все вычисления детерминированы: текущая дата `today` передаётся аргументом
/// (а не берётся из `DateTime.now()`), чтобы покрыть логику тестами.
class ProfileStatsCalculator {
  const ProfileStatsCalculator._();

  /// Собирает [ProfileSummaryEntity] из посписочной статистики карточек
  /// [stats], набора активных дат [activeDates] и счётчиков групп/тестов.
  static ProfileSummaryEntity calculate({
    required List<QuestionStatsEntity> stats,
    required List<DateTime> activeDates,
    required DateTime today,
    required int groupsCount,
    required int testsCount,
  }) {
    var correctTotal = 0;
    var incorrectTotal = 0;
    var masteredCount = 0;
    var flawlessCount = 0;
    var weakCardsCount = 0;

    for (final stat in stats) {
      correctTotal += stat.totalCorrect;
      incorrectTotal += stat.totalIncorrect;

      if (stat.streak >= kMasteredThreshold) masteredCount++;
      if (stat.totalIncorrect == 0 && stat.totalShown > 0) flawlessCount++;
      if (stat.streak < kWeakThreshold) weakCardsCount++;
    }

    final answersTotal = correctTotal + incorrectTotal;
    final totalCards = stats.length;
    final activeDaysSet = _normalizedSet(activeDates);
    final today0 = _normalize(today);

    return ProfileSummaryEntity(
      answersTotal: answersTotal,
      correctTotal: correctTotal,
      accuracyPercent: _percent(correctTotal, answersTotal),
      totalCards: totalCards,
      masteredCount: masteredCount,
      masteredPercent: _percent(masteredCount, totalCards),
      flawlessCount: flawlessCount,
      flawlessPercent: _percent(flawlessCount, totalCards),
      weakCardsCount: weakCardsCount,
      currentStreak: _currentStreak(activeDaysSet, today0),
      bestStreak: _bestStreak(activeDaysSet),
      activeDaysCount: activeDaysSet.length,
      avgAnswersPerDay:
          activeDaysSet.isEmpty ? 0 : answersTotal / activeDaysSet.length,
      weekActivity: _weekActivity(activeDaysSet, today0),
      groupsCount: groupsCount,
      testsCount: testsCount,
    );
  }

  /// Текущая серия: если сегодня нет в множестве, допускаем вчерашний день
  /// (сегодняшний мог ещё не начаться). Затем шагаем назад, пока даты идут
  /// подряд.
  static int _currentStreak(Set<DateTime> days, DateTime today) {
    if (days.isEmpty) return 0;

    var cursor = today;
    if (!days.contains(cursor)) {
      cursor = cursor.subtract(const Duration(days: 1));
      if (!days.contains(cursor)) return 0;
    }

    var streak = 0;
    while (days.contains(cursor)) {
      streak++;
      cursor = cursor.subtract(const Duration(days: 1));
    }
    return streak;
  }

  /// Лучшая серия: максимум подряд идущих дат (разница ровно 1 день).
  static int _bestStreak(Set<DateTime> days) {
    if (days.isEmpty) return 0;

    final sorted = days.toList()..sort();
    var best = 1;
    var current = 1;
    for (var i = 1; i < sorted.length; i++) {
      final diff = sorted[i].difference(sorted[i - 1]).inDays;
      if (diff == 1) {
        current++;
        if (current > best) best = current;
      } else {
        current = 1;
      }
    }
    return best;
  }

  /// Активность по дням текущей недели: понедельник + 7 дней, для каждого —
  /// есть ли он в множестве активных дат.
  static List<bool> _weekActivity(Set<DateTime> days, DateTime today) {
    final monday = today.subtract(Duration(days: today.weekday - 1));
    return List<bool>.generate(
      7,
      (index) => days.contains(monday.add(Duration(days: index))),
    );
  }

  static Set<DateTime> _normalizedSet(List<DateTime> dates) =>
      dates.map(_normalize).toSet();

  static DateTime _normalize(DateTime date) =>
      DateTime(date.year, date.month, date.day);

  static int _percent(int value, int total) =>
      total == 0 ? 0 : (value / total * 100).round();
}
