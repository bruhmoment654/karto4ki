import 'package:flutter/material.dart';
import 'package:quizzerg/feature/settings/presentation/widget/color_style_picker.dart';
import 'package:quizzerg/persistence/settings/data/settings_dto.dart';
import 'package:quizzerg/uikit/spacing/height.dart';
import 'package:quizzerg/uikit/theme/app_theme.dart';
import 'package:zoloto/zoloto.dart';

/// Превью строится из палитры стиля с текущим акцентом: при смене оттенка
/// меняются полосы цветного стиля и точка акцента у всех.
void main() {
  Zoloto.zolotoTest(
    'color_style_picker',
    widgetBuilder: (context, tester, testCase) => ColoredBox(
      color: Theme.of(context).colorScheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final style in AppColorStyle.values) ...[
              ColorStylePicker(
                value: style,
                accent: AppTheme.defaultSeedColor,
                onChanged: (_) {},
              ),
              const Height(16),
            ],
            ColorStylePicker(
              value: AppColorStyle.colorful,
              accent: AppTheme.seedColorFromHue(150),
              onChanged: (_) {},
            ),
          ],
        ),
      ),
    ),
    testHeight: const TestHeight$BasedOnContent(),
  );
}
