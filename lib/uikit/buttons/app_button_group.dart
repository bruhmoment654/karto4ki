import 'package:flutter/material.dart';
import 'package:material_3_expressive/material_3_expressive.dart'
    show
        M3EButtonGroup,
        M3EButtonGroupAction,
        M3EButtonGroupOverflow,
        M3EButtonSize,
        M3EButtonStyle;
import 'package:quizzerg/uikit/m3e/m3e_scope.dart';

/// Кнопка группы [AppButtonGroup].
class AppButtonGroupItem {
  final String label;

  /// Иконка перед подписью.
  final IconData? icon;

  /// Для экранного диктора — когда подпись без иконки непонятна.
  final String? semanticLabel;

  /// Недоступную кнопку нельзя выбрать.
  final bool isEnabled;

  const AppButtonGroupItem({
    required this.label,
    this.icon,
    this.semanticLabel,
    this.isEnabled = true,
  });
}

/// Группа кнопок M3 Expressive с одиночным выбором — например, фильтр.
///
/// Нажатая кнопка расширяется и раздвигает соседей, выбранная меняет цвет
/// и форму — без галочки. Если кнопки не помещаются по ширине, группа
/// прокручивается; [padding] — отступы внутри прокрутки, чтобы крайние
/// кнопки уезжали под край экрана, а не обрезались по отступу.
///
/// Нажатая кнопка растёт на 15% ширины за счёт соседей, а пакет обрезает
/// подпись по своему отступу (12 px; `padding` декорации группа не
/// применяет). Поэтому у содержимого свой запас [_clipReserve]: сжатие съедает
/// его, а не текст.
class AppButtonGroup extends StatelessWidget {
  final List<AppButtonGroupItem> items;
  final int selectedIndex;
  final ValueChanged<int> onSelectedChanged;
  final EdgeInsetsGeometry padding;

  const AppButtonGroup({
    required this.items,
    required this.selectedIndex,
    required this.onSelectedChanged,
    this.padding = EdgeInsets.zero,
    super.key,
  });

  static const _spacing = 8.0;

  /// Сосед крайней кнопки теряет весь её прирост — по 7,5% её ширины с
  /// каждой стороны. 8 px хватает, пока нажатая кнопка не шире ~105 px.
  static const _clipReserve = 8.0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: padding,
      child: M3EScope(
        child: M3EButtonGroup(
          style: M3EButtonStyle.tonal,
          size: M3EButtonSize.xs,
          spacing: _spacing,
          // Прокрутка снаружи: так она доходит до края экрана.
          overflow: M3EButtonGroupOverflow.none,
          selectionRequired: true,
          selectedIndex: selectedIndex,
          onSelectedIndexChanged: (index) {
            if (index != null) onSelectedChanged(index);
          },
          actions: [for (final item in items) _actionOf(item)],
        ),
      ),
    );
  }

  /// Запас под сжатие — по внешним краям содержимого: слева у иконки,
  /// если она есть, справа у подписи. Между ними — штатный зазор пакета.
  M3EButtonGroupAction _actionOf(AppButtonGroupItem item) {
    final icon = item.icon;

    return M3EButtonGroupAction(
      icon: icon == null
          ? null
          : Padding(
              padding: const EdgeInsets.only(left: _clipReserve),
              child: Icon(icon),
            ),
      label: Padding(
        padding: EdgeInsets.only(
          left: icon == null ? _clipReserve : 0,
          right: _clipReserve,
        ),
        child: Text(item.label),
      ),
      semanticLabel: item.semanticLabel,
      enabled: item.isEnabled,
    );
  }
}
