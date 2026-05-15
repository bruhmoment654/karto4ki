import 'package:json_annotation/json_annotation.dart';

part 'card_result_dto.g.dart';

/// Результат ответа на карточку в активной сессии.
@JsonSerializable(checked: true)
class CardResultDto {
  final String cardId;
  final bool isCorrect;
  final DateTime answeredAt;

  const CardResultDto({
    required this.cardId,
    required this.isCorrect,
    required this.answeredAt,
  });

  factory CardResultDto.fromJson(Map<String, dynamic> json) =>
      _$CardResultDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CardResultDtoToJson(this);
}
