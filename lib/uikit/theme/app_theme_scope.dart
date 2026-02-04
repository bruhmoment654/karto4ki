import 'package:flutter/material.dart';

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
    return _AppThemeScopeInherited(
      data: const AppThemeScopeData(),
      child: child,
    );
  }
}

class AppThemeScopeData {
  const AppThemeScopeData();

  ThemeMode get themeMode => ThemeMode.dark;

  bool get isDark => true;
}

class _AppThemeScopeInherited extends InheritedWidget {
  final AppThemeScopeData data;

  const _AppThemeScopeInherited({
    required this.data,
    required super.child,
  });

  @override
  bool updateShouldNotify(_AppThemeScopeInherited oldWidget) => false;
}
