import 'package:json_annotation/json_annotation.dart';

part 'stats_dto.g.dart';

/// Событие ответа. Контракт бэкенда — `AnswerEventDto`.
@JsonSerializable(createFactory: false)
class AnswerEventDto {
  final String cardId;
  final bool isCorrect;

  /// ISO-8601 UTC.
  final String answeredAt;

  const AnswerEventDto({
    required this.cardId,
    required this.isCorrect,
    required this.answeredAt,
  });

  Map<String, dynamic> toJson() => _$AnswerEventDtoToJson(this);
}

/// Тело `POST /v1/stats/answers/batch`.
@JsonSerializable(createFactory: false)
class BatchAnswerEventsDto {
  final List<AnswerEventDto> events;

  const BatchAnswerEventsDto({required this.events});

  Map<String, dynamic> toJson() => _$BatchAnswerEventsDtoToJson(this);
}

/// Ответ `POST /v1/stats/answers/batch`.
@JsonSerializable(createToJson: false)
class BatchAnswerResultDto {
  final int applied;
  final List<String> notFound;

  const BatchAnswerResultDto({required this.applied, required this.notFound});

  factory BatchAnswerResultDto.fromJson(Map<String, dynamic> json) =>
      _$BatchAnswerResultDtoFromJson(json);
}
