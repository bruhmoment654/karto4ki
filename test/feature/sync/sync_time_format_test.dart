import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:quizzerg/feature/sync/presentation/sync_time_format.dart';
import 'package:quizzerg/l10n/app_localizations.dart';

void main() {
  late AppLocalizations l10n;

  setUpAll(() async {
    // В приложении символы дат подтягивает GlobalMaterialLocalizations;
    // в юнит-тесте инициализируем их сами.
    await initializeDateFormatting();
    l10n = await AppLocalizations.delegate.load(const Locale('ru'));
  });

  group('SyncTimeFormat.relative', () {
    // Локальное время: подписи считаются разницей, поэтому от таймзоны
    // машины не зависят.
    final now = DateTime(2026, 9, 2, 13, 30);

    String relative(Duration ago) => SyncTimeFormat.relative(
          l10n: l10n,
          lastSyncedAt: now.subtract(ago),
          now: now,
        );

    test('меньше минуты — только что', () {
      expect(relative(const Duration(seconds: 20)), l10n.syncTimeJustNow);
    });

    test('минуты', () {
      expect(relative(const Duration(minutes: 2)), '2 минуты назад');
    });

    test('часы', () {
      expect(relative(const Duration(hours: 5)), '5 часов назад');
    });

    test('дальше суток — абсолютная подпись', () {
      // Относительная подпись в днях бессмысленна: пользователю нужна дата.
      expect(relative(const Duration(days: 3)), contains('13:30'));
    });
  });

  group('SyncTimeFormat.absolute', () {
    final now = DateTime(2026, 9, 2, 13, 30);

    String absolute(DateTime at) =>
        SyncTimeFormat.absolute(l10n: l10n, lastSyncedAt: at, now: now);

    test('сегодня', () {
      expect(absolute(DateTime(2026, 9, 2, 13, 22)), 'сегодня в 13:22');
    });

    test('вчера', () {
      expect(absolute(DateTime(2026, 9, 1, 9, 5)), 'вчера в 09:05');
    });

    test('раньше — дата и время', () {
      final label = absolute(DateTime(2026, 8, 20, 18, 40));

      expect(label, contains('18:40'));
      expect(label, contains('20'));
    });
  });
}
