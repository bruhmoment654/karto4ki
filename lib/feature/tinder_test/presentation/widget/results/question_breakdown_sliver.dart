import 'package:flutter/material.dart';
import 'package:quizzerg/feature/test_execution/domain/entity/attempt_summary.dart';
import 'package:quizzerg/feature/tinder_test/presentation/widget/results/question_result_tile.dart';
import 'package:quizzerg/l10n/app_localizations_x.dart';
import 'package:quizzerg/uikit/app_radii.dart';
import 'package:quizzerg/uikit/buttons/app_button_group.dart';
import 'package:quizzerg/uikit/spacing/sliver_height.dart';

/// Фильтр разбора по вопросам.
enum _QuestionFilter {
  all,
  mistakes,
  fixed,
  forgot;

  bool matches(QuestionResult result) => switch (this) {
    _QuestionFilter.all => true,
    _QuestionFilter.mistakes => !result.isCorrect,
    _QuestionFilter.fixed => result.trend == QuestionTrend.fixed,
    _QuestionFilter.forgot => result.trend == QuestionTrend.forgot,
  };
}

/// «По вопросам»: фильтры группой кнопок и список ответов.
///
/// Фильтры по тренду есть, только когда тест уже проходили: без прошлого
/// раза сравнивать не с чем.
class QuestionBreakdownSliver extends StatefulWidget {
  final AttemptSummary summary;

  const QuestionBreakdownSliver({required this.summary, super.key});

  @override
  State<QuestionBreakdownSliver> createState() =>
      _QuestionBreakdownSliverState();
}

class _QuestionBreakdownSliverState extends State<QuestionBreakdownSliver> {
  _QuestionFilter _filter = _QuestionFilter.all;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final questions = widget.summary.questions;
    final hasPrevious = widget.summary.recentAttempts.length > 1;
    final filters = hasPrevious
        ? _QuestionFilter.values
        : const [_QuestionFilter.all, _QuestionFilter.mistakes];
    final visible = questions.where(_filter.matches).toList();

    return SliverMainAxisGroup(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 10),
          sliver: SliverToBoxAdapter(
            child: Text(
              context.l10n.tinderTestResultsByQuestion,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: AppButtonGroup(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            selectedIndex: filters.indexOf(_filter),
            onSelectedChanged: (index) =>
                setState(() => _filter = filters[index]),
            items: [
              for (final filter in filters)
                _itemOf(filter, questions.where(filter.matches).length),
            ],
          ),
        ),
        const SliverHeight(12),
        if (visible.isNotEmpty)
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: DecoratedSliver(
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainer,
                borderRadius: BorderRadius.circular(AppDimens.radius28),
              ),
              sliver: SliverList.separated(
                itemCount: visible.length,
                itemBuilder: (context, index) =>
                    QuestionResultTile(result: visible[index]),
                separatorBuilder: (context, index) => Divider(
                  height: 1,
                  thickness: 1,
                  color: colorScheme.outlineVariant,
                ),
              ),
            ),
          ),
      ],
    );
  }

  /// Пустой фильтр выбрать нельзя — список под ним был бы пустым.
  ///
  /// Фильтры по тренду — иконкой со счётчиком, без подписи, как и тренд
  /// в строке вопроса; подпись остаётся только для диктора.
  AppButtonGroupItem _itemOf(_QuestionFilter filter, int count) {
    final l10n = context.l10n;
    final isEnabled = count > 0 || filter == _filter;

    return switch (filter) {
      _QuestionFilter.all => AppButtonGroupItem(
        label: '${l10n.tinderTestResultsFilterAll} $count',
        isEnabled: isEnabled,
      ),
      _QuestionFilter.mistakes => AppButtonGroupItem(
        label: '${l10n.tinderTestResultsFilterMistakes} $count',
        isEnabled: isEnabled,
      ),
      _QuestionFilter.fixed => AppButtonGroupItem(
        label: '$count',
        icon: QuestionTrend.fixed.icon,
        semanticLabel: '${l10n.tinderTestResultsTrendFixed}: $count',
        isEnabled: isEnabled,
      ),
      _QuestionFilter.forgot => AppButtonGroupItem(
        label: '$count',
        icon: QuestionTrend.forgot.icon,
        semanticLabel: '${l10n.tinderTestResultsTrendForgot}: $count',
        isEnabled: isEnabled,
      ),
    };
  }
}
