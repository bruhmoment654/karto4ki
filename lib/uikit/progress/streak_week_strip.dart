import 'package:flutter/material.dart';

/// Недельная лента стрика: 7 чипов Пн..Вс. Активный день — заполненный кружок
/// с иконкой огня (`tertiaryContainer`), неактивный — контур `outlineVariant`
/// с точкой. Под каждым чипом — подпись дня из [dayLabels].
///
/// [activity] и [dayLabels] должны быть длиной 7 (Пн..Вс).
class StreakWeekStrip extends StatelessWidget {
  const StreakWeekStrip({
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
    return Row(
      children: [
        for (var i = 0; i < 7; i++)
          Expanded(
            child: _DayChip(
              isActive: activity[i],
              label: dayLabels[i],
            ),
          ),
      ],
    );
  }
}

class _DayChip extends StatelessWidget {
  const _DayChip({required this.isActive, required this.label});

  final bool isActive;
  final String label;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? cs.tertiaryContainer : Colors.transparent,
            border: isActive
                ? null
                : Border.all(color: cs.outlineVariant, width: 1.5),
          ),
          alignment: Alignment.center,
          child: isActive
              ? Icon(
                  Icons.local_fire_department,
                  size: 18,
                  color: cs.onTertiaryContainer,
                )
              : Text(
                  '·',
                  style: textTheme.labelSmall?.copyWith(
                    color: cs.onSurfaceVariant,
                  ),
                ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: textTheme.labelSmall?.copyWith(color: cs.onSurfaceVariant),
        ),
      ],
    );
  }
}
