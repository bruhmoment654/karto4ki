import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quizzerg/feature/uikit_catalog/presentation/uikit_catalog_view.dart';
import 'package:quizzerg/l10n/app_localizations.dart';
import 'package:quizzerg/uikit/theme/app_theme.dart';

/// Экран каталога целиком: каждая секция раскрывается без исключений
/// и переполнений.
void main() {
  const sectionTitles = [
    'Основа',
    'Кнопки',
    'Поля и переключатели',
    'Карточки',
    'Прогресс',
    'Скелетоны',
    'Шапки',
    'Диалоги и снекбары',
    'Анимации',
    'Действия',
    'Выбор',
    'Контейнеры',
    'Навигация',
    'Индикаторы и ввод',
  ];

  Widget app(ThemeData theme) => MaterialApp(
        theme: theme,
        locale: const Locale('ru', 'RU'),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: UikitCatalogView(onBackPressed: () {}),
      );

  for (final (themeName, theme) in [
    ('light', AppTheme.light()),
    ('dark', AppTheme.dark()),
  ]) {
    testWidgets('все секции раскрываются ($themeName)', (tester) async {
      tester.view
        ..physicalSize = const Size(1080, 2400)
        ..devicePixelRatio = 3;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(app(theme));
      await tester.pump(const Duration(seconds: 1));

      // Первый Scrollable в дереве — сам список каталога.
      final catalogList = find.byType(Scrollable).first;

      for (final title in sectionTitles) {
        // Список ленивый: листаем, пока заголовок секции не построится.
        while (find.text(title).evaluate().isEmpty) {
          await tester.drag(catalogList, const Offset(0, -300));
          await tester.pump();
        }
        final header = find.text(title).first;
        await tester.ensureVisible(header);
        await tester.pump();
        await tester.tap(header);
        await tester.pump(const Duration(milliseconds: 600));

        expect(tester.takeException(), isNull, reason: title);
      }
    });
  }
}
