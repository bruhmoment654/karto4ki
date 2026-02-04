import 'package:flutter/material.dart';
import 'package:karto4ki/feature/profile/presentation/profile_screen.dart';
import 'package:karto4ki/uikit/appbar/karto4ki_app_bar.dart';
import 'package:karto4ki/uikit/scaffold/app_scaffold.dart';

/// UI layer for profile and settings.
class ProfileView extends StatelessWidget {
  final IProfileViewModel viewModel;

  const ProfileView({required this.viewModel, super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      appBar: Karto4kiAppBar(title: 'Профиль и настройки'),
      body: SizedBox.shrink(),
    );
  }
}
