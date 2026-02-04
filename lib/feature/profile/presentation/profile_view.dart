import 'package:flutter/material.dart';
import 'package:karto4ki/feature/profile/presentation/profile_screen.dart';
import 'package:karto4ki/uikit/appbar/karto4ki_app_bar.dart';
import 'package:karto4ki/uikit/scaffold/app_scaffold.dart';
import 'package:karto4ki/uikit/theme/app_theme_scope.dart';

/// UI layer for profile and settings.
class ProfileView extends StatelessWidget {
  final IProfileViewModel viewModel;

  const ProfileView({required this.viewModel, super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return AppScaffold(
      appBar: const Karto4kiAppBar(title: 'Профиль и настройки'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text('Тема приложения', style: textTheme.titleMedium),
            ),
            const AppThemeModeSelector(),
          ],
        ),
      ),
    );
  }
}
