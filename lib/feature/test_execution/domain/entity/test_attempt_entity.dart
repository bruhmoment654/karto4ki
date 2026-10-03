import 'package:freezed_annotation/freezed_annotation.dart';

part 'test_attempt_entity.freezed.dart';

/// Завершённое прохождение теста.
@freezed
sealed class TestAttemptEntity with _$TestAttemptEntity {
  const TestAttemptEntity._();

  const factory TestAttemptEntity({
    required String id,
    required String testId,
    required DateTime startedAt,
    required DateTime completedAt,
    required int total,
    required int correct,
  }) = _TestAttemptEntity;

  /// Результат в процентах, округлённый.
  int get percent => total == 0 ? 0 : (correct * 100 / total).round();
}
