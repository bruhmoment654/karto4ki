import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quizzerg/uikit/theme/animated_theme_scope.dart';

const _lightSurface = Color(0xFFFFFFFF);
const _darkSurface = Color(0xFF000000);

ThemeData _theme(Color surface) => ThemeData(
  colorScheme: const ColorScheme.light().copyWith(surface: surface),
);

class _Surface extends StatelessWidget {
  final List<Color> seen;

  const _Surface(this.seen);

  @override
  Widget build(BuildContext context) {
    seen.add(Theme.of(context).colorScheme.surface);

    return const SizedBox.shrink();
  }
}

void main() {
  testWidgets('внутри — плавный переход, снаружи — за кадр', (tester) async {
    final inside = <Color>[];
    final outside = <Color>[];

    Widget app(Color surface) => MaterialApp(
      theme: _theme(surface),
      themeAnimationStyle: AnimationStyle.noAnimation,
      home: Column(
        children: [
          _Surface(outside),
          AnimatedThemeScope(child: _Surface(inside)),
        ],
      ),
    );

    await tester.pumpWidget(app(_lightSurface));
    await tester.pumpWidget(app(_darkSurface));
    await tester.pump(kThemeAnimationDuration ~/ 2);

    expect(outside.last, _darkSurface);
    expect(inside.last, isNot(anyOf(_lightSurface, _darkSurface)));

    await tester.pumpAndSettle();
    expect(inside.last, _darkSurface);
  });
}
