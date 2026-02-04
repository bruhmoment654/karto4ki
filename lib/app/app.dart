import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:karto4ki/app/navigation/app_router.dart';
import 'package:karto4ki/l10n/app_localizations.dart';
import 'package:karto4ki/uikit/theme/app_theme.dart';
import 'package:karto4ki/uikit/theme/app_theme_scope.dart';

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
          final isDark = themeScope.isDark;

          return AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarBrightness:
                  isDark ? Brightness.dark : Brightness.light,
              statusBarIconBrightness:
                  isDark ? Brightness.light : Brightness.dark,
            ),
            child: MaterialApp.router(
              routeInformationParser: _appRouter.defaultRouteParser(),
              routerDelegate: _appRouter.delegate(
                navigatorObservers: () => [AutoRouteObserver()],
              ),
              theme: AppTheme.dark,
              darkTheme: AppTheme.dark,
              themeMode: ThemeMode.dark,
              locale: _locale,
              localizationsDelegates: _localizationsDelegates,
              supportedLocales: const [_locale],
              debugShowCheckedModeBanner: false,
            ),
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
