/// Утилита для парсинга и форматирования множественных вариантов ответа.
abstract final class AnswerParser {
  static final _parenthesesPattern = RegExp(r'^(.+?)\s*\((.+?)\)$');

  /// Парсит строку ответов.
  /// Поддерживаемые форматы:
  /// - `"a | b | c"` — основной формат через `|`
  /// - `"a // b // c"` — альтернативный формат через `//`
  /// - `"a (b)"` — старый формат со скобками
  /// - `"a - b"` — старый формат с дефисом
  /// Пустые варианты отбрасываются. Максимум 3.
  static List<String> parse(String raw) {
    if (raw.contains('|')) {
      return raw
          .split('|')
          .map((it) => it.trim())
          .where((it) => it.isNotEmpty)
          .take(3)
          .toList();
    }

    if (raw.contains('//')) {
      return raw
          .split('//')
          .map((it) => it.trim())
          .where((it) => it.isNotEmpty)
          .take(3)
          .toList();
    }

    final match = _parenthesesPattern.firstMatch(raw);
    if (match case final RegExpMatch re) {
      final main = re.group(1);
      final alt = re.group(2);
      if (main != null && alt != null) {
        return [main.trim(), alt.trim()];
      }
    }

    if (raw.contains(' - ')) {
      return raw
          .split(' - ')
          .map((it) => it.trim())
          .where((it) => it.isNotEmpty)
          .take(3)
          .toList();
    }

    return [raw.trim()];
  }

  /// Собирает список ответов обратно в строку для хранения в БД.
  static String format(List<String> answers) {
    return answers.join(' | ');
  }
}
