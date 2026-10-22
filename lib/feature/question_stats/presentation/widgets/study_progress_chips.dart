import 'package:flutter/material.dart';
import 'package:quizzerg/feature/question_stats/domain/entity/study_progress_entity.dart';
import 'package:quizzerg/l10n/app_localizations_x.dart';
import 'package:quizzerg/uikit/chip/app_stat_chip.dart';

/// Ряд плашек статистики на карточке группы или теста.
///
/// Сначала [leading] (состояние карточки: «Не начат», «Добавить тест»),
/// затем не больше двух плашек прогресса: «Отличная точность», «N слабых»,
/// «N новых». У не начатого прогресса плашек прогресса нет — все вопросы
/// новые, и это уже сказано в [leading]. Пустой ряд не занимает места.
class StudyProgressChips extends StatelessWidget {
  static const _maxProgressChips = 2;

  final StudyProgressEntity progress;

  /// Цвет иконок и фона плашек.
  final Color inkColor;

  /// Цвет текста обычных плашек.
  final Color textColor;
  final List<Widget> leading;

  /// Отступ над рядом, если он не пустой.
  final double topSpacing;

  const StudyProgressChips({
    required this.progress,
    required this.inkColor,
    required this.textColor,
    this.leading = const [],
    this.topSpacing = 12,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final chips = <Widget>[
      ...leading,
      if (!progress.isNotStarted)
        ...[
          if (progress.isGreatAccuracy)
            AppStatChip(
              icon: Icons.star_rounded,
              label: l10n.progressGreatAccuracy,
              color: inkColor,
              textColor: textColor,
              isAccent: true,
            ),
          if (progress.weakCount > 0)
            AppStatChip(
              icon: Icons.priority_high_rounded,
              label: l10n.progressWeakCount(progress.weakCount),
              color: inkColor,
              textColor: textColor,
            ),
          if (progress.newCount > 0)
            AppStatChip(
              icon: Icons.fiber_new_rounded,
              label: l10n.progressNewCount(progress.newCount),
              color: inkColor,
              textColor: textColor,
            ),
        ].take(_maxProgressChips),
    ];
    if (chips.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.only(top: topSpacing),
      child: Wrap(spacing: 6, runSpacing: 6, children: chips),
    );
  }
}
