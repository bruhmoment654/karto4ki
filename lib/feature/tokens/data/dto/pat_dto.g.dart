// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pat_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatDto _$PatDtoFromJson(Map<String, dynamic> json) => $checkedCreate(
      'PatDto',
      json,
      ($checkedConvert) {
        final val = PatDto(
          id: $checkedConvert('id', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String),
          prefix: $checkedConvert('prefix', (v) => v as String),
          suffix: $checkedConvert('suffix', (v) => v as String),
          scopes: $checkedConvert('scopes',
              (v) => (v as List<dynamic>).map((e) => e as String).toList()),
          createdAt: $checkedConvert('createdAt',
              (v) => const UtcDateTimeConverter().fromJson(v as String)),
          lastUsedAt: $checkedConvert(
              'lastUsedAt',
              (v) =>
                  const NullableUtcDateTimeConverter().fromJson(v as String?)),
          expiresAt: $checkedConvert(
              'expiresAt',
              (v) =>
                  const NullableUtcDateTimeConverter().fromJson(v as String?)),
        );
        return val;
      },
    );

PatListDto _$PatListDtoFromJson(Map<String, dynamic> json) => $checkedCreate(
      'PatListDto',
      json,
      ($checkedConvert) {
        final val = PatListDto(
          tokens: $checkedConvert(
              'tokens',
              (v) =>
                  (v as List<dynamic>?)
                      ?.map((e) => PatDto.fromJson(e as Map<String, dynamic>))
                      .toList() ??
                  const []),
        );
        return val;
      },
    );

Map<String, dynamic> _$CreatePatDtoToJson(CreatePatDto instance) {
  final val = <String, dynamic>{
    'name': instance.name,
    'scopes': instance.scopes,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('expiresInDays', instance.expiresInDays);
  return val;
}

CreatePatResponseDto _$CreatePatResponseDtoFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'CreatePatResponseDto',
      json,
      ($checkedConvert) {
        final val = CreatePatResponseDto(
          id: $checkedConvert('id', (v) => v as String),
          token: $checkedConvert('token', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String),
          scopes: $checkedConvert('scopes',
              (v) => (v as List<dynamic>).map((e) => e as String).toList()),
          createdAt: $checkedConvert('createdAt',
              (v) => const UtcDateTimeConverter().fromJson(v as String)),
          expiresAt: $checkedConvert(
              'expiresAt',
              (v) =>
                  const NullableUtcDateTimeConverter().fromJson(v as String?)),
        );
        return val;
      },
    );
