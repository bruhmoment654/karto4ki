import 'package:flutter_test/flutter_test.dart';
import 'package:quizzerg/feature/profile/domain/entity/profile_summary_entity.dart';
import 'package:quizzerg/feature/profile/domain/profile_stats_calculator.dart';
import 'package:quizzerg/feature/question_stats/domain/entity/question_stats_entity.dart';

QuestionStatsEntity _stat({
  int streak = 0,
  int totalCorrect = 0,
  int totalIncorrect = 0,
  int totalShown = 0,
}) {
  return QuestionStatsEntity(
    id: 0,
    questionKey: 'k',
    frontText: 'front',
    backText: 'back',
    streak: streak,
    totalCorrect: totalCorrect,
    totalIncorrect: totalIncorrect,
    totalShown: totalShown,
    createdAt: DateTime(2024),
    updatedAt: DateTime(2024),
  );
}

void main() {
  group('ProfileStatsCalculator.calculate', () {
    final today = DateTime(2026, 6, 5); // пятница

    test('пустые данные → нули', () {
      final summary = ProfileStatsCalculator.calculate(
        stats: const [],
        activeDates: const [],
        today: today,
        groupsCount: 0,
        testsCount: 0,
      );

      expect(summary.answersTotal, 0);
      expect(summary.accuracyPercent, 0);
      expect(summary.totalCards, 0);
      expect(summary.masteredPercent, 0);
      expect(summary.flawlessPercent, 0);
      expect(summary.weakCardsCount, 0);
      expect(summary.currentStreak, 0);
      expect(summary.bestStreak, 0);
      expect(summary.activeDaysCount, 0);
      expect(summary.avgAnswersPerDay, 0);
      expect(summary.weekActivity, List.filled(7, false));
    });

    group('агрегаты', () {
      final summary = ProfileStatsCalculator.calculate(
        stats: [
          _stat(streak: 5, totalCorrect: 10, totalShown: 10), // mastered+flawless
          _stat(streak: 3, totalCorrect: 4, totalIncorrect: 1, totalShown: 5),
          _stat(totalCorrect: 1, totalIncorrect: 1, totalShown: 2),
          _stat(streak: -2, totalIncorrect: 3, totalShown: 3),
        ],
        activeDates: const [],
        today: today,
        groupsCount: 3,
        testsCount: 19,
      );

      test('точность', () {
        // верных 15 из 20 → 75%
        expect(summary.correctTotal, 15);
        expect(summary.answersTotal, 20);
        expect(summary.accuracyPercent, 75);
      });

      test('изучено (streak >= 3)', () {
        expect(summary.masteredCount, 2);
        expect(summary.masteredPercent, 50);
      });

      test('без ошибок (incorrect == 0 && shown > 0)', () {
        expect(summary.flawlessCount, 1);
        expect(summary.flawlessPercent, 25);
      });

      test('слабые (streak < 0)', () {
        expect(summary.weakCardsCount, 1);
      });

      test('счётчики групп/тестов', () {
        expect(summary.groupsCount, 3);
        expect(summary.testsCount, 19);
      });
    });

    group('currentStreak', () {
      ProfileSummaryEntity calcWithDates(List<DateTime> dates) =>
          ProfileStatsCalculator.calculate(
            stats: const [],
            activeDates: dates,
            today: today,
            groupsCount: 0,
            testsCount: 0,
          );

      test('сегодня + предыдущие подряд', () {
        final summary = calcWithDates([
          DateTime(2026, 6, 3),
          DateTime(2026, 6, 4),
          DateTime(2026, 6, 5),
        ]);
        expect(summary.currentStreak, 3);
      });

      test('сегодня нет, но вчера есть → серия от вчера', () {
        final summary = calcWithDates([
          DateTime(2026, 6, 3),
          DateTime(2026, 6, 4),
        ]);
        expect(summary.currentStreak, 2);
      });

      test('ни сегодня, ни вчера → 0', () {
        final summary = calcWithDates([
          DateTime(2026, 6),
          DateTime(2026, 6, 2),
        ]);
        expect(summary.currentStreak, 0);
      });

      test('разрыв обрывает текущую серию', () {
        final summary = calcWithDates([
          DateTime(2026, 6),
          DateTime(2026, 6, 4),
          DateTime(2026, 6, 5),
        ]);
        expect(summary.currentStreak, 2);
      });

      test('нормализация времени суток', () {
        final summary = calcWithDates([
          DateTime(2026, 6, 5, 23, 59),
          DateTime(2026, 6, 4, 0, 1),
        ]);
        expect(summary.currentStreak, 2);
      });
    });

    group('bestStreak', () {
      test('самая длинная серия подряд', () {
        final summary = ProfileStatsCalculator.calculate(
          stats: const [],
          activeDates: [
            DateTime(2026, 5),
            DateTime(2026, 5, 2),
            DateTime(2026, 5, 3), // серия 3
            DateTime(2026, 5, 10),
            DateTime(2026, 5, 11), // серия 2
          ],
          today: today,
          groupsCount: 0,
          testsCount: 0,
        );
        expect(summary.bestStreak, 3);
      });

      test('один день → 1', () {
        final summary = ProfileStatsCalculator.calculate(
          stats: const [],
          activeDates: [DateTime(2026, 5)],
          today: today,
          groupsCount: 0,
          testsCount: 0,
        );
        expect(summary.bestStreak, 1);
      });
    });

    group('неделя и среднее', () {
      test('weekActivity мапит дни текущей недели Пн..Вс', () {
        // неделя today (пт 2026-06-05): Пн 1 .. Вс 7 июня
        final summary = ProfileStatsCalculator.calculate(
          stats: const [],
          activeDates: [
            DateTime(2026, 6), // Пн
            DateTime(2026, 6, 5), // Пт
            DateTime(2026, 5, 25), // прошлая неделя — не в счёт
          ],
          today: today,
          groupsCount: 0,
          testsCount: 0,
        );
        expect(
          summary.weekActivity,
          [true, false, false, false, true, false, false],
        );
      });

      test('avgAnswersPerDay = ответы / дни активности', () {
        final summary = ProfileStatsCalculator.calculate(
          stats: [
            _stat(totalCorrect: 6, totalIncorrect: 4, totalShown: 10),
          ],
          activeDates: [
            DateTime(2026, 6, 4),
            DateTime(2026, 6, 5),
          ],
          today: today,
          groupsCount: 0,
          testsCount: 0,
        );
        expect(summary.activeDaysCount, 2);
        expect(summary.avgAnswersPerDay, 5.0);
      });
    });
  });
}
