import 'package:flutter/material.dart';
import 'package:quizzerg/uikit/theme/palette/monochrome_palette.dart';

/// «AMOLED» — монохром с чисто чёрным фоном и нижними поверхностями.
///
/// Меняет только тёмную тему: в светлой это обычный монохром.
class AmoledPalette extends MonochromePalette {
  const AmoledPalette();

  @override
  ColorScheme colorScheme({
    required Brightness brightness,
    required Color accent,
  }) {
    final scheme = super.colorScheme(brightness: brightness, accent: accent);
    if (brightness == Brightness.light) return scheme;

    return scheme.copyWith(
      surface: const Color(0xFF000000),
      surfaceDim: const Color(0xFF000000),
      surfaceContainerLowest: const Color(0xFF000000),
      surfaceContainerLow: const Color(0xFF000000),
      surfaceContainer: const Color(0xFF121212),
      surfaceContainerHigh: const Color(0xFF1C1C1D),
      surfaceContainerHighest: const Color(0xFF262627),
      primaryContainer: const Color(0xFF1C1C1D),
      secondaryContainer: const Color(0xFF2A2A2C),
      tertiaryContainer: const Color(0xFF1C1C1D),
      outlineVariant: const Color(0xFF262627),
    );
  }
}
