import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quizzerg/uikit/progress/wave_fill_painter.dart';
import 'package:quizzerg/uikit/progress/wave_progress_bar.dart';

/// Анимации полоски не доходят до покоя (фронт колышется, сегмент бежит),
/// поэтому вместо golden'а читаем, с какими границами заливки полоска
/// рисуется на конкретном кадре.
WaveFillPainter _painter(WidgetTester tester) {
  final paint = tester.widget<CustomPaint>(
    find.descendant(
      of: find.byType(WaveProgressBar),
      matching: find.byType(CustomPaint),
    ),
  );

  return paint.painter! as WaveFillPainter;
}

Widget _app({double? value, bool isReduced = false}) => MediaQuery(
      data: MediaQueryData(disableAnimations: isReduced),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Center(
          child: SizedBox(
            width: 200,
            child: WaveProgressBar(
              value: value,
              color: const Color(0xFF6750A4),
              backgroundColor: const Color(0xFF1D1B20),
            ),
          ),
        ),
      ),
    );

void main() {
  testWidgets('заливка едет от текущего значения к новому', (tester) async {
    await tester.pumpWidget(_app(value: 0.4));
    expect(_painter(tester).end, closeTo(0.4, 0.001));

    await tester.pumpWidget(_app(value: 0.8));
    await tester.pump(const Duration(milliseconds: 60));
    final mid = _painter(tester).end;
    expect(mid, greaterThan(0.4));
    expect(mid, lessThan(0.8));

    await tester.pump(const Duration(milliseconds: 400));
    expect(_painter(tester).end, closeTo(0.8, 0.001));

    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('при неизвестном прогрессе сегмент бежит по треку',
      (tester) async {
    await tester.pumpWidget(_app());
    await tester.pump(const Duration(milliseconds: 350));
    final first = _painter(tester);
    final firstEnd = first.end;
    expect(first.end - first.start, closeTo(0.3, 0.001));

    await tester.pump(const Duration(milliseconds: 350));
    expect(_painter(tester).end, greaterThan(firstEnd));

    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('reduced-motion: фронт плоский, а неизвестный прогресс '
      'показывается системным индикатором', (tester) async {
    await tester.pumpWidget(_app(value: 0.5, isReduced: true));
    expect(_painter(tester).amplitude, 0);

    await tester.pumpWidget(_app(isReduced: true));
    expect(find.byType(LinearProgressIndicator), findsOneWidget);

    await tester.pumpWidget(const SizedBox.shrink());
  });
}
