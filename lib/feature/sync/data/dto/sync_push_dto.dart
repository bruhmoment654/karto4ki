import 'package:json_annotation/json_annotation.dart';

import 'package:quizzerg/feature/sync/data/dto/change_event_dto.dart';
import 'package:quizzerg/feature/sync/domain/entity/sync_entity_type.dart';

part 'sync_push_dto.g.dart';

/// Тело `POST /sync/push` (до 1000 изменений).
@JsonSerializable(checked: true, createFactory: false, explicitToJson: true)
class SyncPushDto {
  final List<ChangeEventDto> changes;

  const SyncPushDto({required this.changes});

  Map<String, dynamic> toJson() => _$SyncPushDtoToJson(this);
}

/// Отвергнутое сервером изменение.
@JsonSerializable(checked: true, createToJson: false)
class SyncConflictDto {
  @JsonKey(unknownEnumValue: SyncEntityType.unknown)
  final SyncEntityType entity;

  final String id;

  @JsonKey(unknownEnumValue: SyncConflictReason.unknown)
  final SyncConflictReason reason;

  /// Серверная копия. Есть только при `server_newer`.
  final Map<String, dynamic>? server;

  const SyncConflictDto({
    required this.entity,
    required this.id,
    required this.reason,
    this.server,
  });

  factory SyncConflictDto.fromJson(Map<String, dynamic> json) =>
      _$SyncConflictDtoFromJson(json);
}

/// Снимок сущности после применения изменения.
@JsonSerializable(checked: true, createToJson: false)
class AppliedChangeDto {
  @JsonKey(unknownEnumValue: SyncEntityType.unknown)
  final SyncEntityType entity;

  final String id;

  /// Состояние на сервере после записи. Отсутствует при `op = delete`.
  final Map<String, dynamic>? payload;

  const AppliedChangeDto({
    required this.entity,
    required this.id,
    this.payload,
  });

  factory AppliedChangeDto.fromJson(Map<String, dynamic> json) =>
      _$AppliedChangeDtoFromJson(json);
}

/// Ответ `POST /sync/push`.
@JsonSerializable(checked: true, createToJson: false)
class SyncPushResultDto {
  final int applied;
  final List<SyncConflictDto> conflicts;
  final List<AppliedChangeDto> appliedItems;

  const SyncPushResultDto({
    required this.applied,
    this.conflicts = const [],
    this.appliedItems = const [],
  });

  factory SyncPushResultDto.fromJson(Map<String, dynamic> json) =>
      _$SyncPushResultDtoFromJson(json);
}
