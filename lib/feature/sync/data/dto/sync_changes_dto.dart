import 'package:json_annotation/json_annotation.dart';

import 'package:quizzerg/feature/sync/data/dto/change_event_dto.dart';
import 'package:quizzerg/network/dto/utc_date_time_converter.dart';

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

  /// Часы сервера на момент генерации ответа.
  ///
  /// nullable, пока бэкенд не выкатил поле: клиент должен собираться
  /// и работать со старой сборкой сервера.
  @NullableUtcDateTimeConverter()
  final DateTime? serverTime;

  /// Сколько событий осталось за отданным курсором.
  ///
  /// Согласовано с [hasMore] (`hasMore == remaining > 0`), поэтому надёжный
  /// признак конца журнала — `remaining == 0`. nullable до выкатки поля.
  final int? remaining;

  const SyncChangesDto({
    required this.changes,
    required this.hasMore,
    this.nextCursor,
    this.serverTime,
    this.remaining,
  });

  factory SyncChangesDto.fromJson(Map<String, dynamic> json) =>
      _$SyncChangesDtoFromJson(json);
}
