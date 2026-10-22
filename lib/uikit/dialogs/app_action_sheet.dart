import 'package:flutter/material.dart';
import 'package:material_3_expressive/material_3_expressive.dart'
    show M3EButton, M3EButtonStyle;
import 'package:quizzerg/uikit/dialogs/dialog_controller.dart';
import 'package:quizzerg/uikit/m3e/m3e_scope.dart';
import 'package:quizzerg/uikit/spacing/height.dart';
import 'package:quizzerg/uikit/spacing/width.dart';

/// Главная кнопка шторки действий («Начать»).
class AppActionSheetButton<T> {
  final IconData icon;
  final String label;
  final T value;

  /// Второстепенная кнопка рядом с главной — тональная.
  final bool isTonal;

  const AppActionSheetButton({
    required this.icon,
    required this.label,
    required this.value,
    this.isTonal = false,
  });
}

/// Строка шторки действий.
class AppActionSheetItem<T> {
  final IconData icon;
  final String label;
  final T value;

  /// Удаление и подобное: красная строка отдельно внизу, под разделителем.
  final bool isDestructive;

  const AppActionSheetItem({
    required this.icon,
    required this.label,
    required this.value,
    this.isDestructive = false,
  });
}

/// Шторка действий над элементом списка по долгому нажатию (M3 modal
/// bottom sheet): шапка с названием и сводкой, главные кнопки, строки
/// действий, деструктивные — отдельно внизу.
///
/// Закрывается с `value` выбранного действия — обработку делает экран.
class AppActionSheet<T> extends StatelessWidget {
  static const double _horizontalPadding = 24;

  final String title;
  final String? subtitle;
  final List<AppActionSheetButton<T>> buttons;
  final List<AppActionSheetItem<T>> items;

  const AppActionSheet({
    required this.title,
    required this.items,
    this.subtitle,
    this.buttons = const [],
    super.key,
  });

  /// Показывает шторку и ждёт выбранное действие; `null` — закрыли без
  /// выбора.
  static Future<T?> show<T>(
    BuildContext context, {
    required String title,
    required List<AppActionSheetItem<T>> items,
    String? subtitle,
    List<AppActionSheetButton<T>> buttons = const [],
  }) {
    return DialogController.showBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
      builder: (_) => AppActionSheet<T>(
        title: title,
        subtitle: subtitle,
        buttons: buttons,
        items: items,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final subtitle = this.subtitle;
    final regular = items.where((item) => !item.isDestructive);
    final destructive = items.where((item) => item.isDestructive);

    return SingleChildScrollView(
      padding: EdgeInsets.only(
        bottom: MediaQuery.paddingOf(context).bottom + 28,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              _horizontalPadding,
              0,
              _horizontalPadding,
              14,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                if (subtitle != null) ...[
                  const Height(2),
                  Text(
                    subtitle,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (buttons.isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(
                _horizontalPadding,
                0,
                _horizontalPadding,
                12,
              ),
              child: _Buttons<T>(buttons: buttons),
            ),
          for (final item in regular) _ItemRow<T>(item: item),
          if (regular.isNotEmpty && destructive.isNotEmpty)
            const Divider(
              height: 17,
              indent: _horizontalPadding,
              endIndent: _horizontalPadding,
            ),
          for (final item in destructive) _ItemRow<T>(item: item),
        ],
      ),
    );
  }
}

class _Buttons<T> extends StatelessWidget {
  final List<AppActionSheetButton<T>> buttons;

  const _Buttons({required this.buttons});

  @override
  Widget build(BuildContext context) {
    return M3EScope(
      child: Row(
        children: [
          for (final (index, button) in buttons.indexed) ...[
            if (index > 0) const Width(8),
            Expanded(
              child: M3EButton(
                style: button.isTonal
                    ? M3EButtonStyle.tonal
                    : M3EButtonStyle.filled,
                onPressed: () => Navigator.of(context).pop(button.value),
                icon: Icon(button.icon),
                label: Text(button.label),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _ItemRow<T> extends StatelessWidget {
  static const double _height = 56;

  final AppActionSheetItem<T> item;

  const _ItemRow({required this.item});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final iconColor = item.isDestructive
        ? colorScheme.error
        : colorScheme.onSurfaceVariant;
    final labelColor = item.isDestructive
        ? colorScheme.error
        : colorScheme.onSurface;

    return InkWell(
      onTap: () => Navigator.of(context).pop(item.value),
      child: SizedBox(
        height: _height,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppActionSheet._horizontalPadding,
          ),
          child: Row(
            children: [
              Icon(item.icon, size: 24, color: iconColor),
              const Width(16),
              Expanded(
                child: Text(
                  item.label,
                  style: theme.textTheme.bodyLarge?.copyWith(color: labelColor),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
