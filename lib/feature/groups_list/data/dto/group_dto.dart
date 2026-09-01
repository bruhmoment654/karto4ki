import 'package:json_annotation/json_annotation.dart';

import 'package:quizzerg/network/dto/patch_value.dart';
import 'package:quizzerg/network/dto/utc_date_time_converter.dart';

part 'group_dto.g.dart';

/// Группа тестов в API.
@JsonSerializable(checked: true)
class GroupDto {
  final String id;
  final String title;
  final int testCount;

  @UtcDateTimeConverter()
  final DateTime createdAt;

  @UtcDateTimeConverter()
  final DateTime updatedAt;

  const GroupDto({
    required this.id,
    required this.title,
    required this.testCount,
    required this.createdAt,
    required this.updatedAt,
  });

  factory GroupDto.fromJson(Map<String, dynamic> json) =>
      _$GroupDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GroupDtoToJson(this);
}

/// Тело `POST /groups`.
@JsonSerializable(checked: true, createFactory: false)
class CreateGroupDto {
  final String title;

  const CreateGroupDto({required this.title});

  Map<String, dynamic> toJson() => _$CreateGroupDtoToJson(this);
}

/// Тело `PATCH /groups/{id}`.
class UpdateGroupDto {
  final PatchValue<String>? title;

  const UpdateGroupDto({this.title});

  Map<String, dynamic> toJson() {
    final json = <String, Object?>{};
    PatchBody.put(json, 'title', title);

    return json;
  }
}
