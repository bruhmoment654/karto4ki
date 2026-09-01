import 'dart:convert';

import 'package:quizzerg/core/utils/answer_parser.dart';

/// Кодек хранения вариантов ответа в колонке `cards.answers`.
///
/// Формат — JSON-массив строк (как в API). Умеет читать и legacy-строку
/// `"a | b"`, чтобы данные, пришедшие из старой схемы или из импорта,
/// не терялись.
abstract final class AnswersCodec {
  /// Кодирует варианты ответа в JSON-массив.
  static String encode(List<String> answers) => jsonEncode(
        answers.map((it) => it.trim()).where((it) => it.isNotEmpty).toList(),
      );

  /// Декодирует значение колонки в варианты ответа.
  static List<String> decode(String raw) {
    if (raw.isEmpty) return const [];

    if (raw.startsWith('[')) {
      try {
        final decoded = jsonDecode(raw);
        if (decoded is List) {
          return decoded
              .map((it) => it.toString().trim())
              .where((it) => it.isNotEmpty)
              .take(3)
              .toList();
        }
      } on FormatException {
        // Не JSON — разбираем как legacy-строку ниже.
      }
    }

    return AnswerParser.parse(raw);
  }
}
