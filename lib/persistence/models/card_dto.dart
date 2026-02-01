import 'package:json_annotation/json_annotation.dart';

part 'card_dto.g.dart';

/// Card DTO for storage.
@JsonSerializable()
class CardDto {
  final String front;
  final String back;

  const CardDto({
    required this.front,
    required this.back,
  });

  factory CardDto.fromJson(Map<String, dynamic> json) =>
      _$CardDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CardDtoToJson(this);
}
