import 'package:json_annotation/json_annotation.dart';

part 'import_result_dto.g.dart';

/// Ответ `POST /import/csv`.
@JsonSerializable(checked: true, createToJson: false)
class ImportResultDto {
  final int inserted;
  final int updated;
  final int skipped;
  final List<ImportRowErrorDto> errors;
  final bool dryRun;
  final String? createdGroupId;
  final String? createdTestId;

  const ImportResultDto({
    required this.inserted,
    required this.updated,
    required this.skipped,
    required this.dryRun,
    this.errors = const [],
    this.createdGroupId,
    this.createdTestId,
  });

  factory ImportResultDto.fromJson(Map<String, dynamic> json) =>
      _$ImportResultDtoFromJson(json);
}

/// Ошибка разбора строки CSV (нумерация с 1, заголовок — строка 1).
@JsonSerializable(checked: true, createToJson: false)
class ImportRowErrorDto {
  final int row;
  final String message;

  const ImportRowErrorDto({required this.row, required this.message});

  factory ImportRowErrorDto.fromJson(Map<String, dynamic> json) =>
      _$ImportRowErrorDtoFromJson(json);
}
