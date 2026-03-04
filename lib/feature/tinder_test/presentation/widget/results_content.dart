import 'package:flutter/material.dart';
import 'package:quizzerg/feature/tinder_test/domain/entity/test_session.dart';
import 'package:quizzerg/feature/tinder_test/presentation/tinder_test_screen.dart';
import 'package:quizzerg/l10n/app_localizations_x.dart';
import 'package:quizzerg/uikit/content_card/content_card.dart';
import 'package:quizzerg/uikit/content_card/content_card_type.dart';
import 'package:quizzerg/uikit/theme/app_theme.dart';

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
    final colorScheme = Theme.of(context).colorScheme;
    final total = session.cards.length;
    final correct = session.correctCount;
    final percentage = total > 0 ? (correct / total * 100).round() : 0;

    const buttonShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
    );

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.emoji_events,
              size: 80,
              color: colorScheme.tertiary,
            ),
            const SizedBox(height: 24),
            Text(
              context.l10n.tinderTestResultsTitle,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 32),
            ContentCard(
              type: ContentCardType.medium,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _ResultRow(
                    icon: Icons.check_circle,
                    color: colorScheme.primary,
                    label: context.l10n.tinderTestResultsCorrectLabel,
                    value: correct.toString(),
                  ),
                  const SizedBox(height: 16),
                  _ResultRow(
                    icon: Icons.cancel,
                    color: colorScheme.error,
                    label: context.l10n.tinderTestResultsIncorrectLabel,
                    value: session.incorrectCount.toString(),
                  ),
                  const SizedBox(height: 16),
                  _ResultRow(
                    icon: Icons.percent,
                    color: colorScheme.info,
                    label: context.l10n.tinderTestResultsPercentageLabel,
                    value: '$percentage%',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 48),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton.icon(
                  onPressed: viewModel.onRestartPressed,
                  icon: const Icon(Icons.refresh),
                  label: Text(context.l10n.tinderTestResultsRestartButton),
                  style: OutlinedButton.styleFrom(shape: buttonShape),
                ),
                const SizedBox(width: 16),
                ElevatedButton.icon(
                  onPressed: viewModel.onBackPressed,
                  icon: const Icon(Icons.done),
                  label: Text(context.l10n.tinderTestResultsDoneButton),
                  style: ElevatedButton.styleFrom(shape: buttonShape),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ResultRow extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final String value;

  const _ResultRow({
    required this.icon,
    required this.color,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: color, size: 32),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
