// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupDto _$GroupDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('GroupDto', json, ($checkedConvert) {
      final val = GroupDto(
        id: $checkedConvert('id', (v) => v as String),
        title: $checkedConvert('title', (v) => v as String),
        testCount: $checkedConvert('testCount', (v) => (v as num).toInt()),
        createdAt: $checkedConvert(
          'createdAt',
          (v) => const UtcDateTimeConverter().fromJson(v as String),
        ),
        updatedAt: $checkedConvert(
          'updatedAt',
          (v) => const UtcDateTimeConverter().fromJson(v as String),
        ),
      );
      return val;
    });

Map<String, dynamic> _$GroupDtoToJson(GroupDto instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'testCount': instance.testCount,
  'createdAt': const UtcDateTimeConverter().toJson(instance.createdAt),
  'updatedAt': const UtcDateTimeConverter().toJson(instance.updatedAt),
};

Map<String, dynamic> _$CreateGroupDtoToJson(CreateGroupDto instance) =>
    <String, dynamic>{'title': instance.title};
