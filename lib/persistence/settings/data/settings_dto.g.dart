// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettingsDto _$SettingsDtoFromJson(Map<String, dynamic> json) => $checkedCreate(
      'SettingsDto',
      json,
      ($checkedConvert) {
        final val = SettingsDto(
          animationDurationMs: $checkedConvert(
              'animationDurationMs', (v) => (v as num?)?.toInt() ?? 300),
        );
        return val;
      },
    );

Map<String, dynamic> _$SettingsDtoToJson(SettingsDto instance) =>
    <String, dynamic>{
      'animationDurationMs': instance.animationDurationMs,
    };
