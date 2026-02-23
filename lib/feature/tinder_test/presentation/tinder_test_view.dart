import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:quizzerg/app/di/app_scope.dart';
import 'package:quizzerg/feature/main/domain/entity/card_entity.dart';
import 'package:quizzerg/feature/tinder_test/domain/bloc/tinder_test_bloc.dart';
import 'package:quizzerg/feature/tinder_test/domain/entity/test_session.dart';
import 'package:quizzerg/feature/tinder_test/presentation/tinder_test_screen.dart';
import 'package:quizzerg/l10n/app_localizations_x.dart';
import 'package:quizzerg/uikit/appbar/karto4ki_app_bar.dart';
import 'package:quizzerg/uikit/question_card/swipable_card_wrapper.dart';
import 'package:quizzerg/uikit/scaffold/app_scaffold.dart';
import 'package:quizzerg/uikit/theme/app_theme.dart';

/// UI layer for tinder test screen.
///
/// Responsible for visual representation of tinder-style test:
/// swipeable cards, progress indicator, results screen.
class TinderTestView extends StatelessWidget {
  final ITinderTestViewModel viewModel;
  final TinderTestState state;

  const TinderTestView({
    required this.viewModel,
    required this.state,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: Karto4kiAppBar(
        title: context.l10n.tinderTestAppBarTitle,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: viewModel.onBackPressed,
        ),
      ),
      body: switch (state) {
        TinderTestState$Initial() ||
        TinderTestState$Loading() =>
          const Center(child: CircularProgressIndicator()),
        TinderTestState$Empty() => _EmptyContent(viewModel: viewModel),
        TinderTestState$Error(:final message) => _ErrorContent(
            message: message,
            viewModel: viewModel,
          ),
        TinderTestState$InProgress(
          :final session,
          :final currentCard,
          :final isUndo
        ) =>
          _TestContent(
            session: session,
            currentCard: currentCard,
            isUndo: isUndo,
            viewModel: viewModel,
          ),
        TinderTestState$Completed(:final session) => _ResultsContent(
            session: session,
            viewModel: viewModel,
          ),
      },
    );
  }
}

class _EmptyContent extends StatelessWidget {
  final ITinderTestViewModel viewModel;

  const _EmptyContent({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inbox_outlined,
            size: 64,
            color: colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 16),
          Text(
            context.l10n.tinderTestEmptyTitle,
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 8),
          Text(
            context.l10n.tinderTestEmptySubtitle,
            style: TextStyle(color: colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: viewModel.onBackPressed,
            child: Text(context.l10n.tinderTestBackButton),
          ),
        ],
      ),
    );
  }
}

class _ErrorContent extends StatelessWidget {
  final String message;
  final ITinderTestViewModel viewModel;

  const _ErrorContent({
    required this.message,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: colorScheme.error,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: viewModel.onBackPressed,
            child: Text(context.l10n.tinderTestBackButton),
          ),
        ],
      ),
    );
  }
}

class _TestContent extends StatefulWidget {
  final TestSession session;
  final CardEntity currentCard;
  final bool isUndo;
  final ITinderTestViewModel viewModel;

  const _TestContent({
    required this.session,
    required this.currentCard,
    required this.isUndo,
    required this.viewModel,
  });

  @override
  State<_TestContent> createState() => _TestContentState();
}

class _TestContentState extends State<_TestContent> {
  final ValueNotifier<bool> _showAnswer = ValueNotifier(false);
  final ValueNotifier<bool> _enableFlipAnimation = ValueNotifier(true);

  @override
  void didUpdateWidget(_TestContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentCard.id != widget.currentCard.id) {
      _showAnswer.value = false;
      _enableFlipAnimation.value = false;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _enableFlipAnimation.value = true;
        }
      });
    }
  }

  @override
  void dispose() {
    _showAnswer.dispose();
    _enableFlipAnimation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final settings = context.read<IAppScope>().settingsStorage.get();
    final flipDuration = Duration(milliseconds: settings.animationDurationMs);

    return Column(
      children: [
        _ProgressIndicator(session: widget.session),
        _SwipeHints(),
        const SizedBox(height: 12),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: AnimatedBuilder(
              animation: Listenable.merge([
                _showAnswer,
                _enableFlipAnimation,
              ]),
              builder: (context, child) {
                final currentShowAnswer = _showAnswer.value;
                final enableFlipAnimation = _enableFlipAnimation.value;
                return SwipeableCardWrapper(
                  card: widget.currentCard,
                  showAnswer: currentShowAnswer,
                  enableFlipAnimation: enableFlipAnimation,
                  enterFromLeft: widget.isUndo,
                  flipDuration: flipDuration,
                  onTap: () => _showAnswer.value = !currentShowAnswer,
                  onSwipeLeft: () =>
                      widget.viewModel.onSwipeLeft(widget.currentCard),
                  onSwipeRight: () =>
                      widget.viewModel.onSwipeRight(widget.currentCard),
                );
              },
            ),
          ),
        ),
        _UndoButton(
          canUndo: widget.session.canUndo,
          onPressed: widget.viewModel.onDiscardPressed,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class _ProgressIndicator extends StatelessWidget {
  final TestSession session;

  const _ProgressIndicator({required this.session});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              context.l10n.tinderTestProgressLabel(
                session.currentIndex + 1,
                session.cards.length,
              ),
              style:
                  TextStyle(fontSize: 14, color: colorScheme.onSurfaceVariant),
            ),
            Row(
              children: [
                Icon(Icons.check, color: colorScheme.primary, size: 16),
                Text(' ${session.correctCount}'),
                const SizedBox(width: 8),
                Icon(Icons.close, color: colorScheme.error, size: 16),
                Text(' ${session.incorrectCount}'),
              ],
            ),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: session.progress,
          backgroundColor: colorScheme.surfaceContainerHighest,
          valueColor: AlwaysStoppedAnimation<Color>(colorScheme.info),
        ),
      ],
    );
  }
}

class _SwipeHints extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Material(
          color: colorScheme.surfaceContainer,
          elevation: 2,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                Icon(Icons.arrow_back, color: colorScheme.error),
                const SizedBox(width: 8),
                Text(
                  context.l10n.tinderTestSwipeUnknownHint,
                  style: TextStyle(color: colorScheme.onSurfaceVariant),
                ),
              ],
            ),
          ),
        ),
        Material(
          color: colorScheme.surfaceContainer,
          elevation: 2,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                Text(
                  context.l10n.tinderTestSwipeKnownHint,
                  style: TextStyle(color: colorScheme.onSurfaceVariant),
                ),
                const SizedBox(width: 8),
                Icon(Icons.arrow_forward, color: colorScheme.primary),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _UndoButton extends StatelessWidget {
  final bool canUndo;
  final VoidCallback onPressed;

  const _UndoButton({
    required this.canUndo,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: canUndo ? 1.0 : 0.3,
      duration: const Duration(milliseconds: 200),
      child: IconButton.filled(
        onPressed: canUndo ? onPressed : null,
        icon: const Icon(Icons.undo),
        tooltip: context.l10n.tinderTestUndoTooltip,
        style: IconButton.styleFrom(
          backgroundColor:
              Theme.of(context).colorScheme.surfaceContainerHighest,
          foregroundColor: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }
}

class _ResultsContent extends StatelessWidget {
  final TestSession session;
  final ITinderTestViewModel viewModel;

  const _ResultsContent({
    required this.session,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final total = session.cards.length;
    final correct = session.correctCount;
    final percentage = total > 0 ? (correct / total * 100).round() : 0;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.emoji_events,
              size: 80,
              color: colorScheme.success,
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
            _ResultCard(
              icon: Icons.check_circle,
              color: colorScheme.primary,
              label: context.l10n.tinderTestResultsCorrectLabel,
              value: correct.toString(),
            ),
            const SizedBox(height: 16),
            _ResultCard(
              icon: Icons.cancel,
              color: colorScheme.error,
              label: context.l10n.tinderTestResultsIncorrectLabel,
              value: session.incorrectCount.toString(),
            ),
            const SizedBox(height: 16),
            _ResultCard(
              icon: Icons.percent,
              color: colorScheme.info,
              label: context.l10n.tinderTestResultsPercentageLabel,
              value: '$percentage%',
            ),
            const SizedBox(height: 48),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton.icon(
                  onPressed: viewModel.onRestartPressed,
                  icon: const Icon(Icons.refresh),
                  label: Text(context.l10n.tinderTestResultsRestartButton),
                ),
                const SizedBox(width: 16),
                ElevatedButton.icon(
                  onPressed: viewModel.onBackPressed,
                  icon: const Icon(Icons.done),
                  label: Text(context.l10n.tinderTestResultsDoneButton),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ResultCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final String value;

  const _ResultCard({
    required this.icon,
    required this.color,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          mainAxisSize: MainAxisSize.min,
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
        ),
      ),
    );
  }
}
