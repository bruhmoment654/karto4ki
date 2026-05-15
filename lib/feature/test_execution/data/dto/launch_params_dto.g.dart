// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'launch_params_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LaunchParamsDto _$LaunchParamsDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'LaunchParamsDto',
      json,
      ($checkedConvert) {
        final val = LaunchParamsDto(
          swapSides: $checkedConvert('swapSides', (v) => v as bool),
          answerIndex:
              $checkedConvert('answerIndex', (v) => (v as num).toInt()),
          mixup: $checkedConvert('mixup', (v) => v as bool),
          mixupMin: $checkedConvert('mixupMin', (v) => (v as num).toInt()),
          mixupMax: $checkedConvert('mixupMax', (v) => (v as num).toInt()),
          algorithm: $checkedConvert(
              'algorithm', (v) => $enumDecode(_$MixupAlgorithmEnumMap, v)),
        );
        return val;
      },
    );

Map<String, dynamic> _$LaunchParamsDtoToJson(LaunchParamsDto instance) =>
    <String, dynamic>{
      'swapSides': instance.swapSides,
      'answerIndex': instance.answerIndex,
      'mixup': instance.mixup,
      'mixupMin': instance.mixupMin,
      'mixupMax': instance.mixupMax,
      'algorithm': _$MixupAlgorithmEnumMap[instance.algorithm]!,
    };

const _$MixupAlgorithmEnumMap = {
  MixupAlgorithm.classic: 'classic',
  MixupAlgorithm.scoring: 'scoring',
};
