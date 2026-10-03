import 'package:flutter/material.dart';
import 'package:material_3_expressive/material_3_expressive.dart'
    show M3EButton, M3EButtonDecoration, M3EButtonSize;
import 'package:quizzerg/uikit/m3e/m3e_scope.dart';
import 'package:quizzerg/uikit/motion/app_motion.dart';
import 'package:quizzerg/uikit/spacing/width.dart';

/// Кнопка группы [AppToggleButtonGroup].
class AppToggleButtonItem {
  final IconData icon;

  /// Иконка выбранной кнопки — обычно залитый вариант [icon].
  final IconData selectedIcon;

  /// Подпись для экранного диктора: у кнопок нет текста.
  final String semanticLabel;

  const AppToggleButtonItem({
    required this.icon,
    required this.selectedIcon,
    required this.semanticLabel,
  });
}

/// Ряд иконочных переключателей M3 Expressive с одиночным выбором — например,
/// режим темы.
///
/// Выбранная кнопка занимает половину ряда и из «пилюли» становится
/// скруглённым квадратом, остальные делят вторую половину поровну. Зазоры
/// вычитаются до деления, поэтому ряд ровно по ширине родителя. Ширина
/// меняется пружиной: обе кнопки анимируются одной кривой, и сумма ширин
/// в любой момент равна ширине ряда.
///
/// `M3EButtonGroup` здесь не подходит: при фиксированной ширине действия он
/// не анимирует её смену.
class AppToggleButtonGroup extends StatelessWidget {
  final List<AppToggleButtonItem> items;
  final int selectedIndex;
  final ValueChanged<int> onSelectedChanged;

  const AppToggleButtonGroup({
    required this.items,
    required this.selectedIndex,
    required this.onSelectedChanged,
    super.key,
  });

  static const _spacing = 6.0;

  @override
  Widget build(BuildContext context) {
    return M3EScope(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final available =
              constraints.maxWidth - _spacing * (items.length - 1);
          final selectedWidth = items.length == 1 ? available : available / 2;
          final restWidth = items.length == 1
              ? available
              : (available - selectedWidth) / (items.length - 1);

          return Row(
            children: [
              for (var i = 0; i < items.length; i++) ...[
                if (i > 0) const Width(_spacing),
                _AppToggleButton(
                  item: items[i],
                  isSelected: i == selectedIndex,
                  selectedWidth: selectedWidth,
                  restWidth: restWidth,
                  onPressed: () {
                    if (i != selectedIndex) onSelectedChanged(i);
                  },
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}

class _AppToggleButton extends StatelessWidget {
  static const _height = 56.0;
  static const _iconSize = 26.0;

  /// Скруглённый квадрат выбранной кнопки (shape-lg).
  static const _selectedRadius = 16.0;

  final AppToggleButtonItem item;
  final bool isSelected;
  final double selectedWidth;
  final double restWidth;
  final VoidCallback onPressed;

  const _AppToggleButton({
    required this.item,
    required this.isSelected,
    required this.selectedWidth,
    required this.restWidth,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return TweenAnimationBuilder<double>(
      tween: Tween(end: isSelected ? 1 : 0),
      duration: AppMotion.reduced(context) ? Duration.zero : AppMotion.medium,
      curve: AppMotion.spring,
      builder: (context, progress, child) => SizedBox(
        width: restWidth + (selectedWidth - restWidth) * progress,
        height: _height,
        child: child,
      ),
      child: M3EButton(
        onPressed: onPressed,
        icon: Icon(item.icon),
        selectedIcon: Icon(item.selectedIcon),
        isSelected: isSelected,
        size: M3EButtonSize.md,
        semanticLabel: item.semanticLabel,
        decoration: M3EButtonDecoration.styleFrom(
          backgroundColor: cs.surfaceContainerHighest,
          selectedBackgroundColor: cs.primary,
          foregroundColor: cs.onSurfaceVariant,
          selectedForegroundColor: cs.onPrimary,
          iconSize: _iconSize,
          // Невыбранная остаётся «пилюлей» (форма по умолчанию).
          selectedRadius: _selectedRadius,
        ),
      ),
    );
  }
}
