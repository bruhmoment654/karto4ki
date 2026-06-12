// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangeEventDto _$ChangeEventDtoFromJson(Map<String, dynamic> json) =>
    ChangeEventDto(
      entity: json['entity'] as String,
      op: json['op'] as String,
      id: json['id'] as String,
      payload: json['payload'] as Map<String, dynamic>?,
      occurredAt: json['occurredAt'] as String?,
    );

Map<String, dynamic> _$ChangeEventDtoToJson(ChangeEventDto instance) =>
    <String, dynamic>{
      'entity': instance.entity,
      'op': instance.op,
      'id': instance.id,
      'payload': instance.payload,
      'occurredAt': instance.occurredAt,
    };

SyncChangesDto _$SyncChangesDtoFromJson(Map<String, dynamic> json) =>
    SyncChangesDto(
      nextCursor: json['nextCursor'] as String?,
      hasMore: json['hasMore'] as bool,
      changes: (json['changes'] as List<dynamic>)
          .map((e) => ChangeEventDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SyncPushDtoToJson(SyncPushDto instance) =>
    <String, dynamic>{
      'changes': instance.changes,
    };

SyncConflictDto _$SyncConflictDtoFromJson(Map<String, dynamic> json) =>
    SyncConflictDto(
      entity: json['entity'] as String,
      id: json['id'] as String,
      reason: json['reason'] as String,
      server: json['server'] as Map<String, dynamic>?,
    );

SyncPushResultDto _$SyncPushResultDtoFromJson(Map<String, dynamic> json) =>
    SyncPushResultDto(
      applied: (json['applied'] as num).toInt(),
      conflicts: (json['conflicts'] as List<dynamic>)
          .map((e) => SyncConflictDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
