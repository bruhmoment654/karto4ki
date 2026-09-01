/// Пути, которым не нужен `Authorization`.
abstract final class PublicPaths {
  static const _prefixes = ['/auth', '/health'];

  /// Публичный ли путь запроса.
  static bool isPublic(String path) =>
      _prefixes.any((prefix) => path == prefix || path.startsWith('$prefix/'));
}
