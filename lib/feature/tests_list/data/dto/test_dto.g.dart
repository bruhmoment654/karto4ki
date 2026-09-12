// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestDto _$TestDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('TestDto', json, ($checkedConvert) {
      final val = TestDto(
        id: $checkedConvert('id', (v) => v as String),
        title: $checkedConvert('title', (v) => v as String),
        type: $checkedConvert('type', (v) => v as String),
        questionCount: $checkedConvert(
          'questionCount',
          (v) => (v as num).toInt(),
        ),
        groupIds: $checkedConvert(
          'groupIds',
          (v) => (v as List<dynamic>).map((e) => e as String).toList(),
        ),
        createdAt: $checkedConvert(
          'createdAt',
          (v) => const UtcDateTimeConverter().fromJson(v as String),
        ),
        updatedAt: $checkedConvert(
          'updatedAt',
          (v) => const UtcDateTimeConverter().fromJson(v as String),
        ),
        description: $checkedConvert('description', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$TestDtoToJson(TestDto instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'type': instance.type,
  'description': instance.description,
  'questionCount': instance.questionCount,
  'groupIds': instance.groupIds,
  'createdAt': const UtcDateTimeConverter().toJson(instance.createdAt),
  'updatedAt': const UtcDateTimeConverter().toJson(instance.updatedAt),
};

Map<String, dynamic> _$CreateTestDtoToJson(CreateTestDto instance) =>
    <String, dynamic>{
      'title': instance.title,
      'type': instance.type,
      'description': ?instance.description,
      'groupIds': instance.groupIds,
    };

Map<String, dynamic> _$MergeTestDtoToJson(MergeTestDto instance) =>
    <String, dynamic>{'targetTestId': instance.targetTestId};

Map<String, dynamic> _$MoveCardsDtoToJson(MoveCardsDto instance) =>
    <String, dynamic>{
      'cardIds': instance.cardIds,
      'targetTestId': instance.targetTestId,
    };

MoveCardsResultDto _$MoveCardsResultDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('MoveCardsResultDto', json, ($checkedConvert) {
      final val = MoveCardsResultDto(
        moved: $checkedConvert('moved', (v) => (v as num).toInt()),
      );
      return val;
    });
