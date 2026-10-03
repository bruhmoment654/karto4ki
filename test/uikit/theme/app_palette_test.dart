import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quizzerg/persistence/settings/data/settings_dto.dart';
import 'package:quizzerg/uikit/theme/app_colors.dart';
import 'package:quizzerg/uikit/theme/app_theme.dart';
import 'package:quizzerg/uikit/theme/app_theme_scope.dart';
import 'package:quizzerg/uikit/theme/palette/amoled_palette.dart';
import 'package:quizzerg/uikit/theme/palette/monochrome_palette.dart';
import 'package:quizzerg/uikit/theme/palette/seed_palette.dart';

const _purple = Color(0xFF6750A4);
const _green = Color(0xFF2E7D32);
const _black = Color(0xFF000000);

/// Цвет без оттенка: каналы почти равны.
bool _isNeutral(Color color) {
  final channels = [color.r, color.g, color.b]..sort();

  return channels.last - channels.first < 0.02;
}

void main() {
  group('палитра по стилю', () {
    test('каждому стилю — своя палитра', () {
      expect(
        AppThemeScope.paletteOf(AppColorStyle.colorful),
        isA<SeedPalette>(),
      );
      expect(
        AppThemeScope.paletteOf(AppColorStyle.monochrome),
        isA<MonochromePalette>(),
      );
      expect(
        AppThemeScope.paletteOf(AppColorStyle.amoled),
        isA<AmoledPalette>(),
      );
    });
  });

  for (final brightness in Brightness.values) {
    group('монохром, ${brightness.name}', () {
      final scheme = const MonochromePalette().colorScheme(
        brightness: brightness,
        accent: _purple,
      );
      final colors = const MonochromePalette().appColors(scheme);

      test('контейнеры и поверхности серые', () {
        for (final color in [
          scheme.surface,
          scheme.surfaceContainerLow,
          scheme.surfaceContainer,
          scheme.surfaceContainerHigh,
          scheme.surfaceContainerHighest,
          scheme.primaryContainer,
          scheme.secondaryContainer,
          scheme.tertiaryContainer,
          scheme.outlineVariant,
          colors.success,
          colors.warning,
          colors.info,
        ]) {
          expect(_isNeutral(color), isTrue, reason: '$color');
        }
      });

      test('акцент цветной и следует за seed', () {
        final green = const MonochromePalette().colorScheme(
          brightness: brightness,
          accent: _green,
        );

        expect(_isNeutral(scheme.primary), isFalse);
        expect(green.primary, isNot(scheme.primary));
        expect(green.secondaryContainer, scheme.secondaryContainer);
      });

      test('FAB на акценте, ошибка красная', () {
        expect(colors.fab, scheme.primary);
        expect(_isNeutral(scheme.error), isFalse);
      });
    });
  }

  group('AMOLED', () {
    test('тёмная — чёрный фон', () {
      final scheme = const AmoledPalette().colorScheme(
        brightness: Brightness.dark,
        accent: _purple,
      );

      expect(scheme.surface, _black);
      expect(scheme.surfaceContainerLow, _black);
    });

    test('светлая — как монохром', () {
      final amoled = const AmoledPalette().colorScheme(
        brightness: Brightness.light,
        accent: _purple,
      );
      final mono = const MonochromePalette().colorScheme(
        brightness: Brightness.light,
        accent: _purple,
      );

      expect(amoled, mono);
    });
  });

  group('тема', () {
    test('AppColors палитры лежит в ThemeData', () {
      final theme = AppTheme.dark(palette: const MonochromePalette());

      expect(theme.extension<AppColors>(), isNotNull);
      expect(theme.appColors.fab, theme.colorScheme.primary);
      expect(
        theme.floatingActionButtonTheme.backgroundColor,
        theme.colorScheme.primary,
      );
    });

    test('цветной стиль — FAB на primaryContainer', () {
      final theme = AppTheme.light();

      expect(
        theme.floatingActionButtonTheme.backgroundColor,
        theme.colorScheme.primaryContainer,
      );
    });
  });
}
