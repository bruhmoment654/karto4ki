import 'package:flutter/cupertino.dart' show CupertinoTheme, CupertinoThemeData;
import 'package:flutter/material.dart';

/// Держит скрытому поддереву прежнюю тему, пока его не видно.
///
/// Анимация смены темы `MaterialApp` в каждом кадре выдаёт новую `ThemeData`,
/// и пересобирается всё, что зависит от темы, — в том числе экраны под
/// текущим маршрутом и неактивные табы, которых не видно. На 120 Гц это
/// не укладывается в кадр. Скрытое поддерево получает тему, которая была,
/// пока его видели, и обновляется один раз — когда снова появится.
///
/// «Скрыто» = выключен [TickerMode]: так `Overlay` помечает маршруты под
/// непрозрачным экраном, а `ActiveTabTickerMode` — неактивные табы.
class HiddenThemeFreeze extends StatefulWidget {
  final Widget child;

  const HiddenThemeFreeze({required this.child, super.key});

  @override
  State<HiddenThemeFreeze> createState() => _HiddenThemeFreezeState();
}

class _HiddenThemeFreezeState extends State<HiddenThemeFreeze> {
  ThemeData? _theme;
  CupertinoThemeData? _cupertinoTheme;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cupertinoTheme = CupertinoTheme.of(context);
    final isVisible = TickerMode.valuesOf(context).enabled;
    if (isVisible || _theme == null) {
      _theme = theme;
      _cupertinoTheme = cupertinoTheme;
    }

    // Тема Cupertino замораживается вместе с Material: вложенный `Theme`
    // берёт её у предка, а `Theme.of` подписан и на неё — иначе потомки
    // всё равно пересобирались бы каждый кадр.
    return CupertinoTheme(
      data: _cupertinoTheme ?? cupertinoTheme,
      child: Theme(data: _theme ?? theme, child: widget.child),
    );
  }
}

/// Оборачивает экран каждого маршрута в [HiddenThemeFreeze]: экран,
/// перекрытый другим маршрутом, не пересобирается на смене темы.
class HiddenThemeFreezePageTransitionsBuilder extends PageTransitionsBuilder {
  final PageTransitionsBuilder base;

  const HiddenThemeFreezePageTransitionsBuilder(this.base);

  @override
  Duration get transitionDuration => base.transitionDuration;

  @override
  Duration get reverseTransitionDuration => base.reverseTransitionDuration;

  @override
  DelegatedTransitionBuilder? get delegatedTransition =>
      base.delegatedTransition;

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return base.buildTransitions(
      route,
      context,
      animation,
      secondaryAnimation,
      HiddenThemeFreeze(child: child),
    );
  }
}
