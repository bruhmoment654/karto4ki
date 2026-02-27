import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:quizzerg/app/navigation/app_router.dart';
import 'package:quizzerg/feature/profile/presentation/profile_view.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    implements IProfileViewModel {
  @override
  void onSettingsTap() {
    context.router.push(const SettingsRoute());
  }

  @override
  Widget build(BuildContext context) {
    return ProfileView(viewModel: this);
  }
}

abstract interface class IProfileViewModel {
  void onSettingsTap();
}
