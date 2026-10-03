import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:quizzerg/core/services/csv_import_service.dart';

void main() {
  late Directory tempDir;
  const service = CsvImportService();

  setUp(() {
    tempDir = Directory.systemTemp.createTempSync('csv_import_test');
  });

  tearDown(() {
    tempDir.deleteSync(recursive: true);
  });

  Future<List<({String front, String back})>> parse(
    String content,
    String delimiter,
  ) async {
    final file = File('${tempDir.path}/cards.txt')..writeAsStringSync(content);
    final result = await service.parseFiles([file.path], delimiter);
    return switch (result) {
      CsvImportSuccess(:final cards) => cards,
      _ => throw StateError('Unexpected result: $result'),
    };
  }

  for (final (name, eol) in [('LF', '\n'), ('CRLF', '\r\n'), ('CR', '\r')]) {
    test('Каждая строка — отдельная карточка ($name)', () async {
      final cards = await parse(['q1\ta1', 'q2\ta2', 'q3\ta3'].join(eol), '\t');

      expect(cards, [
        (front: 'q1', back: 'a1'),
        (front: 'q2', back: 'a2'),
        (front: 'q3', back: 'a3'),
      ]);
    });
  }

  test('Многострочный ответ в кавычках остаётся одной карточкой', () async {
    final cards = await parse('q1;"a1\na2"\nq2;b1', ';');

    expect(cards, [
      (front: 'q1', back: 'a1\na2'),
      (front: 'q2', back: 'b1'),
    ]);
  });
}
