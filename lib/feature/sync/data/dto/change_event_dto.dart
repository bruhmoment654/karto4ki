import 'package:json_annotation/json_annotation.dart';

import 'package:quizzerg/feature/sync/domain/entity/sync_entity_type.dart';
import 'package:quizzerg/network/dto/utc_date_time_converter.dart';

part 'change_event_dto.g.dart';

/// Изменение сущности в журнале синхронизации.
@JsonSerializable(checked: true)
class ChangeEventDto {
  @JsonKey(unknownEnumValue: SyncEntityType.unknown)
  final SyncEntityType entity;

  @JsonKey(unknownEnumValue: SyncOp.unknown)
  final SyncOp op;

  final String id;

  /// Снимок сущности. При `delete` — `null`; при `upsert` тоже может быть
  /// `null`, если сущность успела удалиться, — на это нельзя падать.
  final Map<String, dynamic>? payload;

  @UtcDateTimeConverter()
  final DateTime occurredAt;

  const ChangeEventDto({
    required this.entity,
    required this.op,
    required this.id,
    required this.occurredAt,
    this.payload,
  });

  factory ChangeEventDto.fromJson(Map<String, dynamic> json) =>
      _$ChangeEventDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ChangeEventDtoToJson(this);
}
