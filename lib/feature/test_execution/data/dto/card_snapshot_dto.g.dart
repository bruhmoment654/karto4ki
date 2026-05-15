// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_snapshot_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardSnapshotDto _$CardSnapshotDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'CardSnapshotDto',
      json,
      ($checkedConvert) {
        final val = CardSnapshotDto(
          id: $checkedConvert('id', (v) => v as String),
          testId: $checkedConvert('testId', (v) => v as String),
          front: $checkedConvert('front', (v) => v as String),
          answers: $checkedConvert('answers',
              (v) => (v as List<dynamic>).map((e) => e as String).toList()),
          createdAt:
              $checkedConvert('createdAt', (v) => DateTime.parse(v as String)),
          updatedAt:
              $checkedConvert('updatedAt', (v) => DateTime.parse(v as String)),
          isMixedIn: $checkedConvert('isMixedIn', (v) => v as bool),
        );
        return val;
      },
    );

Map<String, dynamic> _$CardSnapshotDtoToJson(CardSnapshotDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'testId': instance.testId,
      'front': instance.front,
      'answers': instance.answers,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'isMixedIn': instance.isMixedIn,
    };
