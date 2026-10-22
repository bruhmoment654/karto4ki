import 'package:flutter/material.dart';

import 'package:quizzerg/feature/question_stats/presentation/widgets/study_progress_chips.dart';
import 'package:quizzerg/feature/tests_list/domain/entity/test_entity.dart';
import 'package:quizzerg/l10n/app_localizations_x.dart';
import 'package:quizzerg/uikit/app_radii.dart';
import 'package:quizzerg/uikit/chip/app_stat_chip.dart';
import 'package:quizzerg/uikit/progress/app_accuracy_ring.dart';
import 'package:quizzerg/uikit/spacing/width.dart';
import 'package:quizzerg/uikit/theme/app_colors.dart';

/// Карточка теста в группе: название, описание, число вопросов, плашки
/// прогресса и кольцо точности.
///
/// У пустого теста вместо кольца кнопка «Добавить» — она ведёт туда же, куда
/// тап по карточке: на экран теста, где импортируют и добавляют карточки.
class TestStatsCard extends StatelessWidget {
  final TestEntity test;
  final VoidCallback onAddCardsPressed;

  const TestStatsCard({
    required this.test,
    required this.onAddCardsPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final ink = AppColors.of(context).inkOn(colorScheme.onSurface);
    final progress = test.progress;
    final isEmpty = test.questionCount == 0;
    final secondaryStyle = theme.textTheme.bodySmall?.copyWith(
      color: colorScheme.onSurfaceVariant,
    );

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 14, 12),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(AppDimens.radius16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  test.title,
                  style: theme.textTheme.titleMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                if (test.description case final description?
                    when description.isNotEmpty)
                  Text(
                    description,
                    style: secondaryStyle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                Text(
                  context.l10n.groupDetailQuestionCount(test.questionCount),
                  style: secondaryStyle,
                ),
                if (!isEmpty)
                  StudyProgressChips(
                    progress: progress,
                    inkColor: ink,
                    textColor: colorScheme.onSurface,
                    topSpacing: 8,
                    leading: [
                      if (progress.isNotStarted)
                        AppStatChip(
                          icon: Icons.flag_rounded,
                          label: context.l10n.groupDetailTestNotStarted,
                          color: ink,
                          textColor: colorScheme.onSurface,
                        ),
                    ],
                  ),
              ],
            ),
          ),
          if (isEmpty)
            TextButton.icon(
              onPressed: onAddCardsPressed,
              icon: const Icon(Icons.add_rounded),
              label: Text(context.l10n.groupDetailTestAddCards),
            )
          else if (progress.accuracy case final accuracy?) ...[
            const Width(12),
            AppAccuracyRing(
              value: accuracy,
              color: AppColors.of(context).inkOn(colorScheme.primary),
              textColor: colorScheme.onSurface,
              size: AppAccuracyRingSize.small,
            ),
          ],
        ],
      ),
    );
  }
}
