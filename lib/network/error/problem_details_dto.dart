import 'package:json_annotation/json_annotation.dart';

part 'problem_details_dto.g.dart';

/// Ошибка API в формате RFC 7807 (`application/problem+json`).
@JsonSerializable(checked: true, createToJson: false)
class ProblemDetailsDto {
  /// URI типа ошибки.
  final String? type;

  /// Человекочитаемый заголовок. Ориентироваться на него нельзя — только на [code].
  final String? title;

  /// HTTP-статус.
  final int? status;

  /// Машинночитаемый код ошибки, например `validation.invalid_field`.
  final String? code;

  /// Подробное описание.
  final String? detail;

  /// Путь запроса.
  final String? instance;

  /// Идентификатор запроса — по нему ищут на бэке.
  final String? requestId;

  /// Ошибки по полям (для `validation.*`).
  final List<ProblemFieldErrorDto>? errors;

  const ProblemDetailsDto({
    this.type,
    this.title,
    this.status,
    this.code,
    this.detail,
    this.instance,
    this.requestId,
    this.errors,
  });

  factory ProblemDetailsDto.fromJson(Map<String, dynamic> json) =>
      _$ProblemDetailsDtoFromJson(json);
}

/// Ошибка конкретного поля запроса.
@JsonSerializable(checked: true, createToJson: false)
class ProblemFieldErrorDto {
  final String field;
  final String message;

  const ProblemFieldErrorDto({required this.field, required this.message});

  factory ProblemFieldErrorDto.fromJson(Map<String, dynamic> json) =>
      _$ProblemFieldErrorDtoFromJson(json);
}
