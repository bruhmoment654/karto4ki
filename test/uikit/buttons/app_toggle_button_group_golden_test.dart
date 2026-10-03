import 'package:flutter/material.dart';
import 'package:quizzerg/uikit/buttons/app_toggle_button_group.dart';
import 'package:quizzerg/uikit/spacing/height.dart';
import 'package:zoloto/zoloto.dart';

const _items = [
  AppToggleButtonItem(
    icon: Icons.light_mode_outlined,
    selectedIcon: Icons.light_mode,
    semanticLabel: 'Светлая',
  ),
  AppToggleButtonItem(
    icon: Icons.dark_mode_outlined,
    selectedIcon: Icons.dark_mode,
    semanticLabel: 'Тёмная',
  ),
  AppToggleButtonItem(
    icon: Icons.brightness_auto_outlined,
    selectedIcon: Icons.brightness_auto,
    semanticLabel: 'Как в системе',
  ),
];

/// Выбранная кнопка — половина ряда, остальные делят вторую половину.
/// Группа лежит на карточке настроек, как в приложении.
void main() {
  Zoloto.zolotoTest(
    'app_toggle_button_group',
    widgetBuilder: (context, tester, testCase) => ColoredBox(
      color: Theme.of(context).colorScheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var i = 0; i < _items.length; i++) ...[
              if (i > 0) const Height(16),
              AppToggleButtonGroup(
                items: _items,
                selectedIndex: i,
                onSelectedChanged: (_) {},
              ),
            ],
          ],
        ),
      ),
    ),
    testHeight: const TestHeight$BasedOnContent(),
  );
}
