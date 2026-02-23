import 'package:freezed_annotation/freezed_annotation.dart';

part 'question_stats_entity.freezed.dart';

@freezed
sealed class QuestionStatsEntity with _$QuestionStatsEntity {
  const factory QuestionStatsEntity({
    required int id,
    required String questionKey,
    required String frontText,
    required String backText,
    required int streak,
    required int totalCorrect,
    required int totalIncorrect,
    required int totalShown,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? lastAnsweredAt,
  }) = _QuestionStatsEntity;
}
