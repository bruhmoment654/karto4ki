import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:quizzerg/core/bloc/state_streamable_builder.dart';
import 'package:quizzerg/core/feature/core/failure.dart';
import 'package:quizzerg/core/utils/answer_parser.dart';
import 'package:quizzerg/feature/question_stats/domain/bloc/question_stats_bloc.dart';
import 'package:quizzerg/feature/question_stats/domain/entity/question_stats_entity.dart';
import 'package:quizzerg/feature/question_stats/domain/entity/question_stats_sort.dart';
import 'package:quizzerg/feature/question_stats/presentation/question_stats_screen.dart';
import 'package:quizzerg/l10n/app_localizations_x.dart';
import 'package:quizzerg/uikit/appbar/app_page_header.dart';
import 'package:quizzerg/uikit/content_card/content_card.dart';
import 'package:quizzerg/uikit/fields/karto4ki_text_field.dart';
import 'package:quizzerg/uikit/motion/count_up_text.dart';
import 'package:quizzerg/uikit/motion/staggered_appear.dart';
import 'package:quizzerg/uikit/progress/wave_fill_bar.dart';
import 'package:quizzerg/uikit/scaffold/app_scaffold.dart';
import 'package:quizzerg/uikit/theme/app_colors.dart';

class QuestionStatsView extends StatelessWidget {
  final IQuestionStatsViewModel viewModel;

  const QuestionStatsView({required this.viewModel, super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
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
    return StateStreamableBuilder<QuestionStatsState>(
      bloc: viewModel.statsState,
      builder: (context, state) => switch (state) {
        QuestionStatsState$Loading() =>
          const Center(child: CircularProgressIndicator()),
        QuestionStatsState$Error(:final failure) => _ErrorContent(
            failure: failure,
            onRetry: viewModel.onRetryTap,
          ),
        QuestionStatsState$Loaded(hasAnyStats: false) => _EmptyContent(),
        QuestionStatsState$Loaded() => _LoadedContent(
            viewModel: viewModel,
            state: state,
          ),
      },
    );
  }
}

class _LoadedContent extends StatelessWidget {
  final IQuestionStatsViewModel viewModel;
  final QuestionStatsState$Loaded state;

  const _LoadedContent({required this.viewModel, required this.state});

  @override
  Widget build(BuildContext context) {
    final stats = state.stats;
    final query = state.searchQuery.trim();

    return Column(
      children: [
        AppPageHeader(title: context.l10n.questionStatsTitle),
        _SearchBar(viewModel: viewModel, searchQuery: state.searchQuery),
        _InfoPanel(
          viewModel: viewModel,
          state: state,
          foundCount: stats.length,
        ),
        Expanded(
          child: stats.isEmpty
              ? _SearchEmptyContent()
              : AnimationLimiter(
                  child: CustomScrollView(
                    controller: viewModel.scrollController,
                    slivers: [
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        sliver: SliverList.separated(
                          itemCount: stats.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 10),
                          itemBuilder: (_, index) => StaggeredAppear(
                            position: index,
                            child: _StatsCard(
                              stat: stats[index],
                              query: query,
                            ),
                          ),
                        ),
                      ),
                      const SliverPadding(
                        padding: EdgeInsets.only(bottom: 24),
                      ),
                    ],
                  ),
                ),
        ),
      ],
    );
  }
}

class _SearchBar extends StatelessWidget {
  final IQuestionStatsViewModel viewModel;
  final String searchQuery;

  const _SearchBar({required this.viewModel, required this.searchQuery});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: Karto4kiTextField(
        controller: viewModel.searchController,
        hintText: context.l10n.questionStatsSearchHint,
        textInputAction: TextInputAction.search,
        prefixIcon: const Icon(Icons.search),
        suffixIcon: searchQuery.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.close),
                onPressed: viewModel.onSearchCleared,
              )
            : null,
        onChanged: viewModel.onSearchChanged,
      ),
    );
  }
}

class _InfoPanel extends StatelessWidget {
  final IQuestionStatsViewModel viewModel;
  final QuestionStatsState$Loaded state;
  final int foundCount;

  const _InfoPanel({
    required this.viewModel,
    required this.state,
    required this.foundCount,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    if (state.searchQuery.trim().isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            l10n.questionStatsSearchFound(foundCount),
            style: theme.textTheme.bodyMedium?.copyWith(
              color: cs.onSurfaceVariant,
            ),
          ),
        ),
      );
    }

    final sortLabel = switch (state.sort) {
      QuestionStatsSort.byDate => l10n.questionStatsSortByDate,
      QuestionStatsSort.byStreak => l10n.questionStatsSortByStreak,
      QuestionStatsSort.byAccuracy => l10n.questionStatsSortByAccuracy,
    };
    final isAsc = state.order == SortOrder.ascending;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
      child: Row(
        children: [
          ActionChip(
            avatar: Icon(Icons.sort, size: 18, color: cs.onSecondaryContainer),
            label: Text(sortLabel),
            labelStyle: theme.textTheme.bodyMedium?.copyWith(
              color: cs.onSecondaryContainer,
              fontWeight: FontWeight.w600,
            ),
            backgroundColor: cs.secondaryContainer,
            side: BorderSide.none,
            onPressed: viewModel.onSortTap,
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: Icon(
              isAsc ? Icons.arrow_upward : Icons.arrow_downward,
              size: 20,
            ),
            onPressed: viewModel.onSortOrderTap,
            visualDensity: VisualDensity.compact,
            style: IconButton.styleFrom(
              backgroundColor: cs.surfaceContainerHigh,
              foregroundColor: cs.onSurfaceVariant,
            ),
          ),
          const Spacer(),
          Text(
            l10n.questionStatsTotalCount(foundCount),
            style: theme.textTheme.bodySmall?.copyWith(
              color: cs.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchEmptyContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.search_off,
              size: 48,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 12),
            Text(
              context.l10n.questionStatsSearchEmpty,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _ScrollToTopFab extends StatelessWidget {
  final IQuestionStatsViewModel viewModel;

  const _ScrollToTopFab({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: viewModel.showScrollToTop,
      builder: (context, isVisible, child) => AnimatedScale(
        scale: isVisible ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 200),
        child: AnimatedOpacity(
          opacity: isVisible ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 200),
          child: child,
        ),
      ),
      child: FloatingActionButton.small(
        onPressed: viewModel.onScrollToTopTap,
        child: const Icon(Icons.keyboard_arrow_up),
      ),
    );
  }
}

class _ErrorContent extends StatelessWidget {
  final Failure failure;
  final VoidCallback onRetry;

  const _ErrorContent({required this.failure, required this.onRetry});

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
              context.l10n.testsListErrorMessage(
                failure.message ?? context.l10n.testsListUnknownError,
              ),
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

/// Карточка статистики по карточке: переводы + написание, точность с цветовым
/// порогом, иконочные статы и прогресс-бар точности.
class _StatsCard extends StatelessWidget {
  final QuestionStatsEntity stat;
  final String query;

  const _StatsCard({required this.stat, required this.query});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final colors = AppColors.of(context);
    final total = stat.totalCorrect + stat.totalIncorrect;
    final accuracy = total > 0 ? (stat.totalCorrect / total * 100).round() : 0;
    final accuracyColor = _accuracyColor(colors, accuracy);

    final answers = AnswerParser.parse(stat.backText).join(' | ');

    return ContentCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _HighlightedText(
                      text: stat.frontText,
                      query: query,
                      style: theme.textTheme.titleMedium,
                      maxLines: 1,
                    ),
                    const SizedBox(height: 2),
                    _HighlightedText(
                      text: answers,
                      query: query,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: cs.onSurfaceVariant,
                      ),
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              CountUpText(
                value: accuracy,
                suffix: '%',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: accuracyColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _MiniStat(
                icon: Icons.check_circle,
                value: stat.totalCorrect,
                color: colors.success,
              ),
              const SizedBox(width: 18),
              _MiniStat(
                icon: Icons.cancel,
                value: stat.totalIncorrect,
                color: cs.error,
              ),
              const SizedBox(width: 18),
              _MiniStat(
                icon: Icons.local_fire_department,
                value: stat.streak,
                color: cs.primary,
              ),
              const SizedBox(width: 18),
              Expanded(
                child: WaveFillBar(
                  value: accuracy / 100,
                  color: accuracyColor,
                  backgroundColor: cs.surfaceContainerHighest,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Цвет точности по порогам: ≥90, ≥60, ниже — шкала из палитры.
  Color _accuracyColor(AppColors colors, int accuracy) {
    if (accuracy >= 90) return colors.accuracyHigh;
    if (accuracy >= 60) return colors.accuracyMid;
    return colors.accuracyLow;
  }
}

/// Иконка + числовое значение для строки статов карточки.
class _MiniStat extends StatelessWidget {
  final IconData icon;
  final int value;
  final Color color;

  const _MiniStat({
    required this.icon,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 4),
        Text(
          '$value',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: color,
                fontWeight: FontWeight.w700,
              ),
        ),
      ],
    );
  }
}

/// Текст с подсветкой совпавшего с поисковым запросом фрагмента.
class _HighlightedText extends StatelessWidget {
  final String text;
  final String query;
  final TextStyle? style;
  final int? maxLines;

  const _HighlightedText({
    required this.text,
    required this.query,
    this.style,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    final normalizedQuery = query.trim().toLowerCase();
    if (normalizedQuery.isEmpty) {
      return Text(
        text,
        style: style,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
      );
    }

    final cs = Theme.of(context).colorScheme;
    final highlightStyle = (style ?? const TextStyle()).copyWith(
      backgroundColor: cs.primaryContainer,
      color: cs.onPrimaryContainer,
    );

    final spans = <TextSpan>[];
    final lowerText = text.toLowerCase();
    var start = 0;
    while (true) {
      final index = lowerText.indexOf(normalizedQuery, start);
      if (index < 0) {
        spans.add(TextSpan(text: text.substring(start)));
        break;
      }
      if (index > start) {
        spans.add(TextSpan(text: text.substring(start, index)));
      }
      final end = index + normalizedQuery.length;
      spans.add(
          TextSpan(text: text.substring(index, end), style: highlightStyle));
      start = end;
    }

    return Text.rich(
      TextSpan(style: style, children: spans),
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
    );
  }
}
