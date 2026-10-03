import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_3_expressive/material_3_expressive.dart'
    show M3EButton;
import 'package:quizzerg/uikit/buttons/app_button_group.dart';
import 'package:quizzerg/uikit/theme/app_theme.dart';

const _items = [
  AppButtonGroupItem(label: 'Все 10'),
  AppButtonGroupItem(label: 'Ошибки 3'),
  AppButtonGroupItem(label: 'Исправил 2'),
];

Future<void> _pump(WidgetTester tester, {ValueChanged<int>? onSelected}) =>
    tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.dark(),
        home: Scaffold(
          body: AppButtonGroup(
            items: _items,
            selectedIndex: 0,
            onSelectedChanged: onSelected ?? (_) {},
          ),
        ),
      ),
    );

/// Видимая подпись: невидимые копии для замера групп не принимают нажатий.
Finder _label(String text) => find.text(text).hitTestable();

double _buttonWidth(WidgetTester tester, String label) => tester
    .getSize(
      find.ancestor(of: _label(label), matching: find.byType(M3EButton)).first,
    )
    .width;

void main() {
  testWidgets('нажатая кнопка расширяется и раздвигает соседей', (
    tester,
  ) async {
    await _pump(tester);
    await tester.pumpAndSettle();

    final restWidth = _buttonWidth(tester, 'Ошибки 3');
    final restNeighbourWidth = _buttonWidth(tester, 'Исправил 2');

    final gesture = await tester.startGesture(
      tester.getCenter(_label('Ошибки 3')),
    );
    await tester.pumpAndSettle();
    final pressedWidth = _buttonWidth(tester, 'Ошибки 3');
    final squishedNeighbourWidth = _buttonWidth(tester, 'Исправил 2');

    await gesture.up();
    await tester.pumpAndSettle();

    expect(pressedWidth, greaterThan(restWidth));
    expect(squishedNeighbourWidth, lessThan(restNeighbourWidth));
    expect(
      _buttonWidth(tester, 'Ошибки 3'),
      moreOrLessEquals(restWidth, epsilon: 0.01),
    );
  });

  testWidgets('тап выбирает кнопку по индексу', (tester) async {
    int? selected;
    await _pump(tester, onSelected: (index) => selected = index);
    await tester.pumpAndSettle();

    await tester.tap(_label('Исправил 2'));
    await tester.pumpAndSettle();

    expect(selected, 2);
  });
}
