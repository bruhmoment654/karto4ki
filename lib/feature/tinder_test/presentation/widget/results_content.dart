import 'package:flutter/material.dart';
import 'package:quizzerg/feature/test_execution/domain/entity/attempt_summary.dart';
import 'package:quizzerg/feature/tinder_test/domain/entity/test_session.dart';
import 'package:quizzerg/feature/tinder_test/presentation/tinder_test_screen.dart';
import 'package:quizzerg/feature/tinder_test/presentation/widget/results/attempts_chart_card.dart';
import 'package:quizzerg/feature/tinder_test/presentation/widget/results/dynamics_placeholder_card.dart';
import 'package:quizzerg/feature/tinder_test/presentation/widget/results/question_breakdown_sliver.dart';
import 'package:quizzerg/feature/tinder_test/presentation/widget/results/result_summary_header.dart';
import 'package:quizzerg/l10n/app_localizations_x.dart';
import 'package:quizzerg/uikit/motion/fade_in.dart';
import 'package:quizzerg/uikit/spacing/sliver_height.dart';
import 'package:quizzerg/uikit/spacing/width.dart';

/// Экран результата (вариант C): сводка с кольцом, динамика прохождений
/// и разбор по вопросам. Кнопки закреплены снизу.
///
/// Пока [summary] пишется, видна только сводка — остальное появляется
/// следом.
class ResultsContent extends StatelessWidget {
  final TestSession session;
  final AttemptSummary? summary;
  final ITinderTestViewModel viewModel;

  const ResultsContent({
    required this.session,
    required this.summary,
    required this.viewModel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final summary = this.summary;

    return Column(
      children: [
        Expanded(
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(24, 8, 16, 0),
                sliver: SliverToBoxAdapter(
                  child: ResultSummaryHeader(
                    correct: session.correctCount,
                    total: session.cards.length,
                    summary: summary,
                  ),
                ),
              ),
              if (summary != null) ...[
                if (summary.hasHistory)
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
                    sliver: SliverToBoxAdapter(
                      child: FadeIn(
                        child: summary.isFirstAttempt
                            ? const DynamicsPlaceholderCard()
                            : AttemptsChartCard(summary: summary),
                      ),
                    ),
                  ),
                QuestionBreakdownSliver(summary: summary),
              ],
              const SliverHeight(24),
            ],
          ),
        ),
        _ResultActions(viewModel: viewModel),
      ],
    );
  }
}

/// «Повторить» и «Готово» под списком.
class _ResultActions extends StatelessWidget {
  final ITinderTestViewModel viewModel;

  const _ResultActions({required this.viewModel});

  static const _buttonSize = Size(0, 52);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      child: Row(
        children: [
          Expanded(
            child: FilledButton.tonalIcon(
              onPressed: viewModel.onRestartPressed,
              icon: const Icon(Icons.replay),
              label: Text(context.l10n.tinderTestResultsRestartButton),
              style: FilledButton.styleFrom(minimumSize: _buttonSize),
            ),
          ),
          const Width(10),
          Expanded(
            child: FilledButton.icon(
              onPressed: viewModel.onBackPressed,
              icon: const Icon(Icons.check),
              label: Text(context.l10n.tinderTestResultsDoneButton),
              style: FilledButton.styleFrom(minimumSize: _buttonSize),
            ),
          ),
        ],
      ),
    );
  }
}
