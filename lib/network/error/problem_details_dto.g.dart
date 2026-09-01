// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'problem_details_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProblemDetailsDto _$ProblemDetailsDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'ProblemDetailsDto',
      json,
      ($checkedConvert) {
        final val = ProblemDetailsDto(
          type: $checkedConvert('type', (v) => v as String?),
          title: $checkedConvert('title', (v) => v as String?),
          status: $checkedConvert('status', (v) => (v as num?)?.toInt()),
          code: $checkedConvert('code', (v) => v as String?),
          detail: $checkedConvert('detail', (v) => v as String?),
          instance: $checkedConvert('instance', (v) => v as String?),
          requestId: $checkedConvert('requestId', (v) => v as String?),
          errors: $checkedConvert(
              'errors',
              (v) => (v as List<dynamic>?)
                  ?.map((e) =>
                      ProblemFieldErrorDto.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
    );

ProblemFieldErrorDto _$ProblemFieldErrorDtoFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'ProblemFieldErrorDto',
      json,
      ($checkedConvert) {
        final val = ProblemFieldErrorDto(
          field: $checkedConvert('field', (v) => v as String),
          message: $checkedConvert('message', (v) => v as String),
        );
        return val;
      },
    );
