import 'dart:async';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:quizzerg/app/di/app_scope.dart';
import 'package:quizzerg/feature/settings/presentation/settings_view.dart';
import 'package:quizzerg/persistence/settings/data/settings_dto.dart';
import 'package:quizzerg/uikit/theme/app_theme.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    implements ISettingsViewModel {
  late final _settingsStorage = context.read<IAppScope>().settingsStorage;
  late SettingsDto _settings = _settingsStorage.get();

  String _appVersion = '';
  double? _pendingHue;
  Timer? _colorDebounceTimer;

  void _saveSettings(SettingsDto settings) {
    setState(() {
      _settings = settings;
    });
    _settingsStorage.save(_settings);
  }

  @override
  void initState() {
    super.initState();
    PackageInfo.fromPlatform().then((info) {
      setState(() {
        _appVersion = '${info.version} (${info.buildNumber})';
      });
    });
  }

  @override
  String get appVersion => _appVersion;

  @override
  int get animationDurationMs => _settings.animationDurationMs;

  @override
  bool get shaderAnimationEnabled => _settings.shaderAnimationEnabled;

  @override
  double get accentColorHue => _pendingHue ?? _settings.accentColorHue;

  @override
  Color get previewAccentColor => AppTheme.seedColorFromHue(accentColorHue);

  @override
  AppThemeMode get themeMode => _settings.themeMode;

  @override
  double get cardFontSize => _settings.cardFontSize;

  @override
  void onCardFontSizeChanged(double value) {
    _saveSettings(SettingsDto(
      animationDurationMs: _settings.animationDurationMs,
      shaderAnimationEnabled: _settings.shaderAnimationEnabled,
      accentColorHue: _settings.accentColorHue,
      mixupEnabled: _settings.mixupEnabled,
      mixupMin: _settings.mixupMin,
      mixupMax: _settings.mixupMax,
      themeMode: _settings.themeMode,
      mixupAlgorithm: _settings.mixupAlgorithm,
      cardFontSize: value,
    ));
  }

  @override
  void onThemeModeChanged(AppThemeMode mode) {
    _saveSettings(SettingsDto(
      animationDurationMs: _settings.animationDurationMs,
      shaderAnimationEnabled: _settings.shaderAnimationEnabled,
      accentColorHue: _settings.accentColorHue,
      mixupEnabled: _settings.mixupEnabled,
      mixupMin: _settings.mixupMin,
      mixupMax: _settings.mixupMax,
      themeMode: mode,
      mixupAlgorithm: _settings.mixupAlgorithm,
      cardFontSize: _settings.cardFontSize,
    ));
  }

  @override
  void onAnimationDurationChanged(double value) {
    _saveSettings(SettingsDto(
      animationDurationMs: value.round(),
      shaderAnimationEnabled: _settings.shaderAnimationEnabled,
      accentColorHue: _settings.accentColorHue,
      mixupEnabled: _settings.mixupEnabled,
      mixupMin: _settings.mixupMin,
      mixupMax: _settings.mixupMax,
      themeMode: _settings.themeMode,
      mixupAlgorithm: _settings.mixupAlgorithm,
      cardFontSize: _settings.cardFontSize,
    ));
  }

  @override
  void onShaderAnimationToggled({required bool value}) {
    _saveSettings(SettingsDto(
      animationDurationMs: _settings.animationDurationMs,
      shaderAnimationEnabled: value,
      accentColorHue: _settings.accentColorHue,
      mixupEnabled: _settings.mixupEnabled,
      mixupMin: _settings.mixupMin,
      mixupMax: _settings.mixupMax,
      themeMode: _settings.themeMode,
      mixupAlgorithm: _settings.mixupAlgorithm,
      cardFontSize: _settings.cardFontSize,
    ));
  }

  @override
  void onAccentColorHueChanged(double value) {
    setState(() {
      _pendingHue = value;
    });

    _colorDebounceTimer?.cancel();
    _colorDebounceTimer = Timer(const Duration(milliseconds: 500), () {
      _pendingHue = null;
      _saveSettings(SettingsDto(
        animationDurationMs: _settings.animationDurationMs,
        shaderAnimationEnabled: _settings.shaderAnimationEnabled,
        accentColorHue: value,
        mixupEnabled: _settings.mixupEnabled,
        mixupMin: _settings.mixupMin,
        mixupMax: _settings.mixupMax,
        themeMode: _settings.themeMode,
        mixupAlgorithm: _settings.mixupAlgorithm,
        cardFontSize: _settings.cardFontSize,
      ));
    });
  }

  @override
  void dispose() {
    _colorDebounceTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SettingsView(viewModel: this);
  }
}

abstract interface class ISettingsViewModel {
  String get appVersion;
  int get animationDurationMs;
  bool get shaderAnimationEnabled;
  double get accentColorHue;
  Color get previewAccentColor;
  AppThemeMode get themeMode;
  double get cardFontSize;

  void onAnimationDurationChanged(double value);
  void onShaderAnimationToggled({required bool value});
  void onAccentColorHueChanged(double value);
  void onThemeModeChanged(AppThemeMode mode);
  void onCardFontSizeChanged(double value);
}
