import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:quizzerg/app/navigation/app_router.dart';
import 'package:quizzerg/feature/splash/presentation/card_swipe_splash.dart';
import 'package:quizzerg/l10n/app_localizations.dart';
import 'package:quizzerg/uikit/dialogs/open_modals_observer.dart';
import 'package:quizzerg/uikit/theme/app_theme.dart';
import 'package:quizzerg/uikit/theme/app_theme_scope.dart';

/// {@template app.class}
/// Application.
/// {@endtemplate}
class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return AppThemeScope(
      child: Builder(
        builder: (context) {
          final themeScope = AppThemeScope.of(context);

          return MaterialApp.router(
            routeInformationParser: _appRouter.defaultRouteParser(),
            routerDelegate: _appRouter.delegate(
              // Наследуются вложенными роутерами: каждый навигатор получает
              // свои экземпляры.
              navigatorObservers: () => [
                AutoRouteObserver(),
                OpenModalsObserver(),
              ],
            ),
            // Стиль статус-бара по разрешённой теме (с учётом системной) —
            // для сплеша и экранов без AppScaffold.
            builder: (context, child) => AnnotatedRegion<SystemUiOverlayStyle>(
              value: AppTheme.systemOverlayStyle(Theme.of(context).brightness),
              child: CardSwipeSplash(child: child ?? const SizedBox.shrink()),
            ),
            scrollBehavior: const _AppScrollBehavior(),
            theme: themeScope.lightTheme,
            darkTheme: themeScope.darkTheme,
            themeMode: themeScope.themeMode,
            // Тема применяется за кадр: покадровая анимация пересобирала бы
            // всё приложение. Плавный переход — только там, где его видно
            // (AnimatedThemeScope).
            themeAnimationStyle: AnimationStyle.noAnimation,
            locale: _locale,
            localizationsDelegates: _localizationsDelegates,
            supportedLocales: const [_locale],
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}

const _locale = Locale('ru', 'RU');
const _localizationsDelegates = [
  AppLocalizations.delegate,
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
];

class _AppScrollBehavior extends MaterialScrollBehavior {
  const _AppScrollBehavior();

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const BouncingScrollPhysics();
  }
}
