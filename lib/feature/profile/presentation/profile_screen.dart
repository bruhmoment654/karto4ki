import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizzerg/app/di/app_scope.dart';
import 'package:quizzerg/feature/profile/presentation/profile_view.dart';
import 'package:quizzerg/persistence/settings/data/settings_dto.dart';

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

  @override
  int get animationDurationMs => _settings.animationDurationMs;

  @override
  void onAnimationDurationChanged(double value) {
    setState(() {
      _settings = SettingsDto(animationDurationMs: value.round());
      _settingsStorage.save(_settings);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ProfileView(viewModel: this);
  }
}

/// ViewModel interface for profile screen.
abstract interface class IProfileViewModel {
  int get animationDurationMs;

  void onAnimationDurationChanged(double value);
}
