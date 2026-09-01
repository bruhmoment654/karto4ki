// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_event_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangeEventDto _$ChangeEventDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'ChangeEventDto',
      json,
      ($checkedConvert) {
        final val = ChangeEventDto(
          entity: $checkedConvert(
              'entity',
              (v) => $enumDecode(_$SyncEntityTypeEnumMap, v,
                  unknownValue: SyncEntityType.unknown)),
          op: $checkedConvert(
              'op',
              (v) => $enumDecode(_$SyncOpEnumMap, v,
                  unknownValue: SyncOp.unknown)),
          id: $checkedConvert('id', (v) => v as String),
          occurredAt: $checkedConvert('occurredAt',
              (v) => const UtcDateTimeConverter().fromJson(v as String)),
          payload:
              $checkedConvert('payload', (v) => v as Map<String, dynamic>?),
        );
        return val;
      },
    );

Map<String, dynamic> _$ChangeEventDtoToJson(ChangeEventDto instance) =>
    <String, dynamic>{
      'entity': _$SyncEntityTypeEnumMap[instance.entity]!,
      'op': _$SyncOpEnumMap[instance.op]!,
      'id': instance.id,
      'payload': instance.payload,
      'occurredAt': const UtcDateTimeConverter().toJson(instance.occurredAt),
    };

const _$SyncEntityTypeEnumMap = {
  SyncEntityType.group: 'group',
  SyncEntityType.test: 'test',
  SyncEntityType.card: 'card',
  SyncEntityType.stats: 'stats',
  SyncEntityType.testSession: 'test_session',
  SyncEntityType.unknown: 'unknown',
};

const _$SyncOpEnumMap = {
  SyncOp.upsert: 'upsert',
  SyncOp.delete: 'delete',
  SyncOp.restore: 'restore',
  SyncOp.unknown: 'unknown',
};
