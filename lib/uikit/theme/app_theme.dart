import 'package:flutter/cupertino.dart' show CupertinoPageTransitionsBuilder;
import 'package:flutter/material.dart';
import 'package:quizzerg/uikit/motion/reduced_motion_page_transitions_builder.dart';
import 'package:quizzerg/uikit/slider/bar_slider_shapes.dart';
import 'package:quizzerg/uikit/theme/app_colors.dart';
import 'package:quizzerg/uikit/theme/palette/app_palette.dart';
import 'package:quizzerg/uikit/theme/palette/seed_palette.dart';

/// Тема Material You (M3 Expressive) для karto4ki / quizzerg.
///
/// Цвета приходят из палитры ([AppPalette]): «Цветной» строит всё из seed
/// (слайдер акцента в настройках), «Монохром» и «AMOLED» — серые с одним
/// акцентом. Здесь только темы компонентов: NavigationBar, Card, FAB, Dialog,
/// FilledButton, SearchBar, Slider — они берут роли схемы и [AppColors],
/// поэтому новая палитра правок здесь не требует.
///
/// Легаси-геттеры [AppThemeColorSchemeX] (card/muted/border/foreground…)
/// отображены на тональные роли M3 и тоже следуют за палитрой.
///
/// Шрифт остаётся Nexa (бренд). Радиусы — см. AppDimens (radius20/28/32).
class AppTheme {
  /// Фиолетовый seed (раньше дефолт был зелёным). Слайдер в настройках его меняет.
  static const defaultSeedColor = Color(0xFF6750A4);

  static ThemeData light({
    Color seedColor = defaultSeedColor,
    AppPalette palette = const SeedPalette(),
  }) =>
      fromPalette(palette, brightness: Brightness.light, accent: seedColor);

  static ThemeData dark({
    Color seedColor = defaultSeedColor,
    AppPalette palette = const SeedPalette(),
  }) =>
      fromPalette(palette, brightness: Brightness.dark, accent: seedColor);

  static ThemeData fromPalette(
    AppPalette palette, {
    required Brightness brightness,
    required Color accent,
  }) {
    final cs = palette.colorScheme(brightness: brightness, accent: accent);

    return _build(cs, palette.appColors(cs));
  }

  static ThemeData _build(ColorScheme cs, AppColors colors) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: cs,
      extensions: [colors],
      scaffoldBackgroundColor: cs.surface,
      fontFamily: 'Nexa',
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: ReducedMotionPageTransitionsBuilder(
            PredictiveBackPageTransitionsBuilder(),
          ),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.windows: ReducedMotionPageTransitionsBuilder(
            ZoomPageTransitionsBuilder(),
          ),
          TargetPlatform.linux: ReducedMotionPageTransitionsBuilder(
            ZoomPageTransitionsBuilder(),
          ),
        },
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: false,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        foregroundColor: cs.onSurface,
      ),
      // M3-навигация снизу (заменяет BottomNavigationBar).
      navigationBarTheme: NavigationBarThemeData(
        height: 80,
        backgroundColor: cs.surfaceContainer,
        indicatorColor: cs.secondaryContainer,
        elevation: 0,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      ),
      cardTheme: CardThemeData(
        color: cs.surfaceContainer,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      // Крупный expressive FAB 64dp, r28; цвет главного действия — из палитры.
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colors.fab,
        foregroundColor: colors.onFab,
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        sizeConstraints: const BoxConstraints.tightFor(width: 64, height: 64),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(0, 40),
          shape: const StadiumBorder(),
          textStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontFamily: 'Nexa',
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: cs.primary,
          textStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontFamily: 'Nexa',
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: cs.primary,
          shape: const StadiumBorder(),
          side: BorderSide(color: cs.outlineVariant),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: cs.surfaceContainerHigh,
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
      ),
      searchBarTheme: SearchBarThemeData(
        backgroundColor: WidgetStatePropertyAll(cs.surfaceContainerHigh),
        elevation: const WidgetStatePropertyAll(0),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        ),
      ),
      sliderTheme: SliderThemeData(
        trackHeight: 16,
        activeTrackColor: cs.primary,
        inactiveTrackColor: cs.secondaryContainer,
        thumbColor: cs.primary,
        // Деления остаются (значение «прилипает» к шагу), но точки не рисуем.
        activeTickMarkColor: Colors.transparent,
        inactiveTickMarkColor: Colors.transparent,
        // Ручка-«пилюля» M3 Expressive: 4×44, вместо круглого thumb.
        thumbShape: const BarSliderThumbShape(),
        rangeThumbShape: const BarRangeSliderThumbShape(),
        // Трек с «вырезом» под ручку (сегменты со скруглёнными концами).
        trackShape: const CutoutSliderTrackShape(),
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 18),
      ),
      dividerTheme: DividerThemeData(color: cs.outlineVariant, thickness: 1),
    );
  }

  /// Конвертация hue (0–360) в seed-цвет для слайдера в настройках.
  static Color seedColorFromHue(double hue) =>
      HSLColor.fromAHSL(1, hue.clamp(0, 360), 0.5, 0.55).toColor();
}

/// Легаси-геттеры палитры, использовавшиеся по экранам, переотображены на
/// реальные тональные роли M3 — старые места вызова (`cs.card`, `cs.muted`,
/// `cs.foreground`…) продолжают работать и следуют за палитрой.
/// В новом коде предпочитай нативные роли. Цвета сверх ролей M3 (`success`,
/// `warning`…) — в [AppColors].
extension AppThemeColorSchemeX on ColorScheme {
  Color get scaffoldBackground => surface;

  Color get card => surfaceContainer;

  Color get muted => surfaceContainerHigh;

  Color get mutedForeground => onSurfaceVariant;

  Color get border => outlineVariant;

  Color get foreground => onSurface;

  Color get secondaryForeground => onSecondaryContainer;

  Color get accent => tertiary;

  /// Пул тональных контейнеров для карточек групп: (container, onContainer).
  /// Стабильный цвет на группу: `pool[group.id % pool.length]`.
  List<(Color, Color)> get groupCardPool => [
        (primaryContainer, onPrimaryContainer),
        (tertiaryContainer, onTertiaryContainer),
        (secondaryContainer, onSecondaryContainer),
      ];
}
