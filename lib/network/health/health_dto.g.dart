// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HealthDto _$HealthDtoFromJson(Map<String, dynamic> json) => $checkedCreate(
      'HealthDto',
      json,
      ($checkedConvert) {
        final val = HealthDto(
          status: $checkedConvert('status', (v) => v as String),
        );
        return val;
      },
    );

ReadyDto _$ReadyDtoFromJson(Map<String, dynamic> json) => $checkedCreate(
      'ReadyDto',
      json,
      ($checkedConvert) {
        final val = ReadyDto(
          status: $checkedConvert('status', (v) => v as String),
          checks: $checkedConvert(
              'checks',
              (v) =>
                  (v as Map<String, dynamic>?)?.map(
                    (k, e) => MapEntry(k, e as String),
                  ) ??
                  const {}),
        );
        return val;
      },
    );
