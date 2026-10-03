import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quizzerg/uikit/motion/app_animated_switcher.dart';

final _halfDuration = AppAnimatedSwitcher.duration ~/ 2;

void main() {
  testWidgets('новое содержимое проявляется, пока прежнее гаснет',
      (tester) async {
    await tester.pumpWidget(const _TestApp(child: Text('A', key: ValueKey('A'))));
    await tester.pumpWidget(const _TestApp(child: Text('B', key: ValueKey('B'))));
    await tester.pump(_halfDuration);

    expect(_opacityOf(tester, 'A'), inExclusiveRange(0, 1));
    expect(_opacityOf(tester, 'B'), inExclusiveRange(0, 1));

    await tester.pumpAndSettle();
    expect(find.text('A'), findsNothing);
    expect(_opacityOf(tester, 'B'), 1);
  });

  testWidgets('тот же тип без ключа — не смена: текст обновляется на месте',
      (tester) async {
    await tester.pumpWidget(const _TestApp(child: Text('A')));
    await tester.pumpWidget(const _TestApp(child: Text('B')));
    await tester.pump(_halfDuration);

    expect(find.text('A'), findsNothing);
    expect(_opacityOf(tester, 'B'), 1);
  });

  testWidgets('анимации отключены — содержимое меняется сразу', (tester) async {
    await tester.pumpWidget(
      const _TestApp(
        isAnimationDisabled: true,
        child: Text('A', key: ValueKey('A')),
      ),
    );
    await tester.pumpWidget(
      const _TestApp(
        isAnimationDisabled: true,
        child: Text('B', key: ValueKey('B')),
      ),
    );
    await tester.pump();

    expect(find.text('A'), findsNothing);
    expect(_opacityOf(tester, 'B'), 1);
  });

  testWidgets('снизу вверх: новое поднимается снизу, прежнее уходит вверх',
      (tester) async {
    await tester.pumpWidget(
      const _TestApp(
        transition: AppSwitcherTransition.slideUp,
        child: Text('A', key: ValueKey('A')),
      ),
    );
    final restTop = tester.getTopLeft(find.text('A')).dy;

    await tester.pumpWidget(
      const _TestApp(
        transition: AppSwitcherTransition.slideUp,
        child: Text('B', key: ValueKey('B')),
      ),
    );
    await tester.pump(_halfDuration);

    expect(tester.getTopLeft(find.text('A')).dy, lessThan(restTop));
    expect(tester.getTopLeft(find.text('B')).dy, greaterThan(restTop));

    await tester.pumpAndSettle();
    expect(find.text('A'), findsNothing);
    expect(tester.getTopLeft(find.text('B')).dy, restTop);
  });

  testWidgets(
      'раскладку не меняет: содержимое заполняет место, как без свитчера',
      (tester) async {
    const body = ValueKey('body');
    await tester.pumpWidget(
      const _TestApp(child: ColoredBox(key: body, color: Colors.black)),
    );

    expect(tester.getSize(find.byKey(body)), _TestApp.size);
  });
}

double _opacityOf(WidgetTester tester, String text) {
  final fade = find
      .ancestor(of: find.text(text), matching: find.byType(FadeTransition))
      .first;

  return tester.widget<FadeTransition>(fade).opacity.value;
}

class _TestApp extends StatelessWidget {
  static const size = Size(200, 100);

  final Widget child;
  final AppSwitcherTransition transition;
  final bool isAnimationDisabled;

  const _TestApp({
    required this.child,
    this.transition = AppSwitcherTransition.fade,
    this.isAnimationDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(disableAnimations: isAnimationDisabled),
        child: child ?? const SizedBox.shrink(),
      ),
      home: Center(
        child: SizedBox.fromSize(
          size: size,
          child: AppAnimatedSwitcher(transition: transition, child: child),
        ),
      ),
    );
  }
}
