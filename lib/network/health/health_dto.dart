import 'package:json_annotation/json_annotation.dart';

part 'health_dto.g.dart';

/// Ответ `GET /health`.
@JsonSerializable(checked: true, createToJson: false)
class HealthDto {
  final String status;

  const HealthDto({required this.status});

  factory HealthDto.fromJson(Map<String, dynamic> json) =>
      _$HealthDtoFromJson(json);
}

/// Ответ `GET /health/ready`.
@JsonSerializable(checked: true, createToJson: false)
class ReadyDto {
  /// `ok` | `degraded`.
  final String status;

  /// Состояние зависимостей: имя → `ok` | `fail`.
  final Map<String, String> checks;

  const ReadyDto({required this.status, this.checks = const {}});

  factory ReadyDto.fromJson(Map<String, dynamic> json) =>
      _$ReadyDtoFromJson(json);
}
