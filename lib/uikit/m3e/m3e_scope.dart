import 'package:flutter/material.dart' as app show Theme;
import 'package:material_3_expressive/material_3_expressive.dart';
import 'package:material_ui/material_ui.dart';

/// Окружение для компонентов `material_3_expressive`.
///
/// Пакет построен на `material_ui` — отдельной от `flutter/material` копии
/// Material-библиотеки, поэтому тема, `Material` и локализации приложения
/// ему не видны. Скоуп даёт поддереву тему M3E по цвету, яркости и шрифту
/// темы приложения, прозрачный `Material` и локализации `material_ui`.
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
  /// Тема M3E считает тональную схему по seed — дорого для десятка
  /// индикаторов на одном экране. Комбинаций цвета и яркости за сессию
  /// единицы, поэтому кешируем без вытеснения.
  static final _cache = <(Color, Brightness, String?), M3EThemeData>{};

  late M3EThemeData _data;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final appTheme = app.Theme.of(context);
    final seedColor = appTheme.colorScheme.primary;
    final brightness = appTheme.brightness;
    final fontFamily = appTheme.textTheme.bodyMedium?.fontFamily;

    _data = _cache.putIfAbsent((seedColor, brightness, fontFamily), () {
      final base = brightness == Brightness.dark
          ? M3EThemeData.dark(seedColor: seedColor)
          : M3EThemeData.light(seedColor: seedColor);

      return base.copyWith(fontFamily: fontFamily);
    });
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
}
