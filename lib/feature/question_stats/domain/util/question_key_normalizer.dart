abstract final class QuestionKeyNormalizer {
  static const _separator = '\x1F';

  static String normalize(String front, String back) {
    return '${_normalizeText(front)}$_separator${_normalizeText(back)}';
  }

  static String _normalizeText(String text) {
    return text.trim().replaceAll(RegExp(r'\s+'), ' ').toLowerCase();
  }
}
