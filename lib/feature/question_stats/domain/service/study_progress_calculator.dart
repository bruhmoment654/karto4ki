import 'package:quizzerg/feature/profile/domain/entity/profile_summary_entity.dart';
import 'package:quizzerg/feature/question_stats/domain/entity/study_progress_entity.dart';
import 'package:quizzerg/feature/test_execution/domain/service/accuracy_calculator.dart';

/// Вопрос теста со статистикой; `null` в полях — статистики по вопросу нет.
typedef QuestionProgressRow = ({
  String questionKey,
  int? streak,
  int? totalShown,
});

/// Данные для прогресса всех тестов разом: читаются одним проходом, а
/// прогресс отдельных тестов и групп собирается из них в памяти.
class StudyProgressSnapshot {
  /// id теста → его вопросы.
  final Map<String, List<QuestionProgressRow>> questionsByTest;

  /// id теста → точность за последние прохождения.
  final Map<String, double> accuracyByTest;

  /// id теста → последнее завершённое прохождение.
  final Map<String, DateTime> lastCompletedByTest;

  const StudyProgressSnapshot({
    required this.questionsByTest,
    required this.accuracyByTest,
    required this.lastCompletedByTest,
  });

  /// Прогресс набора тестов: одного теста или всех тестов группы.
  StudyProgressEntity of(Iterable<String> testIds) =>
      StudyProgressCalculator.calculate(
        testIds: testIds,
        questionsByTest: questionsByTest,
        accuracyByTest: accuracyByTest,
        lastCompletedByTest: lastCompletedByTest,
      );
}

/// Собирает [StudyProgressEntity] теста или группы из вопросов, точности и
/// дат прохождений её тестов.
abstract final class StudyProgressCalculator {
  /// Прогресс набора тестов [testIds]: для теста — один id, для группы —
  /// все её тесты.
  ///
  /// Вопрос, который есть в нескольких тестах, считается один раз. Точность —
  /// среднее по тестам с прохождениями, дата — самое свежее прохождение.
  static StudyProgressEntity calculate({
    required Iterable<String> testIds,
    required Map<String, List<QuestionProgressRow>> questionsByTest,
    required Map<String, double> accuracyByTest,
    required Map<String, DateTime> lastCompletedByTest,
  }) {
    final questions = <String, QuestionProgressRow>{};
    DateTime? lastStudiedAt;
    for (final testId in testIds) {
      for (final row
          in questionsByTest[testId] ?? const <QuestionProgressRow>[]) {
        questions[row.questionKey] = row;
      }
      final completedAt = lastCompletedByTest[testId];
      if (completedAt != null &&
          (lastStudiedAt == null || completedAt.isAfter(lastStudiedAt))) {
        lastStudiedAt = completedAt;
      }
    }

    var newCount = 0;
    var learningCount = 0;
    var masteredCount = 0;
    var weakCount = 0;
    for (final row in questions.values) {
      final streak = row.streak ?? 0;
      if ((row.totalShown ?? 0) == 0) {
        newCount++;
      } else if (streak < kWeakThreshold) {
        weakCount++;
      } else if (streak >= kMasteredThreshold) {
        masteredCount++;
      } else {
        learningCount++;
      }
    }

    return StudyProgressEntity(
      newCount: newCount,
      learningCount: learningCount,
      masteredCount: masteredCount,
      weakCount: weakCount,
      accuracy: AccuracyCalculator.groupAccuracy(
        testIds.map((testId) => accuracyByTest[testId]),
      ),
      lastStudiedAt: lastStudiedAt,
    );
  }
}
