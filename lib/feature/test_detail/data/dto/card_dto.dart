import 'package:json_annotation/json_annotation.dart';

import 'package:quizzerg/network/dto/patch_value.dart';
import 'package:quizzerg/network/dto/utc_date_time_converter.dart';

part 'card_dto.g.dart';

/// Карточка в API.
@JsonSerializable(checked: true)
class CardDto {
  final String id;
  final String testId;
  final String front;
  final List<String> answers;

  /// Read-only: считает сервер. В теле push игнорируется.
  final String? questionKey;

  @UtcDateTimeConverter()
  final DateTime createdAt;

  @UtcDateTimeConverter()
  final DateTime updatedAt;

  const CardDto({
    required this.id,
    required this.testId,
    required this.front,
    required this.answers,
    required this.createdAt,
    required this.updatedAt,
    this.questionKey,
  });

  factory CardDto.fromJson(Map<String, dynamic> json) =>
      _$CardDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CardDtoToJson(this);
}

/// Тело `POST /cards`.
@JsonSerializable(checked: true, createFactory: false)
class CreateCardDto {
  final String testId;
  final String front;
  final List<String> answers;

  const CreateCardDto({
    required this.testId,
    required this.front,
    required this.answers,
  });

  Map<String, dynamic> toJson() => _$CreateCardDtoToJson(this);
}

/// Тело `PATCH /cards/{id}`.
class UpdateCardDto {
  final PatchValue<String>? front;
  final PatchValue<List<String>>? answers;

  const UpdateCardDto({this.front, this.answers});

  Map<String, dynamic> toJson() {
    final json = <String, Object?>{};
    PatchBody.put(json, 'front', front);
    PatchBody.put(json, 'answers', answers);

    return json;
  }
}

/// Одна карточка в теле `POST /cards/batch`.
@JsonSerializable(checked: true, createFactory: false)
class BatchCardItemDto {
  final String front;
  final List<String> answers;

  const BatchCardItemDto({required this.front, required this.answers});

  Map<String, dynamic> toJson() => _$BatchCardItemDtoToJson(this);
}

/// Тело `POST /cards/batch`.
@JsonSerializable(checked: true, createFactory: false, explicitToJson: true)
class BatchCreateCardsDto {
  final String testId;
  final List<BatchCardItemDto> cards;

  const BatchCreateCardsDto({required this.testId, required this.cards});

  Map<String, dynamic> toJson() => _$BatchCreateCardsDtoToJson(this);
}

/// Ответ `POST /cards/batch`.
@JsonSerializable(checked: true, createToJson: false)
class BatchCreateCardsResultDto {
  final int created;
  final int skipped;
  final List<String> ids;

  const BatchCreateCardsResultDto({
    required this.created,
    required this.skipped,
    this.ids = const [],
  });

  factory BatchCreateCardsResultDto.fromJson(Map<String, dynamic> json) =>
      _$BatchCreateCardsResultDtoFromJson(json);
}
