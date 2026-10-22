import 'package:flutter/material.dart';

import 'package:quizzerg/feature/question_stats/domain/entity/study_progress_entity.dart';
import 'package:quizzerg/l10n/app_localizations_x.dart';
import 'package:quizzerg/uikit/app_radii.dart';
import 'package:quizzerg/uikit/progress/app_accuracy_ring.dart';
import 'package:quizzerg/uikit/spacing/height.dart';
import 'package:quizzerg/uikit/spacing/width.dart';
import 'package:quizzerg/uikit/theme/app_colors.dart';

/// Сводка группы: кольцо точности и вопросы по состояниям.
///
/// Без точности (ещё не проходили на этом устройстве) кольцо пустое с «—»,
/// а плашки состояний показываются всегда.
class GroupSummaryCard extends StatelessWidget {
  final StudyProgressEntity progress;

  const GroupSummaryCard({required this.progress, super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final ink = AppColors.of(context).inkOn(colorScheme.primary);
    final l10n = context.l10n;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(AppDimens.radius28),
      ),
      child: Row(
        children: [
          AppAccuracyRing(
            value: progress.accuracy,
            color: ink,
            textColor: colorScheme.onSurface,
            size: AppAccuracyRingSize.large,
          ),
          const Width(16),
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    _StateTile(
                      icon: Icons.workspace_premium_rounded,
                      label: l10n.groupDetailMastered,
                      count: progress.masteredCount,
                      ink: ink,
                    ),
                    const Width(8),
                    _StateTile(
                      icon: Icons.school_rounded,
                      label: l10n.groupDetailLearning,
                      count: progress.learningCount,
                      ink: ink,
                    ),
                  ],
                ),
                const Height(8),
                Row(
                  children: [
                    _StateTile(
                      icon: Icons.priority_high_rounded,
                      label: l10n.groupDetailWeak,
                      count: progress.weakCount,
                      ink: ink,
                    ),
                    const Width(8),
                    _StateTile(
                      icon: Icons.fiber_new_rounded,
                      label: l10n.groupDetailNew,
                      count: progress.newCount,
                      ink: ink,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Плашка «иконка + подпись / число» в сетке сводки.
class _StateTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final int count;
  final Color ink;

  const _StateTile({
    required this.icon,
    required this.label,
    required this.count,
    required this.ink,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(AppDimens.radius12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 15, color: ink),
                const Width(5),
                Flexible(
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
            const Height(2),
            Text(
              '$count',
              style: theme.textTheme.titleMedium?.copyWith(
                fontSize: 17,
                fontWeight: FontWeight.w800,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
