import 'package:animations/animations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:quizzerg/core/bloc/state_streamable_builder.dart';
import 'package:quizzerg/feature/main/domain/entity/card_entity.dart';
import 'package:quizzerg/feature/settings/domain/bloc/settings_bloc.dart';
import 'package:quizzerg/feature/tinder_test/domain/bloc/tinder_test_bloc.dart';
import 'package:quizzerg/feature/tinder_test/domain/entity/test_session.dart';
import 'package:quizzerg/feature/tinder_test/presentation/tinder_test_screen.dart';
import 'package:quizzerg/feature/tinder_test/presentation/widget/results_content.dart';
import 'package:quizzerg/l10n/app_localizations_x.dart';
import 'package:quizzerg/uikit/app_radii.dart';
import 'package:quizzerg/uikit/appbar/karto4ki_app_bar.dart';
import 'package:quizzerg/uikit/motion/app_motion.dart';
import 'package:quizzerg/uikit/progress/animated_linear_progress.dart';
import 'package:quizzerg/uikit/question_card/swipable_card_wrapper.dart';
import 'package:quizzerg/uikit/scaffold/app_scaffold.dart';
import 'package:quizzerg/uikit/spacing/height.dart';
import 'package:quizzerg/uikit/theme/app_theme.dart';

/// UI layer for tinder test screen.
///
/// Responsible for visual representation of tinder-style test:
/// swipeable cards, progress indicator, results screen.
class TinderTestView extends StatelessWidget {
  final ITinderTestViewModel viewModel;

  const TinderTestView({required this.viewModel, super.key});

  @override
  Widget build(BuildContext context) {
    return StateStreamableBuilder<TinderTestState>(
      bloc: viewModel.tinderState,
      builder: (context, state) => _Body(viewModel: viewModel, state: state),
    );
  }
}

class _Body extends StatelessWidget {
  final ITinderTestViewModel viewModel;
  final TinderTestState state;

  const _Body({required this.viewModel, required this.state});

  @override
  Widget build(BuildContext context) {
    // Переход между состояниями (в т.ч. прохождение → результат) — shared axis
    // Z (масштаб + fade) по M3.
    final body = switch (state) {
      TinderTestState$Initial() || TinderTestState$Loading() => const Center(
          key: ValueKey('loading'),
          child: CircularProgressIndicator(),
        ),
      TinderTestState$Empty() => _EmptyContent(
          key: const ValueKey('empty'),
          viewModel: viewModel,
        ),
      TinderTestState$Error(:final message) => _ErrorContent(
          key: const ValueKey('error'),
          message: message,
          viewModel: viewModel,
        ),
      TinderTestState$InProgress(
        :final session,
        :final currentCard,
        :final isUndo
      ) =>
        _TestContent(
          key: const ValueKey('in_progress'),
          session: session,
          currentCard: currentCard,
          isUndo: isUndo,
          viewModel: viewModel,
        ),
      TinderTestState$Completed(:final session) => ResultsContent(
          key: const ValueKey('completed'),
          session: session,
          viewModel: viewModel,
        ),
    };

    return AppScaffold(
      appBar: DefaultAppBar.withBack(
        title: Text(context.l10n.tinderTestAppBarTitle),
        onBackPressed: viewModel.onBackPressed,
      ),
      body: PageTransitionSwitcher(
        duration: AppMotion.reduced(context)
            ? Duration.zero
            : const Duration(milliseconds: 400),
        transitionBuilder: (child, primaryAnimation, secondaryAnimation) =>
            SharedAxisTransition(
          animation: primaryAnimation,
          secondaryAnimation: secondaryAnimation,
          transitionType: SharedAxisTransitionType.scaled,
          fillColor: Colors.transparent,
          child: child,
        ),
        child: body,
      ),
    );
  }
}

class _EmptyContent extends StatelessWidget {
  final ITinderTestViewModel viewModel;

  const _EmptyContent({required this.viewModel, super.key});

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
          const Height(16),
          Text(
            context.l10n.tinderTestEmptyTitle,
            style: const TextStyle(fontSize: 18),
          ),
          const Height(8),
          Text(
            context.l10n.tinderTestEmptySubtitle,
            style: TextStyle(color: colorScheme.onSurfaceVariant),
          ),
          const Height(24),
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
    super.key,
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
          const Height(16),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
          const Height(24),
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
    super.key,
  });

  @override
  State<_TestContent> createState() => _TestContentState();
}

class _TestContentState extends State<_TestContent> {
  final ValueNotifier<bool> _showAnswer = ValueNotifier(false);
  final ValueNotifier<bool> _enableFlipAnimation = ValueNotifier(true);
  late final ValueNotifier<double> _progress;

  @override
  void initState() {
    super.initState();
    _progress = ValueNotifier(widget.session.progress);
  }

  @override
  void didUpdateWidget(_TestContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    _progress.value = widget.session.progress;
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
    _progress.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StateStreamableBuilder<SettingsState>(
      bloc: widget.viewModel.settingsState,
      buildWhen: (previous, current) =>
          previous.settings.animationDurationMs !=
              current.settings.animationDurationMs ||
          previous.settings.cardFontSize != current.settings.cardFontSize,
      builder: (context, settingsState) => _TestContentBody(
        session: widget.session,
        currentCard: widget.currentCard,
        isUndo: widget.isUndo,
        viewModel: widget.viewModel,
        showAnswer: _showAnswer,
        enableFlipAnimation: _enableFlipAnimation,
        progress: _progress,
        flipDuration: Duration(
          milliseconds: settingsState.settings.animationDurationMs,
        ),
        cardFontSize: settingsState.settings.cardFontSize,
      ),
    );
  }
}

/// Разметка прохождения теста: прогресс, карточка и кнопка отмены.
class _TestContentBody extends StatelessWidget {
  final TestSession session;
  final CardEntity currentCard;
  final bool isUndo;
  final ITinderTestViewModel viewModel;
  final ValueNotifier<bool> showAnswer;
  final ValueListenable<bool> enableFlipAnimation;
  final ValueListenable<double> progress;
  final Duration flipDuration;
  final double cardFontSize;

  const _TestContentBody({
    required this.session,
    required this.currentCard,
    required this.isUndo,
    required this.viewModel,
    required this.showAnswer,
    required this.enableFlipAnimation,
    required this.progress,
    required this.flipDuration,
    required this.cardFontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Height(8),
        _ProgressIndicator(session: session, progress: progress),
        _SwipeHints(),
        const Height(12),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Stack(
              children: [
                if (session.currentIndex < session.cards.length - 1)
                  const Positioned.fill(child: _PeekCard()),
                AnimatedBuilder(
                  animation: Listenable.merge([
                    showAnswer,
                    enableFlipAnimation,
                  ]),
                  builder: (context, child) {
                    final currentShowAnswer = showAnswer.value;
                    return SwipeableCardWrapper(
                      card: currentCard,
                      showAnswer: currentShowAnswer,
                      enableFlipAnimation: enableFlipAnimation.value,
                      enterFromLeft: isUndo,
                      flipDuration: flipDuration,
                      fontSize: cardFontSize,
                      onTap: () => showAnswer.value = !currentShowAnswer,
                      onSwipeLeft: () => viewModel.onSwipeLeft(currentCard),
                      onSwipeRight: () => viewModel.onSwipeRight(currentCard),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        _UndoButton(
          canUndo: session.canUndo,
          onPressed: viewModel.onDiscardPressed,
        ),
        const Height(16),
      ],
    );
  }
}

class _ProgressIndicator extends StatelessWidget {
  final TestSession session;
  final ValueListenable<double> progress;

  const _ProgressIndicator({
    required this.session,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.l10n.tinderTestProgressLabel(
                  session.currentIndex + 1,
                  session.cards.length,
                ),
                style: TextStyle(
                    fontSize: 14, color: colorScheme.onSurfaceVariant),
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
        ),
        const Height(8),
        AnimatedLinearProgress(
          progress: progress,
          backgroundColor: colorScheme.surfaceContainerHighest,
          valueColor: colorScheme.info,
        ),
      ],
    );
  }
}

/// Подложка-следующая карточка под текущей: повёрнутый прямоугольник,
/// создающий эффект стопки карт.
class _PeekCard extends StatelessWidget {
  const _PeekCard();

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -0.0436,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(AppDimens.radius28),
          ),
        ),
      ),
    );
  }
}

class _SwipeHints extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.west, color: colorScheme.error, size: 20),
              const SizedBox(width: 8),
              Text(
                context.l10n.tinderTestSwipeUnknownHint,
                style: TextStyle(
                  color: colorScheme.error,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                context.l10n.tinderTestSwipeKnownHint,
                style: TextStyle(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 8),
              Icon(Icons.east, color: colorScheme.primary, size: 20),
            ],
          ),
        ],
      ),
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
