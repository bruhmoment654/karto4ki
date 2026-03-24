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
          mixupMin:
              $checkedConvert('mixupMin', (v) => (v as num?)?.toInt() ?? 1),
          mixupMax:
              $checkedConvert('mixupMax', (v) => (v as num?)?.toInt() ?? 5),
          themeMode: $checkedConvert(
              'themeMode',
              (v) =>
                  $enumDecodeNullable(_$AppThemeModeEnumMap, v) ??
                  AppThemeMode.system),
          mixupAlgorithm: $checkedConvert(
              'mixupAlgorithm',
              (v) =>
                  $enumDecodeNullable(_$MixupAlgorithmEnumMap, v) ??
                  MixupAlgorithm.classic),
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
      'mixupMin': instance.mixupMin,
      'mixupMax': instance.mixupMax,
      'themeMode': _$AppThemeModeEnumMap[instance.themeMode]!,
      'mixupAlgorithm': _$MixupAlgorithmEnumMap[instance.mixupAlgorithm]!,
    };

const _$AppThemeModeEnumMap = {
  AppThemeMode.light: 'light',
  AppThemeMode.dark: 'dark',
  AppThemeMode.system: 'system',
};

const _$MixupAlgorithmEnumMap = {
  MixupAlgorithm.classic: 'classic',
  MixupAlgorithm.scoring: 'scoring',
};
