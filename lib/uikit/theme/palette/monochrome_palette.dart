import 'package:flutter/material.dart';
import 'package:quizzerg/uikit/theme/app_colors.dart';
import 'package:quizzerg/uikit/theme/palette/app_palette.dart';

/// «Монохром» — шкала серого и один акцент из слайдера.
///
/// Акцент только на главном: filled-кнопки, FAB, активный переключатель,
/// прогресс. Контейнеры, карточки групп, навбар и чипы — серые. `error`
/// остаётся красным, чтобы ошибки не терялись; `success`, `warning` и
/// `info` сведены к нейтральным тонам.
class MonochromePalette extends AppPalette {
  const MonochromePalette();

  @override
  ColorScheme colorScheme({
    required Brightness brightness,
    required Color accent,
  }) {
    // vibrant — акцент должен выделяться на сером, приглушённый tonalSpot
    // теряется.
    final accentScheme = ColorScheme.fromSeed(
      seedColor: accent,
      brightness: brightness,
      dynamicSchemeVariant: DynamicSchemeVariant.vibrant,
    );
    final base = brightness == Brightness.dark ? _dark : _light;

    return base.copyWith(
      primary: accentScheme.primary,
      onPrimary: accentScheme.onPrimary,
      inversePrimary: accentScheme.inversePrimary,
    );
  }

  @override
  AppColors appColors(ColorScheme scheme) {
    final isDark = scheme.brightness == Brightness.dark;
    final neutral = isDark ? const Color(0xFFE3E3E5) : const Color(0xFF2A2A2C);

    return AppColors(
      success: isDark ? const Color(0xFFE8E8EA) : const Color(0xFF2A2A2C),
      onSuccess: isDark ? const Color(0xFF121212) : const Color(0xFFFFFFFF),
      warning: neutral,
      info: neutral,
      fab: scheme.primary,
      onFab: scheme.onPrimary,
      accuracyHigh: scheme.onSurface,
      accuracyMid: scheme.onSurfaceVariant,
      accuracyLow: scheme.error,
      cardInk: scheme.primary,
    );
  }

  /// `primary`, `onPrimary` и `inversePrimary` заменяются акцентом.
  static const _dark = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFFC9B8FF),
    onPrimary: Color(0xFF1B1033),
    primaryContainer: Color(0xFF2E2E30),
    onPrimaryContainer: Color(0xFFEDEDED),
    secondary: Color(0xFFC6C6C8),
    onSecondary: Color(0xFF1A1A1B),
    secondaryContainer: Color(0xFF3A3A3C),
    onSecondaryContainer: Color(0xFFF2F2F2),
    tertiary: Color(0xFFD6D6D8),
    onTertiary: Color(0xFF1A1A1B),
    tertiaryContainer: Color(0xFF333335),
    onTertiaryContainer: Color(0xFFEDEDED),
    error: Color(0xFFFF8A80),
    onError: Color(0xFF3A0A07),
    errorContainer: Color(0xFF4A1F1C),
    onErrorContainer: Color(0xFFFFDAD6),
    surface: Color(0xFF121212),
    onSurface: Color(0xFFEDEDED),
    onSurfaceVariant: Color(0xFFA8A8AC),
    surfaceDim: Color(0xFF121212),
    surfaceBright: Color(0xFF38383A),
    surfaceContainerLowest: Color(0xFF0C0C0C),
    surfaceContainerLow: Color(0xFF181818),
    surfaceContainer: Color(0xFF1E1E1F),
    surfaceContainerHigh: Color(0xFF282829),
    surfaceContainerHighest: Color(0xFF333335),
    outline: Color(0xFF8A8A8E),
    outlineVariant: Color(0xFF3A3A3C),
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
    inverseSurface: Color(0xFFEDEDED),
    onInverseSurface: Color(0xFF1E1E1F),
    inversePrimary: Color(0xFF5B3FD0),
    // Тонировка приподнятых поверхностей акцентом окрасила бы серый.
    surfaceTint: Color(0x00000000),
  );

  static const _light = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF5B3FD0),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFEEEEEF),
    onPrimaryContainer: Color(0xFF1A1A1B),
    secondary: Color(0xFF5E5E62),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFE2E2E4),
    onSecondaryContainer: Color(0xFF1A1A1B),
    tertiary: Color(0xFF4A4A4E),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFE8E8EA),
    onTertiaryContainer: Color(0xFF1A1A1B),
    error: Color(0xFFC62828),
    onError: Color(0xFFFFFFFF),
    errorContainer: Color(0xFFFCE4E2),
    onErrorContainer: Color(0xFF410E0B),
    surface: Color(0xFFFFFFFF),
    onSurface: Color(0xFF1A1A1B),
    onSurfaceVariant: Color(0xFF5E5E62),
    surfaceDim: Color(0xFFDCDCDE),
    surfaceBright: Color(0xFFFFFFFF),
    surfaceContainerLowest: Color(0xFFFFFFFF),
    surfaceContainerLow: Color(0xFFF7F7F8),
    surfaceContainer: Color(0xFFF2F2F3),
    surfaceContainerHigh: Color(0xFFEBEBEC),
    surfaceContainerHighest: Color(0xFFE4E4E6),
    outline: Color(0xFF7A7A7E),
    outlineVariant: Color(0xFFD4D4D6),
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
    inverseSurface: Color(0xFF2A2A2C),
    onInverseSurface: Color(0xFFF2F2F3),
    inversePrimary: Color(0xFFC9B8FF),
    surfaceTint: Color(0x00000000),
  );
}
