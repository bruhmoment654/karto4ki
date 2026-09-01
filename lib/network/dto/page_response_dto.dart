import 'package:json_annotation/json_annotation.dart';

part 'page_response_dto.g.dart';

/// Страница списочного ответа.
///
/// `nextCursor` — opaque-строка, парсить её нельзя: клиент просто
/// возвращает её в следующем запросе.
@JsonSerializable(
    checked: true, createToJson: false, genericArgumentFactories: true)
class PageResponseDto<T> {
  final List<T> items;
  final String? nextCursor;
  final bool hasMore;

  const PageResponseDto({
    required this.items,
    required this.hasMore,
    this.nextCursor,
  });

  factory PageResponseDto.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$PageResponseDtoFromJson(json, fromJsonT);
}
