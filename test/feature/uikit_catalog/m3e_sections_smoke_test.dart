import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quizzerg/feature/uikit_catalog/presentation/sections/m3e/m3e_actions_section.dart';
import 'package:quizzerg/feature/uikit_catalog/presentation/sections/m3e/m3e_containment_section.dart';
import 'package:quizzerg/feature/uikit_catalog/presentation/sections/m3e/m3e_feedback_section.dart';
import 'package:quizzerg/feature/uikit_catalog/presentation/sections/m3e/m3e_navigation_section.dart';
import 'package:quizzerg/feature/uikit_catalog/presentation/sections/m3e/m3e_selection_section.dart';
import 'package:quizzerg/uikit/m3e/m3e_scope.dart';
import 'package:quizzerg/uikit/theme/app_theme.dart';

/// Секции каталога material_3_expressive рендерятся внутри `M3EScope`
/// без исключений и переполнений на экране телефона в обеих темах.
void main() {
  const sections = <String, Widget>{
    'M3EActionsSection': M3EActionsSection(),
    'M3ESelectionSection': M3ESelectionSection(),
    'M3EContainmentSection': M3EContainmentSection(),
    'M3ENavigationSection': M3ENavigationSection(),
    'M3EFeedbackSection': M3EFeedbackSection(),
  };

  Widget app(ThemeData theme, Widget section) => MaterialApp(
    theme: theme,
    locale: const Locale('ru', 'RU'),
    localizationsDelegates: const [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: const [Locale('ru', 'RU')],
    home: Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: M3EScope(child: section),
      ),
    ),
  );

  for (final MapEntry(key: name, value: section) in sections.entries) {
    for (final (themeName, theme) in [
      ('light', AppTheme.light()),
      ('dark', AppTheme.dark()),
    ]) {
      testWidgets('$name рендерится ($themeName)', (tester) async {
        tester.view
          ..physicalSize = const Size(1080, 2400)
          ..devicePixelRatio = 3;
        addTearDown(tester.view.reset);

        await tester.pumpWidget(app(theme, section));
        await tester.pump();
        await tester.pump(const Duration(seconds: 1));

        expect(tester.takeException(), isNull);
      });
    }
  }
}
