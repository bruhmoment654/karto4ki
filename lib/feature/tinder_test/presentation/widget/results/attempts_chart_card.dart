import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quizzerg/feature/test_execution/domain/entity/attempt_summary.dart';
import 'package:quizzerg/feature/test_execution/domain/entity/test_attempt_entity.dart';
import 'package:quizzerg/l10n/app_localizations_x.dart';
import 'package:quizzerg/uikit/app_radii.dart';
import 'package:quizzerg/uikit/motion/app_motion.dart';
import 'package:quizzerg/uikit/spacing/height.dart';
import 'package:quizzerg/uikit/spacing/width.dart';

/// «Последние прохождения»: столбики процентов, текущее — справа.
///
/// Слотов всегда [AttemptSummary.historyLength]: при меньшем числе
/// прохождений пустые слоты слева, ширина столбиков не прыгает.
class AttemptsChartCard extends StatelessWidget {
  final AttemptSummary summary;

  const AttemptsChartCard({required this.summary, super.key});

  static const _slotGap = 10.0;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final attempts = summary.recentAttempts;
    final emptySlots = AttemptSummary.historyLength - attempts.length;
    final slots = <TestAttemptEntity?>[
      for (var i = 0; i < emptySlots; i++) null,
      ...attempts,
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(AppDimens.radius28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Expanded(
                child: Text(
                  context.l10n.tinderTestResultsRecentAttempts,
                  style: textTheme.titleMedium,
                ),
              ),
              Text(
                context.l10n.tinderTestResultsAttemptsCount(
                  attempts.length,
                  summary.totalAttempts,
                ),
                style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          const Height(14),
          _SlotsRow(
            slots: slots,
            builder: (attempt, {required isCurrent}) =>
                _AttemptBar(percent: attempt.percent, isCurrent: isCurrent),
          ),
          const Height(6),
          _SlotsRow(
            slots: slots,
            builder: (attempt, {required isCurrent}) => Text(
              isCurrent
                  ? context.l10n.tinderTestResultsAttemptNow
                  : DateFormat.Md(
                      context.l10n.localeName,
                    ).format(attempt.completedAt),
              textAlign: TextAlign.center,
              maxLines: 1,
              style: textTheme.labelSmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Ряд из слотов равной ширины; пустой слот ничего не рисует.
class _SlotsRow extends StatelessWidget {
  final List<TestAttemptEntity?> slots;
  final Widget Function(TestAttemptEntity attempt, {required bool isCurrent})
  builder;

  const _SlotsRow({required this.slots, required this.builder});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        for (var i = 0; i < slots.length; i++) ...[
          if (i > 0) const Width(AttemptsChartCard._slotGap),
          Expanded(
            child: switch (slots[i]) {
              final attempt? => builder(
                attempt,
                isCurrent: i == slots.length - 1,
              ),
              null => const SizedBox.shrink(),
            },
          ),
        ],
      ],
    );
  }
}

/// Столбик с подписью процента; растёт при появлении.
class _AttemptBar extends StatelessWidget {
  final int percent;
  final bool isCurrent;

  const _AttemptBar({required this.percent, required this.isCurrent});

  static const _maxBarHeight = 60.0;
  static const _minBarHeight = 4.0;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final target = math.max(_minBarHeight, _maxBarHeight * percent / 100);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$percent%',
          maxLines: 1,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: isCurrent
                ? colorScheme.onSurface
                : colorScheme.onSurfaceVariant,
            fontWeight: isCurrent ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
        const Height(6),
        TweenAnimationBuilder<double>(
          tween: Tween(begin: _minBarHeight, end: target),
          duration: AppMotion.reduced(context)
              ? Duration.zero
              : AppMotion.medium,
          curve: AppMotion.emphasized,
          builder: (context, height, _) => Container(
            height: height,
            decoration: BoxDecoration(
              color: isCurrent
                  ? colorScheme.primary
                  : colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(AppDimens.radius8),
            ),
          ),
        ),
      ],
    );
  }
}
