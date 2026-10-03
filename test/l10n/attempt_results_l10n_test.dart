import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quizzerg/l10n/app_localizations.dart';

const _nbsp = '\u00A0';
const _minus = '\u2212';

/// Строки экрана результата и карточки «Продолжить тест» с подстановками.
///
/// Неразрывные пробелы в ожиданиях заменены обычными через [_plain] —
/// где они стоят, проверяется отдельно.
void main() {
  final ru = lookupAppLocalizations(const Locale('ru'));
  final en = lookupAppLocalizations(const Locale('en'));

  group('дельта с прошлым разом', () {
    test('рост — «к прошлому разу»', () {
      expect(_plain(ru.tinderTestResultsDeltaUp(20)), '+20% к прошлому разу');
      expect(_plain(en.tinderTestResultsDeltaUp(20)), '+20% vs last time');
    });

    test('падение — «от прошлого раза»', () {
      expect(
        _plain(ru.tinderTestResultsDeltaDown(100)),
        '${_minus}100% от прошлого раза',
      );
      expect(
        _plain(ru.tinderTestResultsDeltaDown(1)),
        '${_minus}1% от прошлого раза',
      );
      expect(
        _plain(en.tinderTestResultsDeltaDown(5)),
        '${_minus}5% vs last time',
      );
    });

    test('падение — типографский минус, а не дефис', () {
      expect(ru.tinderTestResultsDeltaDown(100), isNot(contains('-')));
      expect(en.tinderTestResultsDeltaDown(100), isNot(contains('-')));
    });

    test('без изменений — словами, а не «+0%»', () {
      expect(_plain(ru.tinderTestResultsDeltaSame), 'Как в прошлый раз');
      expect(en.tinderTestResultsDeltaSame, 'Same as last time');
    });

    test('переносится только после процента', () {
      expect(ru.tinderTestResultsDeltaUp(20), '+20% к$_nbspпрошлому$_nbspразу');
      expect(
        ru.tinderTestResultsDeltaDown(20),
        '${_minus}20% от$_nbspпрошлого$_nbspраза',
      );
    });
  });

  group('«N из M карточек» — склонение по M', () {
    final cases = {
      (24, 70): '24 из 70 карточек',
      (0, 1): '0 из 1 карточки',
      (1, 2): '1 из 2 карточек',
      (5, 5): '5 из 5 карточек',
      (3, 11): '3 из 11 карточек',
      (0, 12): '0 из 12 карточек',
      (0, 21): '0 из 21 карточки',
      (2, 22): '2 из 22 карточек',
      (0, 101): '0 из 101 карточки',
      (0, 111): '0 из 111 карточек',
    };
    for (final MapEntry(key: (current, total), value: expected)
        in cases.entries) {
      test('ru $current/$total', () {
        expect(
          _plain(ru.groupsListActiveSessionCards(current, total)),
          expected,
        );
      });
    }

    test('en: единственное и множественное', () {
      expect(_plain(en.groupsListActiveSessionCards(0, 1)), '0 of 1 card');
      expect(_plain(en.groupsListActiveSessionCards(2, 5)), '2 of 5 cards');
    });

    test('число не отрывается от слова', () {
      expect(ru.groupsListActiveSessionCards(24, 70), '24 из 70$_nbspкарточек');
    });
  });

  test('счётчик прохождений', () {
    expect(ru.tinderTestResultsAttemptsCount(5, 12), '5 из 12');
    expect(en.tinderTestResultsAttemptsCount(5, 12), '5 of 12');
  });

  test('заглушка динамики: тире не начинает строку', () {
    expect(
      ru.tinderTestResultsDynamicsPlaceholderSubtitle,
      contains('раз$_nbsp— сравним'),
    );
  });
}

String _plain(String value) => value.replaceAll(_nbsp, ' ');
