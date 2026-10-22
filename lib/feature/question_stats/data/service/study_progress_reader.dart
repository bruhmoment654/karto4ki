import 'package:quizzerg/feature/question_stats/domain/service/study_progress_calculator.dart';
import 'package:quizzerg/feature/test_detail/data/database/cards_database.dart';
import 'package:quizzerg/feature/test_execution/data/database/test_attempts_database.dart';
import 'package:quizzerg/feature/test_execution/domain/service/accuracy_calculator.dart';

/// Читает из базы всё, из чего считается прогресс тестов и групп.
class StudyProgressReader {
  final CardsDatabase _cardsDatabase;
  final TestAttemptsDatabase _testAttemptsDatabase;

  const StudyProgressReader({
    required CardsDatabase cardsDatabase,
    required TestAttemptsDatabase testAttemptsDatabase,
  }) : _cardsDatabase = cardsDatabase,
       _testAttemptsDatabase = testAttemptsDatabase;

  Future<StudyProgressSnapshot> read() async => StudyProgressSnapshot(
    questionsByTest: await _cardsDatabase.getQuestionRows(),
    accuracyByTest: await _testAttemptsDatabase.getRecentAccuracy(
      attemptsLimit: AccuracyCalculator.attemptsWindow,
    ),
    lastCompletedByTest: await _testAttemptsDatabase.getLastCompletedAt(),
  );
}
