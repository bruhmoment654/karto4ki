import 'package:flutter/material.dart';

enum AppThemeMode {
  system,
  light,
  dark,
}

class AppThemeScope extends StatefulWidget {
  final AppThemeMode initialMode;
  final Widget child;

  const AppThemeScope({
    required this.child,
    this.initialMode = AppThemeMode.system,
    super.key,
  });

  static AppThemeScopeData of(BuildContext context) {
    final inherited =
        context.dependOnInheritedWidgetOfExactType<_AppThemeScopeInherited>();
    assert(inherited != null, 'AppThemeScope is not found in context');
    return inherited!.data;
  }

  @override
  State<AppThemeScope> createState() => _AppThemeScopeState();
}

class _AppThemeScopeState extends State<AppThemeScope>
    with WidgetsBindingObserver {
  late AppThemeMode _mode;
  late Brightness _platformBrightness;

  @override
  void initState() {
    super.initState();
    _mode = widget.initialMode;
    _platformBrightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangePlatformBrightness() {
    final brightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;
    if (brightness == _platformBrightness) {
      return;
    }
    _platformBrightness = brightness;
    if (_mode == AppThemeMode.system) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _setMode(AppThemeMode mode) {
    if (_mode == mode) {
      return;
    }
    setState(() => _mode = mode);
  }

  @override
  Widget build(BuildContext context) {
    return _AppThemeScopeInherited(
      data: AppThemeScopeData(
        mode: _mode,
        platformBrightness: _platformBrightness,
        setMode: _setMode,
      ),
      child: widget.child,
    );
  }
}

class AppThemeScopeData {
  final AppThemeMode mode;
  final Brightness platformBrightness;
  final ValueChanged<AppThemeMode> setMode;

  const AppThemeScopeData({
    required this.mode,
    required this.platformBrightness,
    required this.setMode,
  });

  ThemeMode get themeMode {
    switch (mode) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.system:
        return ThemeMode.system;
    }
  }

  bool get isDark {
    if (mode == AppThemeMode.dark) {
      return true;
    }
    if (mode == AppThemeMode.light) {
      return false;
    }
    return platformBrightness == Brightness.dark;
  }
}

class _AppThemeScopeInherited extends InheritedWidget {
  final AppThemeScopeData data;

  const _AppThemeScopeInherited({
    required this.data,
    required super.child,
  });

  @override
  bool updateShouldNotify(_AppThemeScopeInherited oldWidget) {
    return oldWidget.data.mode != data.mode ||
        oldWidget.data.platformBrightness != data.platformBrightness;
  }
}

class AppThemeModeSelector extends StatelessWidget {
  const AppThemeModeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final scope = AppThemeScope.of(context);

    return DropdownButton<AppThemeMode>(
      value: scope.mode,
      onChanged: (value) {
        if (value != null) {
          scope.setMode(value);
        }
      },
      items: const [
        DropdownMenuItem(
          value: AppThemeMode.system,
          child: Text('Системная'),
        ),
        DropdownMenuItem(
          value: AppThemeMode.light,
          child: Text('Светлая'),
        ),
        DropdownMenuItem(
          value: AppThemeMode.dark,
          child: Text('Тёмная'),
        ),
      ],
    );
  }
}
