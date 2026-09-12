import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizzerg/feature/settings/domain/bloc/settings_bloc.dart';
import 'package:quizzerg/persistence/settings/data/settings_dto.dart';
import 'package:quizzerg/uikit/theme/app_theme.dart';

/// Раздаёт тему приложения вниз по дереву.
///
/// Источник — [SettingsBloc]: у настроек один владелец, и тема пересобирается
/// тем же состоянием, что и экран настроек.
///
/// Это app-скоуп, а не View или компонент дизайн-системы, поэтому здесь
/// [BlocBuilder] по глобальному блоку — единственное место в `uikit`,
/// где это допустимо (см. `.cursor/rules/presentation-layer.mdc`).
class AppThemeScope extends StatelessWidget {
  final Widget child;

  const AppThemeScope({
    required this.child,
    super.key,
  });

  static AppThemeScopeData of(BuildContext context) {
    final inherited =
        context.dependOnInheritedWidgetOfExactType<_AppThemeScopeInherited>();
    assert(inherited != null, 'AppThemeScope is not found in context');
    return inherited!.data;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      buildWhen: (previous, current) =>
          previous.accentColorHue != current.accentColorHue ||
          previous.settings.themeMode != current.settings.themeMode,
      builder: (context, state) => _AppThemeScopeInherited(
        data: AppThemeScopeData(
          seedColor: AppTheme.seedColorFromHue(state.accentColorHue),
          themeMode: _themeMode(state.settings.themeMode),
        ),
        child: child,
      ),
    );
  }

  ThemeMode _themeMode(AppThemeMode mode) => switch (mode) {
        AppThemeMode.light => ThemeMode.light,
        AppThemeMode.dark => ThemeMode.dark,
        AppThemeMode.system => ThemeMode.system,
      };
}

class AppThemeScopeData {
  final Color seedColor;
  final ThemeMode themeMode;

  const AppThemeScopeData({
    this.seedColor = AppTheme.defaultSeedColor,
    this.themeMode = ThemeMode.system,
  });

  bool get isDark => themeMode == ThemeMode.dark;

  ThemeData get lightTheme => AppTheme.light(seedColor: seedColor);

  ThemeData get darkTheme => AppTheme.dark(seedColor: seedColor);
}

class _AppThemeScopeInherited extends InheritedWidget {
  final AppThemeScopeData data;

  const _AppThemeScopeInherited({
    required this.data,
    required super.child,
  });

  @override
  bool updateShouldNotify(_AppThemeScopeInherited oldWidget) =>
      data.seedColor != oldWidget.data.seedColor ||
      data.themeMode != oldWidget.data.themeMode;
}
