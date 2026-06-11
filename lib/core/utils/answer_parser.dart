/// Утилита для парсинга и форматирования множественных вариантов ответа.
abstract final class AnswerParser {
  static final _parenthesesPattern = RegExp(r'^(.+?)\s*\((.+?)\)$');

  /// Все виды переносов строк: `\r\n`, `\r`, NEL (U+0085), LS (U+2028), PS (U+2029).
  static final _newlinePattern = RegExp('\r\n|[\r  ]');

  /// Нормализует все виды переносов строк к `\n`.
  static String normalizeNewlines(String s) => s.replaceAll(_newlinePattern, '\n');

  /// Парсит строку ответов.
  /// Поддерживаемые форматы:
  /// - `"a | b | c"` — основной формат через `|`
  /// - `"a // b // c"` — альтернативный формат через `//`
  /// - `"a\nb\nc"` — варианты, разделённые переносом строки (любая кодировка:
  ///   `\n`, `\r\n`, `\r`, NEL, LS, PS)
  /// - `"a (b)"` — старый формат со скобками
  /// - `"a - b"` — старый формат с дефисом
  /// Пустые варианты отбрасываются. Максимум 3.
  static List<String> parse(String raw) {
    final normalized = normalizeNewlines(raw);

    if (normalized.contains('|')) {
      return normalized
          .split('|')
          .map((it) => it.trim())
          .where((it) => it.isNotEmpty)
          .take(3)
          .toList();
    }

    if (normalized.contains('//')) {
      return normalized
          .split('//')
          .map((it) => it.trim())
          .where((it) => it.isNotEmpty)
          .take(3)
          .toList();
    }

    if (normalized.contains('\n')) {
      final parts = normalized
          .split('\n')
          .map((it) => it.trim())
          .where((it) => it.isNotEmpty)
          .take(3)
          .toList();
      if (parts.length > 1) return parts;
    }

    final match = _parenthesesPattern.firstMatch(normalized);
    if (match case final RegExpMatch re) {
      final main = re.group(1);
      final alt = re.group(2);
      if (main != null && alt != null) {
        return [main.trim(), alt.trim()];
      }
    }

    if (normalized.contains(' - ')) {
      return normalized
          .split(' - ')
          .map((it) => it.trim())
          .where((it) => it.isNotEmpty)
          .take(3)
          .toList();
    }

    return [normalized.trim()];
  }

  /// Собирает список ответов обратно в строку для хранения в БД.
  static String format(List<String> answers) {
    return answers.join(' | ');
  }
}
