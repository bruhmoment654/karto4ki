import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizzerg/app/di/app_scope.dart';
import 'package:quizzerg/feature/profile/presentation/profile_view.dart';
import 'package:quizzerg/persistence/settings/data/settings_dto.dart';
import 'package:quizzerg/uikit/theme/app_theme.dart';

/// Profile screen.
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    implements IProfileViewModel {
  late final _settingsStorage = context.read<IAppScope>().settingsStorage;
  late SettingsDto _settings = _settingsStorage.get();

  double? _pendingHue;
  Timer? _colorDebounceTimer;

  @override
  int get animationDurationMs => _settings.animationDurationMs;

  @override
  bool get shaderAnimationEnabled => _settings.shaderAnimationEnabled;

  @override
  double get accentColorHue => _pendingHue ?? _settings.accentColorHue;

  @override
  Color get previewAccentColor => AppTheme.seedColorFromHue(accentColorHue);

  @override
  void onAnimationDurationChanged(double value) {
    setState(() {
      _settings = SettingsDto(
        animationDurationMs: value.round(),
        shaderAnimationEnabled: _settings.shaderAnimationEnabled,
        accentColorHue: _settings.accentColorHue,
      );
      _settingsStorage.save(_settings);
    });
  }

  @override
  void onShaderAnimationToggled({required bool value}) {
    setState(() {
      _settings = SettingsDto(
        animationDurationMs: _settings.animationDurationMs,
        shaderAnimationEnabled: value,
        accentColorHue: _settings.accentColorHue,
      );
      _settingsStorage.save(_settings);
    });
  }

  @override
  void onAccentColorHueChanged(double value) {
    setState(() {
      _pendingHue = value;
    });

    _colorDebounceTimer?.cancel();
    _colorDebounceTimer = Timer(const Duration(milliseconds: 500), () {
      setState(() {
        _settings = SettingsDto(
          animationDurationMs: _settings.animationDurationMs,
          shaderAnimationEnabled: _settings.shaderAnimationEnabled,
          accentColorHue: value,
        );
        _pendingHue = null;
      });
      _settingsStorage.save(_settings);
    });
  }

  @override
  void dispose() {
    _colorDebounceTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProfileView(viewModel: this);
  }
}

/// ViewModel interface for profile screen.
abstract interface class IProfileViewModel {
  int get animationDurationMs;
  bool get shaderAnimationEnabled;
  double get accentColorHue;
  Color get previewAccentColor;

  void onAnimationDurationChanged(double value);
  void onShaderAnimationToggled({required bool value});
  void onAccentColorHueChanged(double value);
}
