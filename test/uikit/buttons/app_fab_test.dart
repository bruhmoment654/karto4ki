import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quizzerg/uikit/buttons/app_fab.dart';

/// Масштаб FAB с подписью [label]: ищем от самого виджета, а не от тултипа —
/// во время перехода кнопку несёт hero, и тултипа на месте нет.
double _scaleOf(WidgetTester tester, String label) => tester
    .widget<ScaleTransition>(
      find
          .descendant(
            of: find.byWidgetPredicate(
              (widget) =>
                  widget is AppFloatingActionButton && widget.label == label,
            ),
            matching: find.byType(ScaleTransition),
          )
          .first,
    )
    .scale
    .value;

Widget _screen(String label, {bool isVisible = true}) => Scaffold(
  floatingActionButton: AppFloatingActionButton(
    label: label,
    onPressed: () {},
    isVisible: isVisible,
  ),
);

void main() {
  testWidgets('первый FAB на экране появляется с анимацией', (tester) async {
    await tester.pumpWidget(MaterialApp(home: _screen('a')));

    expect(_scaleOf(tester, 'a'), 0);
    // Появление стартует таймером, а не кадром — pumpAndSettle его не ждёт.
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pumpAndSettle();
    expect(_scaleOf(tester, 'a'), 1);
  });

  testWidgets('экран поверх экрана с FAB показывает свой FAB сразу', (
    tester,
  ) async {
    final navigatorKey = GlobalKey<NavigatorState>();
    await tester.pumpWidget(
      MaterialApp(navigatorKey: navigatorKey, home: _screen('a')),
    );
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pumpAndSettle();

    unawaited(
      navigatorKey.currentState?.push(
        MaterialPageRoute<void>(builder: (_) => _screen('b')),
      ),
    );
    // Середина перехода: таймер появления (250 мс) ещё не сработал бы.
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(_scaleOf(tester, 'b'), 1);
  });

  testWidgets('скрытый FAB не нажимается и возвращается анимацией', (
    tester,
  ) async {
    await tester.pumpWidget(MaterialApp(home: _screen('a', isVisible: false)));
    await tester.pumpAndSettle();
    expect(_scaleOf(tester, 'a'), 0);
    expect(find.byTooltip('a').hitTestable(), findsNothing);

    await tester.pumpWidget(MaterialApp(home: _screen('a')));
    await tester.pumpAndSettle();
    expect(_scaleOf(tester, 'a'), 1);
  });
}
