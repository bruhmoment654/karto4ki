import 'package:animations/animations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:material_3_expressive/material_3_expressive.dart'
    show
        M3EIconButton,
        M3EIconButtonSize,
        M3EIconButtonVariant,
        M3EProgressIndicator;
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
import 'package:quizzerg/uikit/m3e/m3e_scope.dart';
import 'package:quizzerg/uikit/motion/app_animated_switcher.dart';
import 'package:quizzerg/uikit/motion/app_motion.dart';
import 'package:quizzerg/uikit/question_card/swipable_card_wrapper.dart';
import 'package:quizzerg/uikit/scaffold/app_scaffold.dart';
import 'package:quizzerg/uikit/spacing/height.dart';
import 'package:quizzerg/uikit/spacing/width.dart';
import 'package:quizzerg/uikit/theme/app_colors.dart';

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
        :final undoneResult
      ) =>
        _TestContent(
          key: const ValueKey('in_progress'),
          session: session,
          currentCard: currentCard,
          entrySide: switch (undoneResult?.isCorrect) {
            null => null,
            true => CardEntrySide.right,
            false => CardEntrySide.left,
          },
          viewModel: viewModel,
        ),
      TinderTestState$Completed(:final session, :final summary) =>
        ResultsContent(
          key: const ValueKey('completed'),
          session: session,
          summary: summary,
          viewModel: viewModel,
        ),
    };

    return AppScaffold(
      // У прохождения своя шапка — крестик и кольцо прогресса (_StudyTopBar).
      appBar: switch (state) {
        TinderTestState$InProgress() => null,
        TinderTestState$Completed() => DefaultAppBar(
            title: Text(context.l10n.tinderTestResultsAppBarTitle),
            leading: IconButton(
              icon: const Icon(Icons.close),
              onPressed: viewModel.onBackPressed,
            ),
          ),
        _ => DefaultAppBar.withBack(
            title: Text(context.l10n.tinderTestAppBarTitle),
            onBackPressed: viewModel.onBackPressed,
          ),
      },
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
  /// Откуда заезжает карточка после отмены ответа.
  final CardEntrySide? entrySide;
  final ITinderTestViewModel viewModel;

  const _TestContent({
    required this.session,
    required this.currentCard,
    required this.entrySide,
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
        entrySide: widget.entrySide,
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

/// Разметка прохождения теста: шапка с кольцом прогресса, стороны свайпа
/// со счётчиками, карточка и кнопка отмены в зоне большого пальца.
class _TestContentBody extends StatelessWidget {
  final TestSession session;
  final CardEntity currentCard;
  /// Откуда заезжает карточка после отмены ответа.
  final CardEntrySide? entrySide;
  final ITinderTestViewModel viewModel;
  final ValueNotifier<bool> showAnswer;
  final ValueListenable<bool> enableFlipAnimation;
  final ValueListenable<double> progress;
  final Duration flipDuration;
  final double cardFontSize;

  const _TestContentBody({
    required this.session,
    required this.currentCard,
    required this.entrySide,
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
        _StudyTopBar(
          session: session,
          progress: progress,
          onClosePressed: viewModel.onBackPressed,
        ),
        _SwipeHints(
          correctCount: session.correctCount,
          incorrectCount: session.incorrectCount,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 26),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                if (session.currentIndex < session.cards.length - 1)
                  const _PeekCard(),
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
                      enterFrom: entrySide,
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
        const Height(30),
      ],
    );
  }
}

/// Шапка прохождения: крестик выхода и кольцо прогресса «1/30» по центру.
class _StudyTopBar extends StatelessWidget {
  /// Ширина кнопки слева — справа такой же отступ, чтобы кольцо стояло
  /// ровно по центру экрана.
  static const double _sideSlot = 48;

  final TestSession session;
  final ValueListenable<double> progress;
  final VoidCallback onClosePressed;

  const _StudyTopBar({
    required this.session,
    required this.progress,
    required this.onClosePressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            IconButton(
              onPressed: onClosePressed,
              tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
              icon: const Icon(Icons.close),
            ),
            Expanded(
              child: Center(
                child: _ProgressRing(
                  current: session.currentIndex + 1,
                  total: session.cards.length,
                  progress: progress,
                ),
              ),
            ),
            const Width(_sideSlot),
          ],
        ),
      ),
    );
  }
}

/// Кольцо M3E с плавной дугой прогресса и счётчиком «1/30» внутри.
class _ProgressRing extends StatelessWidget {
  static const double _size = 56;
  static const double _strokeWidth = 5;
  static const Duration _duration = Duration(milliseconds: 300);

  final int current;
  final int total;
  final ValueListenable<double> progress;

  const _ProgressRing({
    required this.current,
    required this.total,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final duration = AppMotion.reduced(context) ? Duration.zero : _duration;

    return SizedBox.square(
      dimension: _size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ValueListenableBuilder<double>(
            valueListenable: progress,
            builder: (context, value, _) => TweenAnimationBuilder<double>(
              tween: Tween(end: value.clamp(0.0, 1.0)),
              duration: duration,
              curve: Curves.easeInOut,
              builder: (context, animated, _) => M3EScope(
                child: M3EProgressIndicator.circular(
                  value: animated,
                  size: _size,
                  strokeWidth: _strokeWidth,
                  trackStrokeWidth: _strokeWidth,
                  color: colorScheme.primary,
                  trackColor: colorScheme.surfaceContainerHigh,
                  semanticsLabel:
                      context.l10n.tinderTestProgressLabel(current, total),
                ),
              ),
            ),
          ),
          ExcludeSemantics(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '$current',
                    style: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                  TextSpan(
                    text: '/$total',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
              style: TextStyle(
                fontSize: 13,
                color: colorScheme.onSurface,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Подложка-следующая карточка: чуть уже текущей и выглядывает из-под
/// её нижнего края — эффект стопки.
class _PeekCard extends StatelessWidget {
  static const double _scale = 0.96;
  static const double _shift = 14;

  const _PeekCard();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 12,
      left: 14,
      right: 14,
      bottom: -_shift,
      child: Transform.translate(
        offset: const Offset(0, _shift),
        child: Transform.scale(
          scale: _scale,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainer,
              borderRadius: BorderRadius.circular(AppDimens.radius48),
            ),
          ),
        ),
      ),
    );
  }
}

/// Стороны свайпа со счётчиками ответов: «← Не знаю [✕ 3]» и
/// «[✓ 12] Знаю →» — счётчик стоит над тем направлением, которое он считает.
class _SwipeHints extends StatelessWidget {
  static const _successTagAlpha = 0.18;

  final int correctCount;
  final int incorrectCount;

  const _SwipeHints({
    required this.correctCount,
    required this.incorrectCount,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final success = AppColors.of(context).success;

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: _SwipeSide(
              arrow: Icons.west,
              label: context.l10n.tinderTestSwipeUnknownHint,
              countIcon: Icons.close,
              count: incorrectCount,
              color: colorScheme.error,
              tagBackground: colorScheme.errorContainer,
              tagForeground: colorScheme.onErrorContainer,
            ),
          ),
          const Width(12),
          Flexible(
            child: _SwipeSide(
              arrow: Icons.east,
              label: context.l10n.tinderTestSwipeKnownHint,
              countIcon: Icons.check,
              count: correctCount,
              color: success,
              tagBackground: success.withValues(alpha: _successTagAlpha),
              tagForeground: success,
              isTrailing: true,
            ),
          ),
        ],
      ),
    );
  }
}

/// Сторона свайпа: стрелка, подпись и счётчик. У правой стороны порядок
/// зеркальный — стрелка снаружи, счётчик ближе к центру.
class _SwipeSide extends StatelessWidget {
  final IconData arrow;
  final String label;
  final IconData countIcon;
  final int count;

  /// Цвет стрелки и подписи.
  final Color color;
  final Color tagBackground;
  final Color tagForeground;
  final bool isTrailing;

  const _SwipeSide({
    required this.arrow,
    required this.label,
    required this.countIcon,
    required this.count,
    required this.color,
    required this.tagBackground,
    required this.tagForeground,
    this.isTrailing = false,
  });

  @override
  Widget build(BuildContext context) {
    final children = [
      Icon(arrow, color: color, size: 18),
      const Width(6),
      Flexible(
        child: Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: color,
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      const Width(6),
      Container(
        height: 28,
        padding: const EdgeInsets.only(left: 8, right: 12),
        decoration: BoxDecoration(
          color: tagBackground,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(countIcon, color: tagForeground, size: 16),
            const Width(4),
            AppAnimatedSwitcher(
              transition: AppSwitcherTransition.slideUp,
              child: Text(
                '$count',
                key: ValueKey(count),
                style: TextStyle(
                  color: tagForeground,
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
            ),
          ],
        ),
      ),
    ];

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: isTrailing ? children.reversed.toList() : children,
    );
  }
}

/// Отмена последнего ответа — outlined-кнопка M3E по центру внизу.
/// Нажатие морфит форму (дефолт пакета).
class _UndoButton extends StatelessWidget {
  final bool canUndo;
  final VoidCallback onPressed;

  const _UndoButton({
    required this.canUndo,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    // Без тултипа: у нижнего края он перекрывается навигацией. Подпись
    // остаётся для экранного диктора.
    return M3EScope(
      child: M3EIconButton(
        variant: M3EIconButtonVariant.outlined,
        size: M3EIconButtonSize.md,
        semanticLabel: context.l10n.tinderTestUndoTooltip,
        onPressed: canUndo ? onPressed : null,
        icon: const Icon(Icons.undo),
      ),
    );
  }
}
