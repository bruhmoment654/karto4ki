import 'package:flutter_test/flutter_test.dart';
import 'package:quizzerg/feature/question_stats/domain/util/question_key_normalizer.dart';

void main() {
  group('QuestionKeyNormalizer', () {
    test('повторяет серверную формулу', () {
      expect(
        QuestionKeyNormalizer.normalize('Столица Франции?', ['Париж']),
        'столица франции?\x1Fпариж',
      );
    });

    test('склеивает варианты через | без пробелов', () {
      expect(
        QuestionKeyNormalizer.normalize('Кот', ['cat', 'kitty']),
        'кот\x1Fcat|kitty',
      );
    });

    test('обрезает края, но не схлопывает внутренние пробелы', () {
      expect(
        QuestionKeyNormalizer.normalize('  A  B  ', [' x ']),
        'a  b\x1Fx',
      );
    });

    test('normalizeRaw разбирает legacy-строку ответов', () {
      expect(
        QuestionKeyNormalizer.normalizeRaw('Кот', 'cat | kitty'),
        QuestionKeyNormalizer.normalize('Кот', ['cat', 'kitty']),
      );
    });

    test('одинаковый вопрос в разных тестах даёт один ключ', () {
      expect(
        QuestionKeyNormalizer.normalize('2+2', ['4']),
        QuestionKeyNormalizer.normalize('  2+2 ', ['4  ']),
      );
    });
  });
}
