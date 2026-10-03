import 'package:flutter/material.dart' as app show ColorScheme, Theme;
import 'package:material_3_expressive/material_3_expressive.dart';
import 'package:material_ui/material_ui.dart';
import 'package:quizzerg/uikit/theme/app_colors.dart';

/// Окружение для компонентов `material_3_expressive`.
///
/// Пакет построен на `material_ui` — отдельной от `flutter/material` копии
/// Material-библиотеки, поэтому тема, `Material` и локализации приложения
/// ему не видны. Скоуп даёт поддереву тему M3E с ролями схемы приложения
/// (а не схему, заново построенную из `primary`: в монохроме она окрасила бы
/// серые контейнеры), шрифтом темы, прозрачным `Material` и локализациями
/// `material_ui`.
///
/// Модальные компоненты пакета (диалоги, шторки) пушатся в корневой
/// навигатор — за пределы скоупа, поэтому внутри него не работают.
///
/// Тема M3E подменяет `IconTheme` и `DefaultTextStyle`, поэтому оборачивать
/// стоит только M3E-компоненты.
class M3EScope extends StatefulWidget {
  final Widget child;

  const M3EScope({required this.child, super.key});

  @override
  State<M3EScope> createState() => _M3EScopeState();
}

class _M3EScopeState extends State<M3EScope> {
  /// Тема M3E собирает типографику и темы компонентов — дорого для десятка
  /// индикаторов на одном экране. Устойчивых схем за сессию единицы, но
  /// слайдер акцента и анимация смены темы дают новую схему каждый кадр —
  /// поэтому кеш сбрасывается, когда разрастается.
  static const _cacheLimit = 16;
  static final _cache = <(app.ColorScheme, AppColors, String?), M3EThemeData>{};

  late M3EThemeData _data;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final appTheme = app.Theme.of(context);
    final scheme = appTheme.colorScheme;
    final colors = appTheme.appColors;
    final fontFamily = appTheme.textTheme.bodyMedium?.fontFamily;

    if (_cache.length >= _cacheLimit) _cache.clear();
    _data = _cache.putIfAbsent(
      (scheme, colors, fontFamily),
      () => M3EThemeData(
        colorScheme: _m3eSchemeOf(scheme, colors),
      ).copyWith(fontFamily: fontFamily),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Localizations.override(
      context: context,
      delegates: const [GlobalMaterialLocalizations.delegate],
      child: M3ETheme(
        data: _data,
        child: Material(type: MaterialType.transparency, child: widget.child),
      ),
    );
  }

  static M3EColorScheme _m3eSchemeOf(app.ColorScheme cs, AppColors colors) {
    return M3EColorScheme(
      brightness: cs.brightness,
      primary: cs.primary,
      onPrimary: cs.onPrimary,
      primaryContainer: cs.primaryContainer,
      onPrimaryContainer: cs.onPrimaryContainer,
      secondary: cs.secondary,
      onSecondary: cs.onSecondary,
      secondaryContainer: cs.secondaryContainer,
      onSecondaryContainer: cs.onSecondaryContainer,
      tertiary: cs.tertiary,
      onTertiary: cs.onTertiary,
      tertiaryContainer: cs.tertiaryContainer,
      onTertiaryContainer: cs.onTertiaryContainer,
      error: cs.error,
      onError: cs.onError,
      errorContainer: cs.errorContainer,
      onErrorContainer: cs.onErrorContainer,
      surface: cs.surface,
      onSurface: cs.onSurface,
      onSurfaceVariant: cs.onSurfaceVariant,
      surfaceContainerLowest: cs.surfaceContainerLowest,
      surfaceContainerLow: cs.surfaceContainerLow,
      surfaceContainer: cs.surfaceContainer,
      surfaceContainerHigh: cs.surfaceContainerHigh,
      surfaceContainerHighest: cs.surfaceContainerHighest,
      surfaceDim: cs.surfaceDim,
      surfaceBright: cs.surfaceBright,
      inverseSurface: cs.inverseSurface,
      onInverseSurface: cs.onInverseSurface,
      inversePrimary: cs.inversePrimary,
      outline: cs.outline,
      outlineVariant: cs.outlineVariant,
      shadow: cs.shadow,
      scrim: cs.scrim,
      surfaceTint: cs.surfaceTint,
      emphasis: cs.primary,
      onEmphasis: cs.onPrimary,
      info: colors.info,
      success: colors.success,
      warning: colors.warning,
      danger: cs.error,
      surfaceStrong: cs.surfaceContainerHigh,
      onSurfaceStrong: cs.onSurface,
      outlineStrong: cs.outline,
    );
  }
}
