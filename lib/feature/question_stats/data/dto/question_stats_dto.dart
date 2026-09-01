import 'package:json_annotation/json_annotation.dart';

import 'package:quizzerg/network/dto/utc_date_time_converter.dart';

part 'question_stats_dto.g.dart';

/// Агрегат статистики по уникальному вопросу.
@JsonSerializable(checked: true)
class QuestionStatsDto {
  final String id;
  final String questionKey;
  final String frontText;
  final String backText;
  final int streak;
  final int totalCorrect;
  final int totalIncorrect;
  final int totalShown;

  @NullableUtcDateTimeConverter()
  final DateTime? lastAnsweredAt;

  @NullableUtcDateTimeConverter()
  final DateTime? lastShownAt;

  @UtcDateTimeConverter()
  final DateTime createdAt;

  @UtcDateTimeConverter()
  final DateTime updatedAt;

  const QuestionStatsDto({
    required this.id,
    required this.questionKey,
    required this.frontText,
    required this.backText,
    required this.streak,
    required this.totalCorrect,
    required this.totalIncorrect,
    required this.totalShown,
    required this.createdAt,
    required this.updatedAt,
    this.lastAnsweredAt,
    this.lastShownAt,
  });

  factory QuestionStatsDto.fromJson(Map<String, dynamic> json) =>
      _$QuestionStatsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionStatsDtoToJson(this);
}
