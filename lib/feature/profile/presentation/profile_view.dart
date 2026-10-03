import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:quizzerg/core/bloc/state_streamable_builder.dart';
import 'package:quizzerg/feature/auth/domain/bloc/auth_bloc.dart';
import 'package:quizzerg/feature/profile/domain/bloc/profile_bloc.dart';
import 'package:quizzerg/feature/profile/domain/entity/profile_summary_entity.dart';
import 'package:quizzerg/feature/profile/presentation/profile_screen.dart';
import 'package:quizzerg/feature/profile/presentation/widget/profile_account_card.dart';
import 'package:quizzerg/feature/profile/presentation/widget/profile_sign_in_card.dart';
import 'package:quizzerg/feature/profile/presentation/widget/profile_stats_card.dart';
import 'package:quizzerg/feature/sync/presentation/sync_status_card.dart';
import 'package:quizzerg/l10n/app_localizations_x.dart';
import 'package:quizzerg/uikit/appbar/app_page_header.dart';
import 'package:quizzerg/uikit/content_card/content_card.dart';
import 'package:quizzerg/uikit/content_card/content_card_type.dart';
import 'package:quizzerg/uikit/motion/count_up_text.dart';
import 'package:quizzerg/uikit/motion/staggered_appear.dart';
import 'package:quizzerg/uikit/progress/streak_week_progress.dart';
import 'package:quizzerg/uikit/scaffold/app_scaffold.dart';
import 'package:quizzerg/uikit/shape/shape_plate.dart';
import 'package:quizzerg/uikit/spacing/height.dart';
import 'package:quizzerg/uikit/spacing/width.dart';

class ProfileView extends StatelessWidget {
  final IProfileViewModel viewModel;

  const ProfileView({required this.viewModel, super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(body: _Body(viewModel: viewModel));
  }
}

class _Body extends StatelessWidget {
  final IProfileViewModel viewModel;

  const _Body({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return StateStreamableBuilder<ProfileState>(
      bloc: viewModel.profileState,
      builder: (context, state) => switch (state) {
        ProfileState$Loading() =>
          const Center(child: CircularProgressIndicator()),
        ProfileState$Error() => _ErrorContent(onRetry: viewModel.onRetryTap),
        ProfileState$Loaded(:final summary) => _LoadedContent(
            viewModel: viewModel,
            summary: summary,
          ),
      },
    );
  }
}

class _LoadedContent extends StatelessWidget {
  final IProfileViewModel viewModel;
  final ProfileSummaryEntity summary;

  const _LoadedContent({required this.viewModel, required this.summary});

  @override
  Widget build(BuildContext context) {
    return StateStreamableBuilder<AuthState>(
      bloc: viewModel.authState,
      builder: (context, authState) => Column(
        children: [
          AppPageHeader(title: context.l10n.profileDashboardTitle),
          Expanded(
            child: AnimationLimiter(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                children: AnimationConfiguration.toStaggeredList(
                  duration: const Duration(milliseconds: 375),
                  childAnimationBuilder: (child) => StaggeredAppear(
                    position: 0,
                    child: child,
                  ),
                  children: [
                    _IdentityBlock(
                      viewModel: viewModel,
                      authState: authState,
                    ),
                    const Height(14),
                    // Блок синхронизации есть только при сессии: гостю
                    // показывать нечего.
                    if (authState.hasSession) ...[
                      SyncStatusCard(
                        syncState: viewModel.syncState,
                        onSignInTap: viewModel.onSignInTap,
                        onSyncTap: viewModel.onSyncTap,
                        onCardTap: viewModel.onSyncStatusTap,
                      ),
                      const Height(14),
                    ],
                    ProfileStatsCard(
                      summary: summary,
                      onTap: viewModel.onStatsTap,
                    ),
                    const Height(14),
                    _StreakCard(summary: summary),
                    const Height(14),
                    _ExtraMetricsCard(summary: summary),
                    const Height(14),
                    _SettingsCard(
                      onSettingsTap: viewModel.onSettingsTap,
                      onSignOutTap: authState.hasSession
                          ? viewModel.onSignOutTap
                          : null,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Первый блок профиля: зависит только от состояния авторизации.
class _IdentityBlock extends StatelessWidget {
  /// Высота карточки аккаунта: аватар 60 + отступы 18 сверху и снизу.
  /// Держим её и в `unknown`, чтобы список не прыгал, пока читается
  /// защищённое хранилище.
  static const _cardHeight = 96.0;

  final IProfileViewModel viewModel;
  final AuthState authState;

  const _IdentityBlock({required this.viewModel, required this.authState});

  @override
  Widget build(BuildContext context) {
    return switch (authState) {
      AuthState$Unknown() => const SizedBox(height: _cardHeight),
      AuthState$Unauthorized() || AuthState$Authorizing() => ProfileSignInCard(
          onTap: viewModel.onSignInTap,
        ),
      AuthState$Authorized(:final user) ||
      AuthState$Expired(:final user) =>
        ProfileAccountCard(user: user),
    };
  }
}

class _StreakCard extends StatelessWidget {
  final ProfileSummaryEntity summary;

  const _StreakCard({required this.summary});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return ContentCard(
      type: ContentCardType.large,
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              ShapePlate(
                kind: ShapePlateKind.cookie7Sided,
                size: 48,
                color: cs.tertiaryContainer,
                isRotating: true,
                child: Icon(
                  Icons.local_fire_department,
                  size: 22,
                  color: cs.onTertiaryContainer,
                ),
              ),
              const Width(14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DefaultTextStyle.merge(
                      style: textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                      child: Row(
                        children: [
                          CountUpText(
                            value: summary.currentStreak,
                            delay: const Duration(milliseconds: 120),
                            style: textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const Width(4),
                          Flexible(
                            child: Text(context.l10n.profileStreakDaysSuffix),
                          ),
                        ],
                      ),
                    ),
                    const Height(2),
                    Text(
                      context.l10n.profileStreakBest(summary.bestStreak),
                      style: textTheme.bodySmall?.copyWith(
                        color: cs.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Height(14),
          StreakWeekProgress(
            activity: summary.weekActivity,
            dayLabels: _weekdayLabels(context),
          ),
        ],
      ),
    );
  }

  List<String> _weekdayLabels(BuildContext context) {
    final l10n = context.l10n;
    return [
      l10n.profileWeekdayMon,
      l10n.profileWeekdayTue,
      l10n.profileWeekdayWed,
      l10n.profileWeekdayThu,
      l10n.profileWeekdayFri,
      l10n.profileWeekdaySat,
      l10n.profileWeekdaySun,
    ];
  }
}

class _ExtraMetricsCard extends StatelessWidget {
  final ProfileSummaryEntity summary;

  const _ExtraMetricsCard({required this.summary});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final avg = summary.avgAnswersPerDay;

    return ContentCard(
      type: ContentCardType.large,
      child: Column(
        children: [
          _MetricRow(
            label: l10n.profileMetricAnswers,
            value: '${summary.answersTotal}',
          ),
          _MetricRow(
            label: l10n.profileMetricCards,
            value: '${summary.totalCards}',
          ),
          _MetricRow(
            label: l10n.profileMetricWeak,
            value: '${summary.weakCardsCount}',
          ),
          _MetricRow(
            label: l10n.profileMetricActiveDays,
            value: '${summary.activeDaysCount}',
          ),
          _MetricRow(
            label: l10n.profileMetricAvgPerDay,
            value: avg.toStringAsFixed(1),
            isLast: true,
          ),
        ],
      ),
    );
  }
}

class _MetricRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isLast;

  const _MetricRow({
    required this.label,
    required this.value,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: textTheme.bodyMedium?.copyWith(
                color: cs.onSurfaceVariant,
              ),
            ),
          ),
          Text(
            value,
            style: textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

/// Список настроек. Строка «Выйти» появляется только при сессии.
class _SettingsCard extends StatelessWidget {
  final VoidCallback onSettingsTap;
  final VoidCallback? onSignOutTap;

  const _SettingsCard({required this.onSettingsTap, this.onSignOutTap});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final signOut = onSignOutTap;

    return ContentCard(
      type: ContentCardType.smallWide,
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          _SettingsTile(
            icon: Icons.settings_outlined,
            label: context.l10n.settingsTitle,
            onTap: onSettingsTap,
          ),
          if (signOut != null) ...[
            Divider(height: 1, color: cs.outlineVariant, indent: 16, endIndent: 16),
            _SettingsTile(
              icon: Icons.logout,
              label: context.l10n.profileSignOutRow,
              color: cs.error,
              onTap: signOut,
            ),
          ],
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? color;

  const _SettingsTile({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final foreground = color ?? cs.onSurfaceVariant;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        child: Row(
          children: [
            Icon(icon, size: 22, color: foreground),
            const Width(16),
            Expanded(
              child: Text(
                label,
                style: textTheme.titleMedium?.copyWith(color: color),
              ),
            ),
            if (color == null)
              Icon(Icons.chevron_right, size: 20, color: cs.onSurfaceVariant),
          ],
        ),
      ),
    );
  }
}

class _ErrorContent extends StatelessWidget {
  final VoidCallback onRetry;

  const _ErrorContent({required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 48, color: cs.error),
            const Height(16),
            Text(
              context.l10n.profileLoadError,
              style: textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const Height(16),
            FilledButton(
              onPressed: onRetry,
              child: Text(context.l10n.profileRetryButton),
            ),
          ],
        ),
      ),
    );
  }
}
