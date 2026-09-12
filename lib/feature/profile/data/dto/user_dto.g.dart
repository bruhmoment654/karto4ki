// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDto _$UserDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('UserDto', json, ($checkedConvert) {
      final val = UserDto(
        id: $checkedConvert('id', (v) => v as String),
        email: $checkedConvert('email', (v) => v as String),
        plan: $checkedConvert('plan', (v) => v as String),
        createdAt: $checkedConvert(
          'createdAt',
          (v) => const UtcDateTimeConverter().fromJson(v as String),
        ),
        updatedAt: $checkedConvert(
          'updatedAt',
          (v) => const UtcDateTimeConverter().fromJson(v as String),
        ),
        displayName: $checkedConvert('displayName', (v) => v as String?),
        avatarUrl: $checkedConvert('avatarUrl', (v) => v as String?),
      );
      return val;
    });
