import 'package:flutter/material.dart';
import 'package:quizzerg/feature/question_stats/domain/entity/question_stats_entity.dart';
import 'package:quizzerg/feature/question_stats/domain/entity/question_stats_sort.dart';
import 'package:quizzerg/feature/question_stats/presentation/question_stats_screen.dart';
import 'package:quizzerg/l10n/app_localizations_x.dart';
import 'package:quizzerg/uikit/appbar/karto4ki_app_bar.dart';
import 'package:quizzerg/uikit/content_card/content_card.dart';
import 'package:quizzerg/uikit/content_card/content_card_type.dart';
import 'package:quizzerg/uikit/pressable/scale_pressable.dart';
import 'package:quizzerg/uikit/scaffold/app_scaffold.dart';

class QuestionStatsView extends StatelessWidget {
  final IQuestionStatsViewModel viewModel;

  const QuestionStatsView({required this.viewModel, super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: DefaultAppBar(title: Text(context.l10n.questionStatsTitle)),
      body: _Body(viewModel: viewModel),
      floatingActionButton: _ScrollToTopFab(viewModel: viewModel),
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

    return CustomScrollView(
      controller: viewModel.scrollController,
      slivers: [
        SliverToBoxAdapter(child: _SortPanel(viewModel: viewModel)),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverList.separated(
            itemCount: stats.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (_, index) => _StatsCard(stat: stats[index]),
          ),
        ),
        const SliverPadding(padding: EdgeInsets.only(bottom: 24)),
      ],
    );
  }
}

class _SortPanel extends StatelessWidget {
  final IQuestionStatsViewModel viewModel;

  const _SortPanel({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final sortLabel = switch (viewModel.currentSort) {
      QuestionStatsSort.byDate => l10n.questionStatsSortByDate,
      QuestionStatsSort.byStreak => l10n.questionStatsSortByStreak,
      QuestionStatsSort.byAccuracy => l10n.questionStatsSortByAccuracy,
    };
    final isAsc = viewModel.sortOrder == SortOrder.ascending;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Row(
        children: [
          ActionChip(
            avatar: const Icon(Icons.sort, size: 18),
            label: Text(
              sortLabel,
              style: theme.textTheme.bodyMedium,
            ),
            onPressed: viewModel.onSortTap,
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: Icon(isAsc ? Icons.arrow_upward : Icons.arrow_downward),
            onPressed: viewModel.onSortOrderTap,
            visualDensity: VisualDensity.compact,
          ),
        ],
      ),
    );
  }
}

class _ScrollToTopFab extends StatelessWidget {
  final IQuestionStatsViewModel viewModel;

  const _ScrollToTopFab({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: viewModel.showScrollToTop ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 200),
      child: AnimatedOpacity(
        opacity: viewModel.showScrollToTop ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 200),
        child: FloatingActionButton.small(
          onPressed: viewModel.onScrollToTopTap,
          child: const Icon(Icons.keyboard_arrow_up),
        ),
      ),
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

class _StatsCard extends StatefulWidget {
  final QuestionStatsEntity stat;

  const _StatsCard({required this.stat});

  @override
  State<_StatsCard> createState() => _StatsCardState();
}

class _StatsCardState extends State<_StatsCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final stat = widget.stat;
    final theme = Theme.of(context);
    final l10n = context.l10n;
    final total = stat.totalCorrect + stat.totalIncorrect;
    final accuracy = total > 0 ? (stat.totalCorrect / total * 100).round() : 0;

    final values = [
      '${stat.totalCorrect}',
      '${stat.totalIncorrect}',
      '${stat.streak}',
      '$accuracy%',
    ];
    final labels = [
      l10n.questionStatsCorrectLabel,
      l10n.questionStatsIncorrectLabel,
      l10n.questionStatsStreakLabel,
      l10n.questionStatsAccuracyLabel,
    ];
    final colors = [
      Colors.green,
      Colors.red,
      theme.colorScheme.primary,
      theme.colorScheme.tertiary,
    ];
    final questionText = '${stat.frontText} — ${stat.backText}';

    return ScalePressable(
      onTap: () => setState(() => _isExpanded = !_isExpanded),
      child: ContentCard(
        elevation: 5,
        type: ContentCardType.smallWide,
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: AnimatedCrossFade(
          firstChild: _ExpandedCardContent(
            questionText: questionText,
            values: values,
            labels: labels,
            colors: colors,
          ),
          secondChild: _CollapsedCardContent(
            questionText: questionText,
            values: values,
            colors: colors,
          ),
          crossFadeState: _isExpanded
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          duration: const Duration(milliseconds: 300),
          sizeCurve: Curves.fastEaseInToSlowEaseOut,
        ),
      ),
    );
  }
}

class _ExpandedCardContent extends StatelessWidget {
  final String questionText;
  final List<String> values;
  final List<String> labels;
  final List<Color> colors;

  const _ExpandedCardContent({
    required this.questionText,
    required this.values,
    required this.labels,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  questionText,
                  style: theme.textTheme.titleMedium,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        const Divider(height: 16, thickness: 1),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Row(
                children: [
                  for (var i = 0; i < values.length; i++)
                    Expanded(
                      child: Text(
                        values[i],
                        textAlign: TextAlign.center,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: colors[i],
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 2),
              Row(
                children: [
                  for (var i = 0; i < labels.length; i++)
                    Expanded(
                      child: Text(
                        labels[i],
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CollapsedCardContent extends StatelessWidget {
  final String questionText;
  final List<String> values;
  final List<Color> colors;

  const _CollapsedCardContent({
    required this.questionText,
    required this.values,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Flexible(
            child: Text(
              questionText,
              style: theme.textTheme.bodyMedium,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          const SizedBox(width: 12),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var i = 0; i < values.length; i++) ...[
                if (i > 0) const SizedBox(width: 8),
                Text(
                  values[i],
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colors[i],
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
