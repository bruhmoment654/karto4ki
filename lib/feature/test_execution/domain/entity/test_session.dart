import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:karto4ki/feature/main/domain/entity/card_entity.dart';
import 'package:karto4ki/feature/test_execution/domain/entity/card_result.dart';

part 'test_session.freezed.dart';

/// Test execution session.
///
/// Tracks the progress and results of a test run.
@freezed
sealed class TestSession with _$TestSession {
  const TestSession._();

  const factory TestSession({
    /// Test identifier.
    required String testId,

    /// List of cards to go through.
    required List<CardEntity> cards,

    /// Current card index.
    required int currentIndex,

    /// Results for answered cards.
    required List<CardResult> results,

    /// Session start time.
    required DateTime startedAt,

    /// Session completion time (null if not completed).
    DateTime? completedAt,
  }) = _TestSession;

  /// Whether the test is completed.
  bool get isCompleted => currentIndex >= cards.length;

  /// Current card or null if completed.
  CardEntity? get currentCard => isCompleted ? null : cards[currentIndex];

  /// Number of correct answers.
  int get correctCount => results.where((r) => r.isCorrect).length;

  /// Number of incorrect answers.
  int get incorrectCount => results.where((r) => !r.isCorrect).length;

  /// Progress percentage (0.0 to 1.0).
  double get progress => cards.isEmpty ? 1.0 : currentIndex / cards.length;

  TestSession get previous {
    assert(currentIndex > 0, 'Cannot get previous session for the first card');

    return copyWith(
      currentIndex: currentIndex - 1,
      results: results.sublist(0, results.length - 1),
    );
  }
}
