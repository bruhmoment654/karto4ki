// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_changes_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SyncChangesDto _$SyncChangesDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'SyncChangesDto',
      json,
      ($checkedConvert) {
        final val = SyncChangesDto(
          changes: $checkedConvert(
              'changes',
              (v) => (v as List<dynamic>)
                  .map(
                      (e) => ChangeEventDto.fromJson(e as Map<String, dynamic>))
                  .toList()),
          hasMore: $checkedConvert('hasMore', (v) => v as bool),
          nextCursor: $checkedConvert('nextCursor', (v) => v as String?),
        );
        return val;
      },
    );
