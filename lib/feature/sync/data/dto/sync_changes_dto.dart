import 'package:json_annotation/json_annotation.dart';

import 'package:quizzerg/feature/sync/data/dto/change_event_dto.dart';

part 'sync_changes_dto.g.dart';

/// Ответ `GET /sync/changes`.
///
/// Окно событий компактится, поэтому `changes` бывает короче `limit`:
/// ориентироваться нужно на [hasMore] и [nextCursor].
@JsonSerializable(checked: true, createToJson: false)
class SyncChangesDto {
  /// Opaque-курсор. Не парсить, просто вернуть в следующем запросе.
  final String? nextCursor;
  final List<ChangeEventDto> changes;
  final bool hasMore;

  const SyncChangesDto({
    required this.changes,
    required this.hasMore,
    this.nextCursor,
  });

  factory SyncChangesDto.fromJson(Map<String, dynamic> json) =>
      _$SyncChangesDtoFromJson(json);
}
