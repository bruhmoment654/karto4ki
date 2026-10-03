import 'package:flutter/material.dart';
import 'package:quizzerg/uikit/progress/app_linear_progress.dart';
import 'package:quizzerg/uikit/spacing/height.dart';

/// Недельный стрик: линейный индикатор «активных дней из 7» и подписи дней
/// Пн..Вс под ним. Активный день — подпись `onSurface` жирным, неактивный —
/// `onSurfaceVariant`.
///
/// [activity] и [dayLabels] должны быть длиной 7 (Пн..Вс).
class StreakWeekProgress extends StatelessWidget {
  const StreakWeekProgress({
    required this.activity,
    required this.dayLabels,
    super.key,
  }) : assert(
          activity.length == 7 && dayLabels.length == 7,
          'activity и dayLabels должны быть длиной 7',
        );

  /// Активность по дням недели Пн..Вс (true — день засчитан).
  final List<bool> activity;

  /// Короткие подписи дней Пн..Вс.
  final List<String> dayLabels;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final activeCount = activity.where((isActive) => isActive).length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppLinearProgress(
          value: activeCount / 7,
          color: cs.tertiary,
          trackColor: cs.surfaceContainerHigh,
        ),
        const Height(8),
        Row(
          children: [
            for (var i = 0; i < 7; i++)
              Expanded(
                child: _DayLabel(label: dayLabels[i], isActive: activity[i]),
              ),
          ],
        ),
      ],
    );
  }
}

class _DayLabel extends StatelessWidget {
  const _DayLabel({required this.label, required this.isActive});

  final String label;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Text(
      label,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: isActive ? cs.onSurface : cs.onSurfaceVariant,
            fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
          ),
    );
  }
}
