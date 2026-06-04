import 'package:flutter/material.dart';
import 'package:quizzerg/feature/tinder_test/domain/entity/test_session.dart';
import 'package:quizzerg/feature/tinder_test/presentation/tinder_test_screen.dart';
import 'package:quizzerg/l10n/app_localizations_x.dart';
import 'package:quizzerg/uikit/app_radii.dart';
import 'package:quizzerg/uikit/motion/count_up_text.dart';
import 'package:quizzerg/uikit/progress/liquid_score_ring.dart';
import 'package:quizzerg/uikit/spacing/height.dart';
import 'package:quizzerg/uikit/spacing/width.dart';
import 'package:quizzerg/uikit/theme/app_theme.dart';

/// Экран результата (вариант B): жидкая заливка-кольцо со спектральным цветом
/// и count-up чипами «верно/ошибки».
class ResultsContent extends StatelessWidget {
  final TestSession session;
  final ITinderTestViewModel viewModel;

  const ResultsContent({
    required this.session,
    required this.viewModel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final total = session.cards.length;
    final correct = session.correctCount;
    final pct = total > 0 ? correct / total * 100 : 0.0;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              context.l10n.tinderTestResultsTitle,
              textAlign: TextAlign.center,
              style: textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const Height(28),
            LiquidScoreRing(
              pct: pct,
              correct: correct,
              total: total,
              icon: _bandIcon(pct),
            ),
            const Height(32),
            Row(
              children: [
                Expanded(
                  child: _StatChip(
                    icon: Icons.check_circle,
                    label: context.l10n.tinderTestResultsCorrectLabel,
                    value: correct,
                    color: Theme.of(context).colorScheme.success,
                  ),
                ),
                const Width(12),
                Expanded(
                  child: _StatChip(
                    icon: Icons.cancel,
                    label: context.l10n.tinderTestResultsIncorrectLabel,
                    value: session.incorrectCount,
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              ],
            ),
            const Height(32),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: viewModel.onBackPressed,
                icon: const Icon(Icons.done),
                label: Text(context.l10n.tinderTestResultsDoneButton),
                style: FilledButton.styleFrom(
                  minimumSize: const Size(0, 56),
                ),
              ),
            ),
            const Height(8),
            TextButton.icon(
              onPressed: viewModel.onRestartPressed,
              icon: const Icon(Icons.refresh),
              label: Text(context.l10n.tinderTestResultsRestartButton),
            ),
          ],
        ),
      ),
    );
  }

  /// Иконка по диапазону результата.
  IconData _bandIcon(double pct) {
    if (pct >= 90) return Icons.emoji_events;
    if (pct >= 60) return Icons.workspace_premium;
    return Icons.trending_up;
  }
}

/// Чип со счётчиком (верно/ошибки): иконка, подпись и count-up число.
class _StatChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final int value;
  final Color color;

  const _StatChip({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(AppDimens.radius16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: color),
              const Width(8),
              Text(label, style: textTheme.labelLarge),
            ],
          ),
          const Height(8),
          CountUpText(
            value: value,
            style: textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
