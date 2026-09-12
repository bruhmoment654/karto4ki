import 'package:json_annotation/json_annotation.dart';

import 'package:quizzerg/network/dto/patch_value.dart';
import 'package:quizzerg/network/dto/utc_date_time_converter.dart';

part 'user_dto.g.dart';

/// Профиль пользователя.
@JsonSerializable(checked: true, createToJson: false)
class UserDto {
  final String id;
  final String email;
  final String? displayName;

  /// Аватар из OAuth-профиля (`picture` у Google).
  ///
  /// Навсегда nullable: фото у аккаунта может не быть, а выданные Google
  /// ссылки периодически протухают в 404 — инициалы остаются фолбэком.
  final String? avatarUrl;

  /// Тариф: `free` | `pro`.
  final String plan;

  @UtcDateTimeConverter()
  final DateTime createdAt;

  @UtcDateTimeConverter()
  final DateTime updatedAt;

  const UserDto({
    required this.id,
    required this.email,
    required this.plan,
    required this.createdAt,
    required this.updatedAt,
    this.displayName,
    this.avatarUrl,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);
}

/// Тело `PATCH /me`.
class UpdateMeDto {
  final PatchValue<String?>? displayName;

  const UpdateMeDto({this.displayName});

  Map<String, dynamic> toJson() {
    final json = <String, Object?>{};
    PatchBody.put(json, 'displayName', displayName);

    return json;
  }
}
