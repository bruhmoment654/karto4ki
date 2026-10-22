import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quizzerg/uikit/dialogs/open_modals_observer.dart';

void main() {
  /// Страница с predictive back открыта поверх первой; диалог — поверх неё.
  Future<PageRoute<void>> pumpPage(WidgetTester tester) async {
    final navigatorKey = GlobalKey<NavigatorState>();
    await tester.pumpWidget(
      MaterialApp(
        navigatorKey: navigatorKey,
        navigatorObservers: [OpenModalsObserver()],
        theme: ThemeData(
          platform: TargetPlatform.android,
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: {
              TargetPlatform.android: ModalAwarePageTransitionsBuilder(
                PredictiveBackPageTransitionsBuilder(),
              ),
            },
          ),
        ),
        home: const SizedBox(),
      ),
    );
    final route = MaterialPageRoute<void>(builder: (_) => const Text('page'));
    unawaited(navigatorKey.currentState?.push(route));
    await tester.pumpAndSettle();
    return route;
  }

  testWidgets('пока открыт диалог, свайп «назад» у страницы выключен', (
    tester,
  ) async {
    final route = await pumpPage(tester);
    expect(route.popGestureEnabled, isTrue);

    final context = tester.element(find.text('page'));
    unawaited(
      showDialog<void>(context: context, builder: (_) => const Text('dialog')),
    );
    await tester.pumpAndSettle();
    expect(OpenModalsObserver.isAnyOpen.value, isTrue);
    expect(route.popGestureEnabled, isFalse);

    Navigator.of(tester.element(find.text('dialog'))).pop();
    await tester.pumpAndSettle();
    expect(OpenModalsObserver.isAnyOpen.value, isFalse);
    expect(route.popGestureEnabled, isTrue);
  });

  testWidgets('системный back закрывает диалог, а не страницу под ним', (
    tester,
  ) async {
    await pumpPage(tester);
    unawaited(
      showDialog<void>(
        context: tester.element(find.text('page')),
        builder: (_) => const Text('dialog'),
      ),
    );
    await tester.pumpAndSettle();

    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();

    expect(find.text('dialog'), findsNothing);
    expect(find.text('page'), findsOneWidget);
  });
}
