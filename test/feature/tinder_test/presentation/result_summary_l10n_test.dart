import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quizzerg/feature/test_execution/domain/entity/attempt_summary.dart';
import 'package:quizzerg/feature/test_execution/domain/entity/test_attempt_entity.dart';
import 'package:quizzerg/feature/tinder_test/presentation/widget/results/attempts_chart_card.dart';
import 'package:quizzerg/feature/tinder_test/presentation/widget/results/result_summary_header.dart';
import 'package:quizzerg/l10n/app_localizations.dart';
import 'package:quizzerg/uikit/theme/app_theme.dart';

TestAttemptEntity _attempt(int day, int correct) => TestAttemptEntity(
  id: 'attempt-$day',
  testId: 'test',
  startedAt: DateTime(2026, 9, day, 12),
  completedAt: DateTime(2026, 9, day, 12, 5),
  total: 10,
  correct: correct,
);

AttemptSummary _summary(List<TestAttemptEntity> attempts) => AttemptSummary(
  recentAttempts: attempts,
  totalAttempts: attempts.length,
  questions: const [],
);

Future<void> _pump(WidgetTester tester, Widget child, {String locale = 'ru'}) =>
    tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.dark(),
        locale: Locale(locale),
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        // Кольцо колышется бесконечно — в reduced-motion оно стоит.
        home: Builder(
          builder: (context) => MediaQuery(
            data: MediaQuery.of(context).copyWith(disableAnimations: true),
            child: Scaffold(body: child),
          ),
        ),
      ),
    );

/// Текст чипа под заголовком сводки, с обычными пробелами вместо
/// неразрывных.
String _chipText(WidgetTester tester) => tester
    .widgetList<Text>(find.byType(Text))
    .map((text) => text.data ?? '')
    .lastWhere((data) => data.isNotEmpty)
    .replaceAll('\u00A0', ' ');

void main() {
  group('чип сводки', () {
    Future<String> chipFor(
      WidgetTester tester,
      List<TestAttemptEntity> attempts,
    ) async {
      await _pump(
        tester,
        ResultSummaryHeader(
          correct: attempts.last.correct,
          total: 10,
          summary: _summary(attempts),
        ),
      );
      await tester.pump();
      return _chipText(tester);
    }

    testWidgets('рост', (tester) async {
      expect(
        await chipFor(tester, [_attempt(1, 7), _attempt(2, 9)]),
        '+20% к прошлому разу',
      );
    });

    testWidgets('падение до нуля', (tester) async {
      expect(
        await chipFor(tester, [_attempt(1, 10), _attempt(2, 0)]),
        '\u2212100% от прошлого раза',
      );
    });

    testWidgets('без изменений', (tester) async {
      expect(
        await chipFor(tester, [_attempt(1, 7), _attempt(2, 7)]),
        'Как в прошлый раз',
      );
    });

    testWidgets('первое прохождение', (tester) async {
      expect(await chipFor(tester, [_attempt(2, 7)]), 'Первое прохождение');
    });
  });

  group('заголовок — по проценту на кольце', () {
    final cases = {
      (179, 200): ('90%', 'Отличный результат!'),
      (178, 200): ('89%', 'Хорошая работа!'),
      (119, 200): ('60%', 'Хорошая работа!'),
      (118, 200): ('59%', 'Есть над чем поработать'),
      (0, 10): ('0%', 'Есть над чем поработать'),
      (10, 10): ('100%', 'Отличный результат!'),
    };
    for (final MapEntry(key: (correct, total), value: (percent, title))
        in cases.entries) {
      testWidgets('$correct из $total → $percent, «$title»', (tester) async {
        await _pump(
          tester,
          ResultSummaryHeader(correct: correct, total: total, summary: null),
        );
        await tester.pump();

        expect(find.text(percent), findsOneWidget);
        expect(find.text(title), findsOneWidget);
      });
    }
  });

  group('даты под графиком — по локали', () {
    final summary = _summary([
      _attempt(12, 5),
      _attempt(18, 6),
      _attempt(24, 7),
    ]);

    testWidgets('ru: день.месяц', (tester) async {
      await _pump(tester, AttemptsChartCard(summary: summary));
      await tester.pump();

      expect(find.text('12.09'), findsOneWidget);
      expect(find.text('18.09'), findsOneWidget);
      expect(find.text('сейчас'), findsOneWidget);
    });

    testWidgets('en: месяц/день', (tester) async {
      await _pump(tester, AttemptsChartCard(summary: summary), locale: 'en');
      await tester.pump();

      expect(find.text('9/12'), findsOneWidget);
      expect(find.text('9/18'), findsOneWidget);
      expect(find.text('now'), findsOneWidget);
    });
  });
}
