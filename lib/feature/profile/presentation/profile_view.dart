import 'package:flutter/material.dart';
import 'package:quizzerg/feature/profile/presentation/profile_screen.dart';
import 'package:quizzerg/l10n/app_localizations_x.dart';
import 'package:quizzerg/uikit/appbar/karto4ki_app_bar.dart';
import 'package:quizzerg/uikit/content_card/content_card.dart';
import 'package:quizzerg/uikit/content_card/content_card_type.dart';
import 'package:quizzerg/uikit/pressable/scale_pressable.dart';
import 'package:quizzerg/uikit/scaffold/app_scaffold.dart';

class ProfileView extends StatelessWidget {
  final IProfileViewModel viewModel;

  const ProfileView({required this.viewModel, super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: DefaultAppBar(title: Text(context.l10n.profileSettingsTitle)),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        children: [
          _StatsButton(onTap: viewModel.onStatsTap),
          const SizedBox(height: 12),
          _SettingsButton(onTap: viewModel.onSettingsTap),
        ],
      ),
    );
  }
}

class _StatsButton extends StatelessWidget {
  final VoidCallback onTap;

  const _StatsButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ScalePressable(
      onTap: onTap,
      child: ContentCard(
        elevation: 5,
        type: ContentCardType.smallWide,
        child: Row(
          children: [
            Icon(
              Icons.bar_chart_outlined,
              color: theme.colorScheme.onSurface,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                context.l10n.questionStatsTitle,
                style: theme.textTheme.titleMedium,
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsButton extends StatelessWidget {
  final VoidCallback onTap;

  const _SettingsButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ScalePressable(
      onTap: onTap,
      child: ContentCard(
        elevation: 5,
        type: ContentCardType.smallWide,
        child: Row(
          children: [
            Icon(
              Icons.settings_outlined,
              color: theme.colorScheme.onSurface,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                context.l10n.settingsTitle,
                style: theme.textTheme.titleMedium,
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }
}
