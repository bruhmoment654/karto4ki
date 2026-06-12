import 'package:json_annotation/json_annotation.dart';

import 'package:quizzerg/feature/test_execution/data/dto/card_result_dto.dart';
import 'package:quizzerg/feature/test_execution/data/dto/card_snapshot_dto.dart';
import 'package:quizzerg/feature/test_execution/data/dto/launch_params_dto.dart';

part 'active_test_session_dto.g.dart';

/// Корневой DTO активной (последней) сессии теста.
///
/// Содержит всю информацию, необходимую для возобновления сессии
/// после перезапуска приложения.
@JsonSerializable(checked: true, explicitToJson: true)
class ActiveTestSessionDto {
  final String testId;
  final String testTitle;
  final int currentIndex;
  final DateTime startedAt;
  final DateTime updatedAt;
  final List<CardSnapshotDto> cards;
  final List<CardResultDto> results;
  final LaunchParamsDto launchParams;

  const ActiveTestSessionDto({
    required this.testId,
    required this.testTitle,
    required this.currentIndex,
    required this.startedAt,
    required this.updatedAt,
    required this.cards,
    required this.results,
    required this.launchParams,
  });

  factory ActiveTestSessionDto.fromJson(Map<String, dynamic> json) =>
      _$ActiveTestSessionDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ActiveTestSessionDtoToJson(this);
}
