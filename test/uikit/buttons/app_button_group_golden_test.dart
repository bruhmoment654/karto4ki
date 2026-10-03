import 'package:flutter/material.dart';
import 'package:quizzerg/uikit/buttons/app_button_group.dart';
import 'package:zoloto/zoloto.dart';

const _items = [
  AppButtonGroupItem(label: 'Все 10'),
  AppButtonGroupItem(label: 'Ошибки 3'),
  AppButtonGroupItem(label: 'Исправил 2'),
  AppButtonGroupItem(label: 'Забыл 1'),
];

Widget _wrap(Widget child) => Align(alignment: Alignment.topLeft, child: child);

void main() {
  Zoloto.zolotoTest(
    'app_button_group',
    widgetBuilder: (context, tester, testCase) => _wrap(
      AppButtonGroup(
        items: _items,
        selectedIndex: 0,
        onSelectedChanged: (_) {},
        padding: const EdgeInsets.all(16),
      ),
    ),
    testHeight: const TestHeight$BasedOnContent(),
  );

  Zoloto.zolotoTest(
    'app_button_group_middle_selected',
    widgetBuilder: (context, tester, testCase) => _wrap(
      AppButtonGroup(
        items: _items,
        selectedIndex: 2,
        onSelectedChanged: (_) {},
        padding: const EdgeInsets.all(16),
      ),
    ),
    testHeight: const TestHeight$BasedOnContent(),
  );

  // Иконка со счётчиком вместо подписи.
  Zoloto.zolotoTest(
    'app_button_group_with_icons',
    widgetBuilder: (context, tester, testCase) => _wrap(
      AppButtonGroup(
        items: const [
          AppButtonGroupItem(label: 'Все 10'),
          AppButtonGroupItem(label: 'Ошибки 3'),
          AppButtonGroupItem(label: '2', icon: Icons.trending_up),
          AppButtonGroupItem(label: '1', icon: Icons.trending_down),
        ],
        selectedIndex: 2,
        onSelectedChanged: (_) {},
        padding: const EdgeInsets.all(16),
      ),
    ),
    testHeight: const TestHeight$BasedOnContent(),
  );

  // Пустой фильтр недоступен.
  Zoloto.zolotoTest(
    'app_button_group_disabled_item',
    widgetBuilder: (context, tester, testCase) => _wrap(
      AppButtonGroup(
        items: const [
          AppButtonGroupItem(label: 'Все 10'),
          AppButtonGroupItem(label: 'Ошибки 0', isEnabled: false),
        ],
        selectedIndex: 0,
        onSelectedChanged: (_) {},
        padding: const EdgeInsets.all(16),
      ),
    ),
    testHeight: const TestHeight$BasedOnContent(),
  );
}
