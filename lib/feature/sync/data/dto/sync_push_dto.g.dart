// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_push_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$SyncPushDtoToJson(SyncPushDto instance) =>
    <String, dynamic>{
      'changes': instance.changes.map((e) => e.toJson()).toList(),
    };

SyncConflictDto _$SyncConflictDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('SyncConflictDto', json, ($checkedConvert) {
      final val = SyncConflictDto(
        entity: $checkedConvert(
          'entity',
          (v) => $enumDecode(
            _$SyncEntityTypeEnumMap,
            v,
            unknownValue: SyncEntityType.unknown,
          ),
        ),
        id: $checkedConvert('id', (v) => v as String),
        reason: $checkedConvert(
          'reason',
          (v) => $enumDecode(
            _$SyncConflictReasonEnumMap,
            v,
            unknownValue: SyncConflictReason.unknown,
          ),
        ),
        server: $checkedConvert('server', (v) => v as Map<String, dynamic>?),
      );
      return val;
    });

const _$SyncEntityTypeEnumMap = {
  SyncEntityType.group: 'group',
  SyncEntityType.test: 'test',
  SyncEntityType.card: 'card',
  SyncEntityType.stats: 'stats',
  SyncEntityType.testSession: 'test_session',
  SyncEntityType.unknown: 'unknown',
};

const _$SyncConflictReasonEnumMap = {
  SyncConflictReason.serverNewer: 'server_newer',
  SyncConflictReason.deleted: 'deleted',
  SyncConflictReason.notFound: 'not_found',
  SyncConflictReason.unknown: 'unknown',
};

AppliedChangeDto _$AppliedChangeDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('AppliedChangeDto', json, ($checkedConvert) {
      final val = AppliedChangeDto(
        entity: $checkedConvert(
          'entity',
          (v) => $enumDecode(
            _$SyncEntityTypeEnumMap,
            v,
            unknownValue: SyncEntityType.unknown,
          ),
        ),
        id: $checkedConvert('id', (v) => v as String),
        payload: $checkedConvert('payload', (v) => v as Map<String, dynamic>?),
      );
      return val;
    });

SyncPushResultDto _$SyncPushResultDtoFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('SyncPushResultDto', json, ($checkedConvert) {
  final val = SyncPushResultDto(
    applied: $checkedConvert('applied', (v) => (v as num).toInt()),
    conflicts: $checkedConvert(
      'conflicts',
      (v) =>
          (v as List<dynamic>?)
              ?.map((e) => SyncConflictDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    ),
    appliedItems: $checkedConvert(
      'appliedItems',
      (v) =>
          (v as List<dynamic>?)
              ?.map((e) => AppliedChangeDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    ),
    serverTime: $checkedConvert(
      'serverTime',
      (v) => const NullableUtcDateTimeConverter().fromJson(v as String?),
    ),
  );
  return val;
});
