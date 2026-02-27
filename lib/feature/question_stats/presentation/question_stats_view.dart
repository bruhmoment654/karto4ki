import 'package:flutter/material.dart';
import 'package:quizzerg/feature/question_stats/domain/entity/question_stats_entity.dart';
import 'package:quizzerg/feature/question_stats/presentation/question_stats_screen.dart';
import 'package:quizzerg/l10n/app_localizations_x.dart';
import 'package:quizzerg/uikit/appbar/karto4ki_app_bar.dart';
import 'package:quizzerg/uikit/content_card/content_card.dart';
import 'package:quizzerg/uikit/content_card/content_card_type.dart';
import 'package:quizzerg/uikit/scaffold/app_scaffold.dart';

class QuestionStatsView extends StatelessWidget {
  final IQuestionStatsViewModel viewModel;

  const QuestionStatsView({required this.viewModel, super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: DefaultAppBar(title: context.l10n.questionStatsTitle),
      body: _Body(viewModel: viewModel),
    );
  }
}

class _Body extends StatelessWidget {
  final IQuestionStatsViewModel viewModel;

  const _Body({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    if (viewModel.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (viewModel.error != null) {
      return _ErrorContent(
        error: viewModel.error!,
        onRetry: viewModel.onRetryTap,
      );
    }

    final stats = viewModel.stats;
    if (stats == null || stats.isEmpty) {
      return _EmptyContent();
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      itemCount: stats.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) => _StatsCard(stat: stats[index]),
    );
  }
}

class _ErrorContent extends StatelessWidget {
  final Object error;
  final VoidCallback onRetry;

  const _ErrorContent({required this.error, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$error',
              style: theme.textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: onRetry,
              child: Text(context.l10n.testsListRetryButton),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          context.l10n.questionStatsEmptyMessage,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class _StatsCard extends StatelessWidget {
  final QuestionStatsEntity stat;

  const _StatsCard({required this.stat});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;
    final total = stat.totalCorrect + stat.totalIncorrect;
    final accuracy = total > 0 ? (stat.totalCorrect / total * 100).round() : 0;

    return ContentCard(
      elevation: 5,
      type: ContentCardType.smallWide,
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    stat.frontText,
                    style: theme.textTheme.titleMedium,
                    textAlign: TextAlign.end,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '—',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    stat.backText,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 16, thickness: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                _StatChip(
                  value: '${stat.totalCorrect}',
                  label: l10n.questionStatsCorrectLabel,
                  valueColor: Colors.green,
                ),
                _StatChip(
                  value: '${stat.totalIncorrect}',
                  label: l10n.questionStatsIncorrectLabel,
                  valueColor: Colors.red,
                ),
                _StatChip(
                  value: '${stat.streak}',
                  label: l10n.questionStatsStreakLabel,
                  valueColor: theme.colorScheme.primary,
                ),
                _StatChip(
                  value: '$accuracy%',
                  label: l10n.questionStatsAccuracyLabel,
                  valueColor: theme.colorScheme.tertiary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String value;
  final String label;
  final Color valueColor;

  const _StatChip({
    required this.value,
    required this.label,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: theme.textTheme.titleMedium?.copyWith(color: valueColor),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
