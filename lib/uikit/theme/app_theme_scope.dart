import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizzerg/app/di/app_scope.dart';
import 'package:quizzerg/persistence/settings/data/settings_dto.dart';
import 'package:quizzerg/persistence/settings/i_settings_storage.dart';
import 'package:quizzerg/uikit/theme/app_theme.dart';

class AppThemeScope extends StatefulWidget {
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
  State<AppThemeScope> createState() => _AppThemeScopeState();
}

class _AppThemeScopeState extends State<AppThemeScope> {
  late final ISettingsStorage _settingsStorage;
  late SettingsDto _settings;

  @override
  void initState() {
    super.initState();
    _settingsStorage = context.read<IAppScope>().settingsStorage;
    _settings = _settingsStorage.get();
    _settingsStorage.listenable.addListener(_onSettingsChanged);
  }

  @override
  void dispose() {
    _settingsStorage.listenable.removeListener(_onSettingsChanged);
    super.dispose();
  }

  void _onSettingsChanged() {
    setState(() {
      _settings = _settingsStorage.listenable.value;
    });
  }

  Color get _seedColor => AppTheme.seedColorFromHue(_settings.accentColorHue);

  ThemeMode get _themeMode => switch (_settings.themeMode) {
        AppThemeMode.light => ThemeMode.light,
        AppThemeMode.dark => ThemeMode.dark,
        AppThemeMode.system => ThemeMode.system,
      };

  @override
  Widget build(BuildContext context) {
    return _AppThemeScopeInherited(
      data: AppThemeScopeData(
        seedColor: _seedColor,
        themeMode: _themeMode,
      ),
      child: widget.child,
    );
  }
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
