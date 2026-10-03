import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quizzerg/feature/settings/presentation/widget/attempt_history_format.dart';
import 'package:quizzerg/feature/test_execution/domain/entity/attempt_history_usage.dart';
import 'package:quizzerg/l10n/app_localizations.dart';

const _nbsp = ' ';

/// Размер истории прохождений в настройках.
///
/// Неразрывные пробелы в ожиданиях заменены обычными через [_plain] —
/// где они стоят, проверяется отдельно.
void main() {
  final ru = lookupAppLocalizations(const Locale('ru'));
  final en = lookupAppLocalizations(const Locale('en'));

  group('размер', () {
    final cases = {
      0: ('0 Б', '0 B'),
      999: ('999 Б', '999 B'),
      1000: ('1 КБ', '1 KB'),
      1250: ('1,3 КБ', '1.3 KB'),
      850000: ('850 КБ', '850 KB'),
      999499: ('999 КБ', '999 KB'),
      999500: ('1 МБ', '1 MB'),
      1200000: ('1,2 МБ', '1.2 MB'),
      12000000: ('12 МБ', '12 MB'),
      12400000: ('12 МБ', '12 MB'),
    };
    for (final MapEntry(key: bytes, value: (inRu, inEn)) in cases.entries) {
      test('$bytes байт', () {
        expect(_plain(AttemptHistoryFormat.size(ru, bytes)), inRu);
        expect(_plain(AttemptHistoryFormat.size(en, bytes)), inEn);
      });
    }

    test('разряды тысяч в мегабайтах', () {
      expect(_plain(AttemptHistoryFormat.size(ru, 1234000000)), '1 234 МБ');
      expect(_plain(AttemptHistoryFormat.size(en, 1234000000)), '1,234 MB');
    });

    test('число не отрывается от единиц', () {
      expect(AttemptHistoryFormat.size(ru, 1200000), '1,2$_nbspМБ');
      expect(AttemptHistoryFormat.size(en, 850000), '850${_nbsp}KB');
    });
  });

  group('строка под заголовком', () {
    test('посчитано по базе', () {
      const usage = AttemptHistoryUsage(bytes: 1200000);

      expect(_plain(AttemptHistoryFormat.usage(ru, usage)), 'Занимает 1,2 МБ');
      expect(_plain(AttemptHistoryFormat.usage(en, usage)), 'Takes up 1.2 MB');
    });

    test('оценка — с «≈», знак не отрывается от числа', () {
      const usage = AttemptHistoryUsage(bytes: 1200000, isEstimate: true);

      expect(
        _plain(AttemptHistoryFormat.usage(ru, usage)),
        'Занимает ≈ 1,2 МБ',
      );
      expect(
        _plain(AttemptHistoryFormat.usage(en, usage)),
        'Takes up ≈ 1.2 MB',
      );
      expect(AttemptHistoryFormat.usage(ru, usage), contains('≈$_nbsp'));
    });

    test('пусто', () {
      expect(
        AttemptHistoryFormat.usage(ru, AttemptHistoryUsage.empty),
        'Пусто',
      );
      expect(
        AttemptHistoryFormat.usage(en, AttemptHistoryUsage.empty),
        'Empty',
      );
    });

    test('размер не посчитался', () {
      expect(AttemptHistoryFormat.usage(ru, null), 'Размер неизвестен');
      expect(AttemptHistoryFormat.usage(en, null), 'Size unknown');
    });
  });
}

String _plain(String value) => value.replaceAll(_nbsp, ' ');
