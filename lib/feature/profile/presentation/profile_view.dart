import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:quizzerg/feature/profile/domain/entity/profile_summary_entity.dart';
import 'package:quizzerg/feature/profile/presentation/profile_screen.dart';
import 'package:quizzerg/l10n/app_localizations_x.dart';
import 'package:quizzerg/uikit/appbar/app_page_header.dart';
import 'package:quizzerg/uikit/content_card/content_card.dart';
import 'package:quizzerg/uikit/content_card/content_card_type.dart';
import 'package:quizzerg/uikit/motion/count_up_text.dart';
import 'package:quizzerg/uikit/motion/staggered_appear.dart';
import 'package:quizzerg/uikit/pressable/scale_pressable.dart';
import 'package:quizzerg/uikit/progress/fill_ring.dart';
import 'package:quizzerg/uikit/progress/streak_week_strip.dart';
import 'package:quizzerg/uikit/scaffold/app_scaffold.dart';
import 'package:quizzerg/uikit/spacing/height.dart';
import 'package:quizzerg/uikit/theme/app_theme.dart';

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
    if (viewModel.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final error = viewModel.error;
    if (error != null) {
      return _ErrorContent(onRetry: viewModel.onRetryTap);
    }

    final summary = viewModel.summary;
    if (summary == null) {
      return _ErrorContent(onRetry: viewModel.onRetryTap);
    }

    return Column(
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
                  _IdentityCard(
                    summary: summary,
                    onTap: viewModel.onIdentityTap,
                  ),
                  const Height(14),
                  _StatsSummaryCard(
                    summary: summary,
                    onTap: viewModel.onStatsTap,
                  ),
                  const Height(14),
                  _StreakCard(summary: summary),
                  const Height(14),
                  _ExtraMetricsCard(summary: summary),
                  const Height(14),
                  _SettingsRow(onTap: viewModel.onSettingsTap),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _IdentityCard extends StatelessWidget {
  final ProfileSummaryEntity summary;
  final VoidCallback onTap;

  const _IdentityCard({required this.summary, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final name = context.l10n.profileIdentityName;

    return ScalePressable(
      onTap: onTap,
      child: ContentCard(
        type: ContentCardType.large,
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: cs.primary,
              ),
              alignment: Alignment.center,
              child: Text(
                name.isEmpty ? '?' : name.characters.first.toUpperCase(),
                style: textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: cs.onPrimary,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Height(2),
                  Text(
                    context.l10n.profileIdentitySubtitle(
                      summary.groupsCount,
                      summary.testsCount,
                    ),
                    style: textTheme.bodyMedium?.copyWith(
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: cs.onSurfaceVariant),
          ],
        ),
      ),
    );
  }
}

class _StatsSummaryCard extends StatelessWidget {
  final ProfileSummaryEntity summary;
  final VoidCallback onTap;

  const _StatsSummaryCard({required this.summary, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return ScalePressable(
      onTap: onTap,
      child: ContentCard(
        type: ContentCardType.large,
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.insights, size: 22, color: cs.primary),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    context.l10n.profileStatsCardTitle,
                    style: textTheme.titleMedium,
                  ),
                ),
                Text(
                  context.l10n.profileStatsCardMore,
                  style: textTheme.labelLarge?.copyWith(color: cs.primary),
                ),
                Icon(Icons.chevron_right, size: 20, color: cs.primary),
              ],
            ),
            const Height(18),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: FillRing(
                    percent: summary.accuracyPercent,
                    color: cs.success,
                    label: context.l10n.profileRingAccuracy,
                    sub: '${summary.correctTotal}/${summary.answersTotal}',
                    animationDelay: const Duration(milliseconds: 120),
                  ),
                ),
                Expanded(
                  child: FillRing(
                    percent: summary.masteredPercent,
                    color: cs.primary,
                    label: context.l10n.profileRingMastered,
                    sub: '${summary.masteredCount}/${summary.totalCards}',
                    animationDelay: const Duration(milliseconds: 240),
                  ),
                ),
                Expanded(
                  child: FillRing(
                    percent: summary.flawlessPercent,
                    color: cs.warning,
                    label: context.l10n.profileRingFlawless,
                    sub: '${summary.flawlessCount}/${summary.totalCards}',
                    animationDelay: const Duration(milliseconds: 360),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
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
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: cs.tertiaryContainer,
                  borderRadius: BorderRadius.circular(14),
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.local_fire_department,
                  size: 26,
                  color: cs.onTertiaryContainer,
                ),
              ),
              const SizedBox(width: 14),
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
                            style: textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(width: 4),
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
          const Height(12),
          StreakWeekStrip(
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

class _SettingsRow extends StatelessWidget {
  final VoidCallback onTap;

  const _SettingsRow({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return ScalePressable(
      onTap: onTap,
      child: ContentCard(
        type: ContentCardType.smallWide,
        child: Row(
          children: [
            Icon(Icons.settings_outlined, color: cs.onSurfaceVariant),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                context.l10n.settingsTitle,
                style: textTheme.titleMedium,
              ),
            ),
            Icon(Icons.chevron_right, color: cs.onSurfaceVariant),
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
