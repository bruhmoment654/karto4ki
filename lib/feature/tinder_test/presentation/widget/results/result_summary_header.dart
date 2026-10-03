import 'package:flutter/material.dart';
import 'package:quizzerg/feature/test_execution/domain/entity/attempt_summary.dart';
import 'package:quizzerg/l10n/app_localizations_x.dart';
import 'package:quizzerg/uikit/app_radii.dart';
import 'package:quizzerg/uikit/motion/app_animated_size.dart';
import 'package:quizzerg/uikit/motion/app_animated_switcher.dart';
import 'package:quizzerg/uikit/progress/liquid_score_ring.dart';
import 'package:quizzerg/uikit/spacing/width.dart';
import 'package:quizzerg/uikit/theme/app_colors.dart';

/// Сводка результата: компактное кольцо, заголовок по порогу и чип —
/// сравнение с прошлым разом или отметка первого прохождения.
class ResultSummaryHeader extends StatelessWidget {
  final int correct;
  final int total;

  /// `null` — сводка ещё пишется, чип появится позже.
  final AttemptSummary? summary;

  const ResultSummaryHeader({
    required this.correct,
    required this.total,
    required this.summary,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final pct = total > 0 ? correct / total * 100 : 0.0;

    return Row(
      children: [
        LiquidScoreRing(pct: pct, correct: correct, total: total, size: 132),
        const Width(18),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _bandTitle(context, pct.round()),
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
              ),
              AppAnimatedSize(
                alignment: Alignment.topLeft,
                child: AppAnimatedSwitcher(
                  alignment: Alignment.topLeft,
                  child: _SummaryChip(summary: summary),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// По округлённому проценту — тому, что показывает кольцо: иначе при
  /// 89,5% кольцо покажет «90%», а заголовок — «Хорошая работа!».
  String _bandTitle(BuildContext context, int percent) {
    if (percent >= 90) return context.l10n.tinderTestResultsTitleGreat;
    if (percent >= 60) return context.l10n.tinderTestResultsTitleGood;
    return context.l10n.tinderTestResultsTitleRetry;
  }
}

/// Чип под заголовком; без истории — пусто.
class _SummaryChip extends StatelessWidget {
  final AttemptSummary? summary;

  const _SummaryChip({required this.summary});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final colors = AppColors.of(context);
    final summary = this.summary;
    if (summary == null || !summary.hasHistory) {
      return const SizedBox(key: ValueKey('none'), width: double.infinity);
    }

    final delta = summary.percentDelta;
    if (delta == null) {
      return _InfoChip(
        key: const ValueKey('first'),
        icon: Icons.flag,
        label: context.l10n.tinderTestResultsFirstAttempt,
        background: colorScheme.secondaryContainer,
        iconColor: colorScheme.onSecondaryContainer,
        textColor: colorScheme.onSecondaryContainer,
      );
    }

    if (delta == 0) {
      return _InfoChip(
        key: const ValueKey('same'),
        icon: Icons.trending_flat,
        label: context.l10n.tinderTestResultsDeltaSame,
        background: colorScheme.surfaceContainerHigh,
        iconColor: colorScheme.onSurfaceVariant,
        textColor: colorScheme.onSurface,
      );
    }

    final isUp = delta > 0;
    final tone = isUp ? colors.success : colorScheme.error;
    return _InfoChip(
      key: const ValueKey('delta'),
      icon: isUp ? Icons.trending_up : Icons.trending_down,
      // Знак — в строке: у падения типографский минус, а не дефис.
      label: isUp
          ? context.l10n.tinderTestResultsDeltaUp(delta)
          : context.l10n.tinderTestResultsDeltaDown(delta.abs()),
      background: tone.withValues(alpha: 0.18),
      iconColor: tone,
      textColor: colorScheme.onSurface,
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color background;
  final Color iconColor;
  final Color textColor;

  const _InfoChip({
    required this.icon,
    required this.label,
    required this.background,
    required this.iconColor,
    required this.textColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // На узком экране подпись переносится, а не обрезается: колонка рядом
    // с кольцом всего около 200 px.
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        constraints: const BoxConstraints(minHeight: 32),
        padding: const EdgeInsets.fromLTRB(8, 6, 12, 6),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(AppDimens.radius8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18, color: iconColor),
            const Width(6),
            Flexible(
              child: Text(
                label,
                style: Theme.of(
                  context,
                ).textTheme.labelLarge?.copyWith(color: textColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
