import 'package:flutter/material.dart';
import 'package:quizzerg/uikit/progress/wave_progress_bar.dart';
import 'package:quizzerg/uikit/spacing/height.dart';
import 'package:zoloto/zoloto.dart';

/// Полоска анимируется бесконечно (колыхание фронта, бег сегмента), а
/// `zolotoTest` снимает кадр через `pumpAndSettle` — он бы завис. Поэтому
/// golden снимаем в reduced-motion: геометрия, цвета и скругление те же,
/// фронт плоский. Сама анимация покрыта `wave_progress_bar_test.dart`.
Widget _reducedMotion(BuildContext context, {required Widget child}) =>
    MediaQuery(
      data: MediaQuery.of(context).copyWith(disableAnimations: true),
      child: child,
    );

Widget _bar(BuildContext context, double value) => WaveProgressBar(
      value: value,
      color: Theme.of(context).colorScheme.primary,
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
    );

void main() {
  Zoloto.zolotoTest(
    'wave_progress_bar_values',
    widgetBuilder: (context, tester, testCase) => _reducedMotion(
      context,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _bar(context, 0.15),
            const Height(16),
            _bar(context, 0.5),
            const Height(16),
            _bar(context, 0.9),
            const Height(16),
            _bar(context, 1),
          ],
        ),
      ),
    ),
    testHeight: const TestHeight$BasedOnContent(),
  );
}
