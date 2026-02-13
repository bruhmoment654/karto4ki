import 'package:flutter/material.dart';
import 'package:quizzerg/feature/profile/presentation/profile_screen.dart';
import 'package:quizzerg/l10n/app_localizations_x.dart';
import 'package:quizzerg/uikit/appbar/karto4ki_app_bar.dart';
import 'package:quizzerg/uikit/scaffold/app_scaffold.dart';

/// UI layer for profile and settings.
class ProfileView extends StatelessWidget {
  final IProfileViewModel viewModel;

  const ProfileView({required this.viewModel, super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: Karto4kiAppBar(title: context.l10n.profileSettingsTitle),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        children: [
          _AnimationSpeedCard(viewModel: viewModel),
        ],
      ),
    );
  }
}

class _AnimationSpeedCard extends StatelessWidget {
  final IProfileViewModel viewModel;

  const _AnimationSpeedCard({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      shape: const BeveledRectangleBorder(),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Text(
              context.l10n.profileAnimationSpeedTitle,
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            Slider(
              value: viewModel.animationDurationMs.toDouble(),
              max: 1000,
              divisions: 10,
              label: context.l10n.profileAnimationDurationLabel(
                viewModel.animationDurationMs,
              ),
              onChanged: viewModel.onAnimationDurationChanged,
            ),
            const SizedBox(height: 4),
            Text(
              context.l10n.profileAnimationDurationLabel(
                viewModel.animationDurationMs,
              ),
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
