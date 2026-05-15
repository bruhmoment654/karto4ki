import 'package:json_annotation/json_annotation.dart';

import 'package:quizzerg/feature/tinder_test/domain/mixup/mixup_algorithm.dart';

part 'launch_params_dto.g.dart';

/// Параметры запуска теста, сохранённые вместе с активной сессией.
@JsonSerializable(checked: true)
class LaunchParamsDto {
  final bool swapSides;
  final int answerIndex;
  final bool mixup;
  final int mixupMin;
  final int mixupMax;
  final MixupAlgorithm algorithm;

  const LaunchParamsDto({
    required this.swapSides,
    required this.answerIndex,
    required this.mixup,
    required this.mixupMin,
    required this.mixupMax,
    required this.algorithm,
  });

  factory LaunchParamsDto.fromJson(Map<String, dynamic> json) =>
      _$LaunchParamsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$LaunchParamsDtoToJson(this);
}
