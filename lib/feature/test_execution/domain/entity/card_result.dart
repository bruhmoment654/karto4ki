import 'package:freezed_annotation/freezed_annotation.dart';

part 'card_result.freezed.dart';

/// Result of a single card answer during test execution.
@freezed
sealed class CardResult with _$CardResult {
  const factory CardResult({
    /// Card identifier.
    required String cardId,

    /// Whether the answer was correct.
    required bool isCorrect,

    /// Timestamp when the answer was given.
    required DateTime answeredAt,
  }) = _CardResult;
}
