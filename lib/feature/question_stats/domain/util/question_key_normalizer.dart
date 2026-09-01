import 'package:quizzerg/core/utils/answer_parser.dart';

/// Ключ уникального вопроса.
///
/// Формула повторяет серверную (`karto4ki_backend`, колонка `cards.question_key`):
/// `lower(trim(front)) + 0x1F + lower(trim(answers.join('|')))`.
/// Совпадение формул обязательно: по этому ключу агрегируется статистика
/// и на клиенте, и на сервере.
abstract final class QuestionKeyNormalizer {
  /// Разделитель частей ключа (ASCII UNIT SEPARATOR).
  static const separator = '\x1F';

  /// Считает ключ по вопросу и списку вариантов ответа.
  static String normalize(String front, List<String> answers) {
    final normalizedFront = front.trim().toLowerCase();
    final normalizedAnswers = answers.join('|').trim().toLowerCase();
    return '$normalizedFront$separator$normalizedAnswers';
  }

  /// Считает ключ по сырой строке ответов (legacy-формат хранения).
  static String normalizeRaw(String front, String rawAnswers) =>
      normalize(front, AnswerParser.parse(rawAnswers));
}
