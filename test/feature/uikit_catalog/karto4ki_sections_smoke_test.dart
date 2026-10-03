import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quizzerg/feature/uikit_catalog/presentation/sections/karto4ki/buttons_section.dart';
import 'package:quizzerg/feature/uikit_catalog/presentation/sections/karto4ki/cards_section.dart';
import 'package:quizzerg/feature/uikit_catalog/presentation/sections/karto4ki/feedback_section.dart';
import 'package:quizzerg/feature/uikit_catalog/presentation/sections/karto4ki/foundation_section.dart';
import 'package:quizzerg/feature/uikit_catalog/presentation/sections/karto4ki/headers_section.dart';
import 'package:quizzerg/feature/uikit_catalog/presentation/sections/karto4ki/inputs_section.dart';
import 'package:quizzerg/feature/uikit_catalog/presentation/sections/karto4ki/motion_section.dart';
import 'package:quizzerg/feature/uikit_catalog/presentation/sections/karto4ki/progress_section.dart';
import 'package:quizzerg/feature/uikit_catalog/presentation/sections/karto4ki/skeletons_section.dart';
import 'package:quizzerg/l10n/app_localizations.dart';
import 'package:quizzerg/uikit/theme/app_theme.dart';

/// Секции каталога karto4ki рендерятся без исключений и переполнений
/// на экране телефона в обеих темах.
void main() {
  const sections = <String, Widget>{
    'FoundationSection': FoundationSection(),
    'ButtonsSection': ButtonsSection(),
    'InputsSection': InputsSection(),
    'CardsSection': CardsSection(),
    'ProgressSection': ProgressSection(),
    'SkeletonsSection': SkeletonsSection(),
    'HeadersSection': HeadersSection(),
    'FeedbackSection': FeedbackSection(),
    'MotionSection': MotionSection(),
  };

  Widget app(ThemeData theme, Widget section) => MaterialApp(
        theme: theme,
        locale: const Locale('ru', 'RU'),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(32),
            child: section,
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
        await tester.pump(const Duration(seconds: 2));

        expect(tester.takeException(), isNull);
      });
    }
  }
}
