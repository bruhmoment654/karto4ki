import 'package:flutter/material.dart';
import 'package:quizzerg/uikit/slider/hue_slider.dart';
import 'package:quizzerg/uikit/spacing/height.dart';
import 'package:zoloto/zoloto.dart';

/// Слайдер лежит на карточке настроек — подложка того же цвета, что обводка
/// ручки. Крайние значения проверяют, что ручка выходит за трек наполовину.
void main() {
  Zoloto.zolotoTest(
    'hue_slider_values',
    widgetBuilder: (context, tester, testCase) => ColoredBox(
      color: Theme.of(context).colorScheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final hue in const [0.0, 120.0, 280.0, 360.0]) ...[
              HueSlider(hue: hue, onChanged: (_) {}),
              const Height(12),
            ],
            const HueSlider(hue: 200, onChanged: null),
          ],
        ),
      ),
    ),
    testHeight: const TestHeight$BasedOnContent(),
  );
}
