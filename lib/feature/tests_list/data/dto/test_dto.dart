import 'package:json_annotation/json_annotation.dart';

import 'package:quizzerg/network/dto/patch_value.dart';
import 'package:quizzerg/network/dto/utc_date_time_converter.dart';

part 'test_dto.g.dart';

/// Тест в API.
@JsonSerializable(checked: true)
class TestDto {
  final String id;
  final String title;

  /// На MVP всегда `tinder`.
  final String type;
  final String? description;
  final int questionCount;
  final List<String> groupIds;

  @UtcDateTimeConverter()
  final DateTime createdAt;

  @UtcDateTimeConverter()
  final DateTime updatedAt;

  const TestDto({
    required this.id,
    required this.title,
    required this.type,
    required this.questionCount,
    required this.groupIds,
    required this.createdAt,
    required this.updatedAt,
    this.description,
  });

  factory TestDto.fromJson(Map<String, dynamic> json) =>
      _$TestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TestDtoToJson(this);
}

/// Тело `POST /tests`.
@JsonSerializable(checked: true, createFactory: false, includeIfNull: false)
class CreateTestDto {
  final String title;
  final String type;
  final String? description;
  final List<String> groupIds;

  const CreateTestDto({
    required this.title,
    required this.type,
    this.groupIds = const [],
    this.description,
  });

  Map<String, dynamic> toJson() => _$CreateTestDtoToJson(this);
}

/// Тело `PATCH /tests/{id}`.
///
/// `description: null` в теле **очищает** описание, отсутствие ключа —
/// не трогает. Поэтому поля обёрнуты в [PatchValue].
class UpdateTestDto {
  final PatchValue<String>? title;
  final PatchValue<String>? type;
  final PatchValue<String?>? description;
  final PatchValue<List<String>>? groupIds;

  const UpdateTestDto({
    this.title,
    this.type,
    this.description,
    this.groupIds,
  });

  Map<String, dynamic> toJson() {
    final json = <String, Object?>{};
    PatchBody.put(json, 'title', title);
    PatchBody.put(json, 'type', type);
    PatchBody.put(json, 'description', description);
    PatchBody.put(json, 'groupIds', groupIds);

    return json;
  }
}

/// Тело `POST /tests/{id}/merge`.
@JsonSerializable(checked: true, createFactory: false)
class MergeTestDto {
  final String targetTestId;

  const MergeTestDto({required this.targetTestId});

  Map<String, dynamic> toJson() => _$MergeTestDtoToJson(this);
}

/// Тело `POST /tests/{id}/move-cards`.
@JsonSerializable(checked: true, createFactory: false)
class MoveCardsDto {
  final List<String> cardIds;
  final String targetTestId;

  const MoveCardsDto({required this.cardIds, required this.targetTestId});

  Map<String, dynamic> toJson() => _$MoveCardsDtoToJson(this);
}

/// Ответ `POST /tests/{id}/move-cards`.
@JsonSerializable(checked: true, createToJson: false)
class MoveCardsResultDto {
  final int moved;

  const MoveCardsResultDto({required this.moved});

  factory MoveCardsResultDto.fromJson(Map<String, dynamic> json) =>
      _$MoveCardsResultDtoFromJson(json);
}
