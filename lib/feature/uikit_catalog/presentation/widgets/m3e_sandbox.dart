import 'package:flutter/material.dart' as app show Theme;
import 'package:material_3_expressive/material_3_expressive.dart';
import 'package:material_ui/material_ui.dart';

/// Окружение для компонентов `material_3_expressive`.
///
/// Пакет построен на `material_ui` — отдельной от `flutter/material` копии
/// Material-библиотеки, поэтому тема, `Material` и локализации приложения
/// ему не видны. Песочница даёт поддереву тему M3E по цвету, яркости и шрифту
/// темы приложения, прозрачный `Material` и локализации `material_ui`.
///
/// Модальные компоненты пакета (диалоги, шторки) пушатся в корневой
/// навигатор — за пределы песочницы, поэтому внутри неё не работают.
///
/// Тема M3E подменяет `IconTheme` и `DefaultTextStyle`, поэтому оборачивать
/// стоит только M3E-компоненты.
class M3ESandbox extends StatefulWidget {
  final Widget child;

  const M3ESandbox({required this.child, super.key});

  @override
  State<M3ESandbox> createState() => _M3ESandboxState();
}

class _M3ESandboxState extends State<M3ESandbox> {
  late M3EThemeData _data;
  Color? _seedColor;
  Brightness? _brightness;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final appTheme = app.Theme.of(context);
    final seedColor = appTheme.colorScheme.primary;
    final brightness = appTheme.brightness;
    if (seedColor == _seedColor && brightness == _brightness) return;

    _seedColor = seedColor;
    _brightness = brightness;
    final base = brightness == Brightness.dark
        ? M3EThemeData.dark(seedColor: seedColor)
        : M3EThemeData.light(seedColor: seedColor);
    _data = base.copyWith(
      fontFamily: appTheme.textTheme.bodyMedium?.fontFamily,
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
}
