import 'package:quizzerg/network/dto/page_response_dto.dart';

/// Тянет страницы, пока сервер сообщает `hasMore`.
abstract final class Paginator {
  /// Максимум страниц за один проход — страховка от бесконечного цикла,
  /// если сервер начнёт возвращать один и тот же курсор.
  static const maxPages = 1000;

  /// Собирает все элементы списочного эндпоинта.
  static Future<List<T>> collect<T>(
    Future<PageResponseDto<T>> Function(String? cursor) loadPage,
  ) async {
    final items = <T>[];
    String? cursor;

    for (var page = 0; page < maxPages; page++) {
      final response = await loadPage(cursor);
      items.addAll(response.items);

      final next = response.nextCursor;
      if (!response.hasMore || next == null || next == cursor) break;

      cursor = next;
    }

    return items;
  }
}
