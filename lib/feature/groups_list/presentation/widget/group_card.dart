import 'package:flutter/material.dart';

import 'package:quizzerg/feature/groups_list/domain/entity/test_group_entity.dart';
import 'package:quizzerg/feature/question_stats/domain/entity/study_progress_entity.dart';
import 'package:quizzerg/feature/question_stats/presentation/study_progress_format.dart';
import 'package:quizzerg/feature/question_stats/presentation/widgets/study_progress_chips.dart';
import 'package:quizzerg/l10n/app_localizations_x.dart';
import 'package:quizzerg/uikit/app_radii.dart';
import 'package:quizzerg/uikit/chip/app_stat_chip.dart';
import 'package:quizzerg/uikit/content_card/content_card.dart';
import 'package:quizzerg/uikit/pressable/scale_pressable.dart';
import 'package:quizzerg/uikit/progress/app_accuracy_ring.dart';
import 'package:quizzerg/uikit/spacing/height.dart';
import 'package:quizzerg/uikit/spacing/width.dart';
import 'package:quizzerg/uikit/theme/app_colors.dart';
import 'package:quizzerg/uikit/theme/app_theme.dart';

/// Карточка группы на главной: название, число тестов, когда занимались,
/// плашки прогресса и кольцо точности.
///
/// Тональный цвет берётся из пула по позиции [index] в списке и меняется
/// вместе с порядком групп.
class GroupCard extends StatelessWidget {
  final TestGroupEntity group;
  final int index;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const GroupCard({
    required this.group,
    required this.index,
    required this.onTap,
    required this.onLongPress,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final pool = Theme.of(context).colorScheme.groupCardPool;
    final (background, foreground) = pool[index % pool.length];
    final ink = AppColors.of(context).inkOn(foreground);
    final progress = group.progress;

    return ScalePressable(
      onTap: onTap,
      child: GestureDetector(
        onLongPress: onLongPress,
        child: ContentCard(
          backgroundColor: background,
          borderRadius: BorderRadius.circular(AppDimens.radius28),
          padding: const EdgeInsets.fromLTRB(20, 18, 18, 18),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      group.title,
                      style: textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: foreground,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Height(2),
                    _GroupCardSubtitle(group: group, color: foreground),
                    StudyProgressChips(
                      progress: progress,
                      inkColor: ink,
                      textColor: foreground,
                      leading: [
                        if (group.testCount == 0)
                          AppStatChip(
                            icon: Icons.add_rounded,
                            label: context.l10n.groupsListAddTest,
                            color: ink,
                            textColor: foreground,
                          )
                        else if (_isNotStarted(progress))
                          AppStatChip(
                            icon: Icons.flag_rounded,
                            label: context.l10n.groupsListNotStarted,
                            color: ink,
                            textColor: foreground,
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              const Width(14),
              if (progress.accuracy case final accuracy?)
                AppAccuracyRing(
                  value: accuracy,
                  color: ink,
                  textColor: foreground,
                )
              else
                Icon(
                  Icons.chevron_right,
                  size: 24,
                  color: foreground.withValues(alpha: 0.6),
                ),
            ],
          ),
        ),
      ),
    );
  }

  /// Тесты есть, а вопросов в них нет — для пользователя это тоже «не начат».
  bool _isNotStarted(StudyProgressEntity progress) =>
      progress.isNotStarted || progress.total == 0;
}

/// «10 тестов · занимались 2 дня назад» или «Нет тестов».
class _GroupCardSubtitle extends StatelessWidget {
  final TestGroupEntity group;
  final Color color;

  const _GroupCardSubtitle({required this.group, required this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      StudyProgressFormat.groupSubtitle(
        l10n: context.l10n,
        testCount: group.testCount,
        lastStudiedAt: group.progress.lastStudiedAt,
        now: DateTime.now(),
      ),
      style: Theme.of(
        context,
      ).textTheme.bodyMedium?.copyWith(color: color.withValues(alpha: 0.78)),
    );
  }
}
