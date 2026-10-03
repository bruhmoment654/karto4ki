import 'package:flutter/material.dart';
import 'package:quizzerg/uikit/theme/app_colors.dart';
import 'package:quizzerg/uikit/theme/palette/app_palette.dart';

/// «Цветной» стиль — нативный Material You: вся палитра строится
/// [ColorScheme.fromSeed] из акцента.
///
/// В светлой теме поверхности нейтральные (решение дизайна — вместо
/// тонированного в seed дефолта `#FEF7FF`), в тёмной — тональные из seed.
class SeedPalette extends AppPalette {
  const SeedPalette();

  @override
  ColorScheme colorScheme({
    required Brightness brightness,
    required Color accent,
  }) {
    final scheme = ColorScheme.fromSeed(
      seedColor: accent,
      brightness: brightness,
    );
    if (brightness == Brightness.dark) return scheme;

    return scheme.copyWith(
      surface: const Color(0xFFFCFCFD),
      surfaceContainerLowest: const Color(0xFFFFFFFF),
      surfaceContainerLow: const Color(0xFFF6F5F8),
      surfaceContainer: const Color(0xFFF1F0F4),
      surfaceContainerHigh: const Color(0xFFEBEAEF),
      surfaceContainerHighest: const Color(0xFFE5E4EA),
    );
  }

  @override
  AppColors appColors(ColorScheme scheme) {
    final isDark = scheme.brightness == Brightness.dark;
    final success = isDark ? const Color(0xFF7CD992) : const Color(0xFF146C2E);
    final warning = isDark ? const Color(0xFFF6C45A) : const Color(0xFF7E5700);

    return AppColors(
      success: success,
      onSuccess: isDark ? const Color(0xFF00391B) : const Color(0xFFFFFFFF),
      warning: warning,
      info: isDark ? const Color(0xFFA7C8FF) : const Color(0xFF2B5A9B),
      fab: scheme.primaryContainer,
      onFab: scheme.onPrimaryContainer,
      // На светлой теме семантические роли подобраны под мелкий текст и
      // на крупных числах и полосах смотрятся блёкло — берём ярче.
      accuracyHigh: isDark ? success : const Color(0xFF15A34A),
      accuracyMid: isDark ? warning : const Color(0xFFF59E0B),
      accuracyLow: isDark ? scheme.error : const Color(0xFFE5342B),
    );
  }
}
