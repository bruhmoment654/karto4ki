import 'package:json_annotation/json_annotation.dart';

part 'sync_dto.g.dart';

/// Сущности sync-протокола (API-нотация бэкенда).
abstract final class SyncEntityType {
  static const group = 'group';
  static const test = 'test';
  static const card = 'card';
  static const stats = 'stats';
  static const testSession = 'test_session';
}

/// Операции sync-протокола.
abstract final class SyncOpType {
  static const upsert = 'upsert';
  static const delete = 'delete';
  static const restore = 'restore';
}

/// Единица изменения (push и pull). Контракт бэкенда — `ChangeEventDto`.
@JsonSerializable()
class ChangeEventDto {
  final String entity;
  final String op;
  final String id;
  final Map<String, dynamic>? payload;
  final String? occurredAt;

  const ChangeEventDto({
    required this.entity,
    required this.op,
    required this.id,
    this.payload,
    this.occurredAt,
  });

  factory ChangeEventDto.fromJson(Map<String, dynamic> json) =>
      _$ChangeEventDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ChangeEventDtoToJson(this);
}

/// Ответ `GET /v1/sync/changes`.
@JsonSerializable(createToJson: false)
class SyncChangesDto {
  final String? nextCursor;
  final bool hasMore;
  final List<ChangeEventDto> changes;

  const SyncChangesDto({
    required this.nextCursor,
    required this.hasMore,
    required this.changes,
  });

  factory SyncChangesDto.fromJson(Map<String, dynamic> json) =>
      _$SyncChangesDtoFromJson(json);
}

/// Тело `POST /v1/sync/push`.
@JsonSerializable(createFactory: false)
class SyncPushDto {
  final List<ChangeEventDto> changes;

  const SyncPushDto({required this.changes});

  Map<String, dynamic> toJson() => _$SyncPushDtoToJson(this);
}

/// Конфликт из ответа `POST /v1/sync/push`.
@JsonSerializable(createToJson: false)
class SyncConflictDto {
  final String entity;
  final String id;
  final String reason;
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

/// Ответ `POST /v1/sync/push`.
@JsonSerializable(createToJson: false)
class SyncPushResultDto {
  final int applied;
  final List<SyncConflictDto> conflicts;

  const SyncPushResultDto({required this.applied, required this.conflicts});

  factory SyncPushResultDto.fromJson(Map<String, dynamic> json) =>
      _$SyncPushResultDtoFromJson(json);
}
