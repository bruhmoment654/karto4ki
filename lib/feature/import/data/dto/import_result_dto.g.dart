// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'import_result_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImportResultDto _$ImportResultDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ImportResultDto', json, ($checkedConvert) {
      final val = ImportResultDto(
        inserted: $checkedConvert('inserted', (v) => (v as num).toInt()),
        updated: $checkedConvert('updated', (v) => (v as num).toInt()),
        skipped: $checkedConvert('skipped', (v) => (v as num).toInt()),
        dryRun: $checkedConvert('dryRun', (v) => v as bool),
        errors: $checkedConvert(
          'errors',
          (v) =>
              (v as List<dynamic>?)
                  ?.map(
                    (e) =>
                        ImportRowErrorDto.fromJson(e as Map<String, dynamic>),
                  )
                  .toList() ??
              const [],
        ),
        createdGroupId: $checkedConvert('createdGroupId', (v) => v as String?),
        createdTestId: $checkedConvert('createdTestId', (v) => v as String?),
      );
      return val;
    });

ImportRowErrorDto _$ImportRowErrorDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ImportRowErrorDto', json, ($checkedConvert) {
      final val = ImportRowErrorDto(
        row: $checkedConvert('row', (v) => (v as num).toInt()),
        message: $checkedConvert('message', (v) => v as String),
      );
      return val;
    });
