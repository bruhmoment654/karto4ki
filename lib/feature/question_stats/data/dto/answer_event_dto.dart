import 'package:json_annotation/json_annotation.dart';

import 'package:quizzerg/network/dto/utc_date_time_converter.dart';

part 'answer_event_dto.g.dart';

/// Ответ на карточку.
///
/// `answeredAt` — время **самого ответа**, не время отправки: по паре
/// `(cardId, answeredAt)` сервер дедуплицирует повторные батчи.
@JsonSerializable(checked: true)
class AnswerEventDto {
  final String cardId;
  final bool isCorrect;

  @UtcDateTimeConverter()
  final DateTime answeredAt;

  const AnswerEventDto({
    required this.cardId,
    required this.isCorrect,
    required this.answeredAt,
  });

  factory AnswerEventDto.fromJson(Map<String, dynamic> json) =>
      _$AnswerEventDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AnswerEventDtoToJson(this);
}

/// Тело `POST /stats/answers/batch` (до 1000 событий).
@JsonSerializable(checked: true, createFactory: false, explicitToJson: true)
class BatchAnswerEventDto {
  final List<AnswerEventDto> events;

  const BatchAnswerEventDto({required this.events});

  Map<String, dynamic> toJson() => _$BatchAnswerEventDtoToJson(this);
}

/// Ответ `POST /stats/answers/batch`.
@JsonSerializable(checked: true, createToJson: false)
class BatchAnswerResultDto {
  final int applied;

  /// Карточки, которых нет на сервере.
  final List<String> notFound;

  /// Сколько событий сервер счёл повторами.
  final int duplicates;

  const BatchAnswerResultDto({
    required this.applied,
    this.notFound = const [],
    this.duplicates = 0,
  });

  factory BatchAnswerResultDto.fromJson(Map<String, dynamic> json) =>
      _$BatchAnswerResultDtoFromJson(json);
}
