import 'package:flutter/material.dart';

import 'package:quizzerg/uikit/theme/app_colors.dart';

class AppTheme {
  static const defaultSeedColor = Color.fromARGB(255, 35, 255, 142);

  static ThemeData light({Color seedColor = defaultSeedColor}) {
    const colors = AppColorsLight();
    final colorScheme = ColorScheme.fromSeed(
      seedColor: seedColor,
    ).copyWith(
      primary: colors.primary,
      secondary: colors.secondary,
      surface: colors.card,
      error: colors.destructive,
      outline: colors.border,
    );

    return _buildThemeData(colorScheme, colors);
  }

  static ThemeData dark({Color seedColor = defaultSeedColor}) {
    const colors = AppColorsDark();
    final colorScheme = ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: Brightness.dark,
    ).copyWith(
      primary: colors.primary,
      secondary: colors.secondary,
      surface: colors.card,
      error: colors.destructive,
      outline: colors.border,
    );

    return _buildThemeData(colorScheme, colors);
  }

  static ThemeData _buildThemeData(ColorScheme colorScheme, AppColors colors) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colors.background,
      fontFamily: 'Nexa',
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        foregroundColor: colorScheme.onSurface,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: colorScheme.onPrimary,
          backgroundColor: colorScheme.primary,
          textStyle: const TextStyle(fontWeight: FontWeight.w600),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorScheme.primary,
          textStyle: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.transparent,
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: colorScheme.onSurfaceVariant,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
    );
  }

  /// Конвертация hue (0–360) в Color с фиксированной насыщенностью и светлостью.
  static Color seedColorFromHue(double hue) {
    return HSLColor.fromAHSL(1, hue.clamp(0, 360), 1, 0.57).toColor();
  }

  static const dividerColor = Color(0xFF2A2A2A);
}

extension AppThemeColorSchemeX on ColorScheme {
  bool get _isDark => brightness == Brightness.dark;

  AppColors get _colors =>
      _isDark ? const AppColorsDark() : const AppColorsLight();

  Color get scaffoldBackground => _colors.background;

  Color get success => _colors.success;

  Color get info => const Color(0xFF42A5F5);

  Color get muted => _colors.muted;

  Color get mutedForeground => _colors.mutedForeground;

  Color get accent => _colors.accent;

  Color get warning => _colors.warning;

  Color get card => _colors.card;

  Color get border => _colors.border;

  Color get foreground => _colors.foreground;

  Color get secondaryForeground => _colors.secondaryForeground;
}
