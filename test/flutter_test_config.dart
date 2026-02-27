import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quizzerg/l10n/app_localizations.dart';
import 'package:quizzerg/uikit/theme/app_theme.dart';
import 'package:zoloto/zoloto.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  return Zoloto.runWithConfiguration(
    () async {
      TestWidgetsFlutterBinding.ensureInitialized();
      await loadAppFonts();
      await testMain();
    },
    config: ZolotoConfig(
      testCases: [
        ZolotoTestCase(
          name: 'pixel_4',
          size: const Size(360, 760),
          theme: ZolotoTestingTheme(
            brightness: Brightness.dark,
            backgroundColor: const Color(0xFF121212),
            data: AppTheme.dark(),
            mode: ThemeMode.dark,
          ),
          localeOverrides: const [Locale('ru', 'RU')],
          localizations: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        ),
        ZolotoTestCase(
          name: 'iphone_14',
          size: const Size(390, 844),
          safeArea: const EdgeInsets.only(top: 47, bottom: 34),
          theme: ZolotoTestingTheme(
            brightness: Brightness.dark,
            backgroundColor: const Color(0xFF121212),
            data: AppTheme.dark(),
            mode: ThemeMode.dark,
          ),
          localeOverrides: const [Locale('ru', 'RU')],
          localizations: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        ),
      ],
    ),
  );
}
