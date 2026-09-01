import 'package:flutter_test/flutter_test.dart';
import 'package:quizzerg/core/utils/answers_codec.dart';

void main() {
  group('AnswersCodec', () {
    test('кодирует в JSON-массив', () {
      expect(AnswersCodec.encode(['a', 'b']), '["a","b"]');
    });

    test('выбрасывает пустые варианты', () {
      expect(AnswersCodec.encode(['a', '  ', 'b']), '["a","b"]');
    });

    test('декодирует JSON-массив', () {
      expect(AnswersCodec.decode('["a","b"]'), ['a', 'b']);
    });

    test('декодирует legacy-строку с разделителем', () {
      expect(AnswersCodec.decode('кот | кошка'), ['кот', 'кошка']);
    });

    test('пустое значение даёт пустой список', () {
      expect(AnswersCodec.decode(''), isEmpty);
    });

    test('не более трёх вариантов', () {
      expect(AnswersCodec.decode('["a","b","c","d"]'), ['a', 'b', 'c']);
    });

    test('битый JSON разбирается как legacy-строка', () {
      expect(AnswersCodec.decode('[неполный'), ['[неполный']);
    });
  });
}
