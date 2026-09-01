// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PageResponseDto<T> _$PageResponseDtoFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    $checkedCreate(
      'PageResponseDto',
      json,
      ($checkedConvert) {
        final val = PageResponseDto<T>(
          items: $checkedConvert(
              'items', (v) => (v as List<dynamic>).map(fromJsonT).toList()),
          hasMore: $checkedConvert('hasMore', (v) => v as bool),
          nextCursor: $checkedConvert('nextCursor', (v) => v as String?),
        );
        return val;
      },
    );
