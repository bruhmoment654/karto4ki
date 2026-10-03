import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quizzerg/uikit/theme/app_theme.dart';

/// Считает сборки и запоминает яркость темы, которую видел.
class _Probe extends StatelessWidget {
  final List<Brightness> builds;

  const _Probe(this.builds);

  @override
  Widget build(BuildContext context) {
    builds.add(Theme.of(context).brightness);

    return const SizedBox.expand();
  }
}

void main() {
  late StateSetter setMode;
  var mode = ThemeMode.light;
  final bottomBuilds = <Brightness>[];

  Future<NavigatorState> pumpCoveredRoute(WidgetTester tester) async {
    mode = ThemeMode.light;
    bottomBuilds.clear();
    await tester.pumpWidget(
      StatefulBuilder(
        builder: (context, setState) {
          setMode = setState;

          return MaterialApp(
            theme: AppTheme.light(),
            darkTheme: AppTheme.dark(),
            themeMode: mode,
            home: _Probe(bottomBuilds),
          );
        },
      ),
    );
    final navigator = tester.state<NavigatorState>(find.byType(Navigator));
    unawaited(
      navigator.push(MaterialPageRoute<void>(builder: (_) => const Scaffold())),
    );
    await tester.pumpAndSettle();
    bottomBuilds.clear();

    return navigator;
  }

  testWidgets('перекрытый экран не пересобирается в кадрах анимации темы', (
    tester,
  ) async {
    await pumpCoveredRoute(tester);

    setMode(() => mode = ThemeMode.dark);
    // Первый кадр: MaterialApp пересобирает навигатор, и тот один раз
    // пересобирает страницы всех маршрутов — так и без заморозки.
    await tester.pump();
    bottomBuilds.clear();
    await tester.pumpAndSettle();

    expect(bottomBuilds, isEmpty);
  });

  testWidgets('открывшийся экран получает актуальную тему', (tester) async {
    final navigator = await pumpCoveredRoute(tester);

    setMode(() => mode = ThemeMode.dark);
    await tester.pumpAndSettle();
    navigator.pop();
    await tester.pumpAndSettle();

    expect(bottomBuilds, isNotEmpty);
    expect(bottomBuilds.last, Brightness.dark);
  });
}
