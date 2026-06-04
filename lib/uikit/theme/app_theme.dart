import 'package:flutter/material.dart';
import 'package:quizzerg/uikit/slider/bar_slider_shapes.dart';

/// Тема Material You (M3 Expressive) для karto4ki / quizzerg.
///
/// Ключевые отличия от прежней реализации:
///   1. НЕ перекрывает primary/secondary/tertiary — их генерит
///      [ColorScheme.fromSeed] по seed-цвету, поэтому слайдер seed в профиле
///      (accentColorHue) реально перекрашивает всё приложение (нативный
///      Material You).
///   2. Перекрывает только рампу surface (чистый нейтральный белый в light)
///      и error.
///   3. Добавляет M3-темы компонентов: NavigationBar, Card, FAB, Dialog,
///      FilledButton, SearchBar, Slider.
///   4. Легаси-геттеры [AppThemeColorSchemeX] (card/muted/border/foreground…)
///      переотображены на реальные тональные роли M3 — старые экраны
///      продолжают компилироваться и подхватывают цвета, реагирующие на seed.
///
/// Шрифт остаётся Nexa (бренд). Радиусы — см. AppDimens (radius20/28/32).
class AppTheme {
  /// Фиолетовый seed (раньше дефолт был зелёным). Слайдер в профиле его меняет.
  static const defaultSeedColor = Color(0xFF6750A4);

  static ThemeData light({Color seedColor = defaultSeedColor}) =>
      _build(_scheme(seedColor, Brightness.light), Brightness.light);

  static ThemeData dark({Color seedColor = defaultSeedColor}) =>
      _build(_scheme(seedColor, Brightness.dark), Brightness.dark);

  static ColorScheme _scheme(Color seed, Brightness brightness) {
    // tonalSpot — дефолтный вариант M3; surface ниже де-тонируем для light.
    final scheme = ColorScheme.fromSeed(
      seedColor: seed,
      brightness: brightness,
    );
    // Чистые, де-тонированные нейтральные поверхности для LIGHT (решение
    // дизайна — вместо тонированного в seed дефолта #FEF7FF). В dark остаются
    // тональные поверхности fromSeed.
    if (brightness == Brightness.light) {
      return scheme.copyWith(
        surface: const Color(0xFFFCFCFD),
        surfaceContainerLowest: const Color(0xFFFFFFFF),
        surfaceContainerLow: const Color(0xFFF6F5F8),
        surfaceContainer: const Color(0xFFF1F0F4),
        surfaceContainerHigh: const Color(0xFFEBEAEF),
        surfaceContainerHighest: const Color(0xFFE5E4EA),
      );
    }
    return scheme;
  }

  static ThemeData _build(ColorScheme cs, Brightness brightness) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: cs,
      scaffoldBackgroundColor: cs.surface,
      fontFamily: 'Nexa',
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
      // Крупный expressive FAB 64dp, r28, тональный primaryContainer.
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: cs.primaryContainer,
        foregroundColor: cs.onPrimaryContainer,
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

  /// Конвертация hue (0–360) в seed-цвет для слайдера в профиле.
  static Color seedColorFromHue(double hue) =>
      HSLColor.fromAHSL(1, hue.clamp(0, 360), 0.5, 0.55).toColor();
}

/// Легаси-геттеры палитры, использовавшиеся по экранам, переотображены на
/// реальные тональные роли M3 — старые места вызова (`cs.card`, `cs.muted`,
/// `cs.foreground`…) продолжают работать и теперь следуют за seed.
/// В новом коде предпочитай нативные роли.
extension AppThemeColorSchemeX on ColorScheme {
  Color get scaffoldBackground => surface;

  Color get card => surfaceContainer;

  Color get muted => surfaceContainerHigh;

  Color get mutedForeground => onSurfaceVariant;

  Color get border => outlineVariant;

  Color get foreground => onSurface;

  Color get secondaryForeground => onSecondaryContainer;

  Color get accent => tertiary;

  // Семантические роли, которых нет в ColorScheme.
  Color get success => brightness == Brightness.dark
      ? const Color(0xFF7CD992)
      : const Color(0xFF146C2E);

  Color get onSuccess => brightness == Brightness.dark
      ? const Color(0xFF00391B)
      : const Color(0xFFFFFFFF);

  Color get warning => brightness == Brightness.dark
      ? const Color(0xFFF6C45A)
      : const Color(0xFF7E5700);

  Color get info => brightness == Brightness.dark
      ? const Color(0xFFA7C8FF)
      : const Color(0xFF2B5A9B);

  /// Пул тональных контейнеров для карточек групп: (container, onContainer).
  /// Стабильный цвет на группу: `pool[group.id % pool.length]`.
  List<(Color, Color)> get groupCardPool => [
        (primaryContainer, onPrimaryContainer),
        (tertiaryContainer, onTertiaryContainer),
        (secondaryContainer, onSecondaryContainer),
      ];
}
