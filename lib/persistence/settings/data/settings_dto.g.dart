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
          shaderAnimationEnabled: $checkedConvert(
              'shaderAnimationEnabled', (v) => v as bool? ?? true),
          accentColorHue: $checkedConvert(
              'accentColorHue', (v) => (v as num?)?.toDouble() ?? 149.0),
          mixupEnabled:
              $checkedConvert('mixupEnabled', (v) => v as bool? ?? false),
        );
        return val;
      },
    );

Map<String, dynamic> _$SettingsDtoToJson(SettingsDto instance) =>
    <String, dynamic>{
      'animationDurationMs': instance.animationDurationMs,
      'shaderAnimationEnabled': instance.shaderAnimationEnabled,
      'accentColorHue': instance.accentColorHue,
      'mixupEnabled': instance.mixupEnabled,
    };
