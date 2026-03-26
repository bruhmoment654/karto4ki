import 'package:flutter/material.dart';
import 'package:quizzerg/feature/main/domain/entity/card_entity.dart';
import 'package:quizzerg/l10n/app_localizations_x.dart';
import 'package:quizzerg/uikit/question_card/question_card.dart';

/// Swipe and snap-back animation duration.
const _animationDuration = Duration(milliseconds: 300);

/// Screen width fraction required to trigger a swipe by position.
const _swipePositionThresholdFraction = 0.3;

/// Velocity threshold (px/s) to trigger a swipe by flick.
const _swipeVelocityThreshold = 800.0;

/// Card fly-out target to the right (in screen width fractions).
const _swipeOutTarget = Offset(1.5, 0);

/// Card fly-out target to the left (in screen width fractions).
const _swipeOutTargetLeft = Offset(-1.5, 0);

/// Card rotation factor relative to horizontal offset.
const _rotationFactor = 0.3;

class SwipeableCardWrapper extends StatefulWidget {
  final CardEntity card;
  final bool showAnswer;
  final bool enableFlipAnimation;
  final Duration flipDuration;
  final double fontSize;
  final VoidCallback onTap;
  final VoidCallback onSwipeLeft;
  final VoidCallback onSwipeRight;
  final bool enterFromLeft;

  const SwipeableCardWrapper({
    required this.card,
    required this.showAnswer,
    required this.enableFlipAnimation,
    required this.onTap,
    required this.onSwipeLeft,
    required this.onSwipeRight,
    this.enterFromLeft = false,
    this.flipDuration = const Duration(milliseconds: 300),
    this.fontSize = 24,
    super.key,
  });

  @override
  State<SwipeableCardWrapper> createState() => _SwipeableCardWrapperState();
}

class _SwipeableCardWrapperState extends State<SwipeableCardWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  late Listenable _listenable;

  final Tween<Offset> _tween = Tween<Offset>(
    begin: Offset.zero,
    end: Offset.zero,
  );
  final ValueNotifier<Offset> _dragOffset = ValueNotifier(Offset.zero);
  bool _isDragging = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: _animationDuration,
    );
    _animation = _tween.animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));
    _listenable = Listenable.merge([_controller, _dragOffset]);
  }

  @override
  void didUpdateWidget(SwipeableCardWrapper oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.card.id != widget.card.id && widget.enterFromLeft) {
      final screenWidth = MediaQuery.of(context).size.width;
      _dragOffset.value = Offset(-screenWidth, 0);
      _animateBack();
    }
  }

  @override
  void dispose() {
    _dragOffset.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _onPanStart(DragStartDetails details) {
    _isDragging = true;
    _controller.stop();
  }

  void _onPanUpdate(DragUpdateDetails details) {
    _dragOffset.value += details.delta;
  }

  void _onPanEnd(DragEndDetails details) {
    _isDragging = false;
    final screenWidth = MediaQuery.of(context).size.width;
    final positionThreshold = screenWidth * _swipePositionThresholdFraction;
    final vx = details.velocity.pixelsPerSecond.dx;

    if (_dragOffset.value.dx > positionThreshold ||
        vx > _swipeVelocityThreshold) {
      _animateOut(_swipeOutTarget, widget.onSwipeRight);
    } else if (_dragOffset.value.dx < -positionThreshold ||
        vx < -_swipeVelocityThreshold) {
      _animateOut(_swipeOutTargetLeft, widget.onSwipeLeft);
    } else {
      _animateBack();
    }
  }

  void _animateOut(Offset target, VoidCallback callback) {
    final screenWidth = MediaQuery.of(context).size.width;
    _tween
      ..begin = _dragOffset.value / screenWidth
      ..end = target;
    _controller.forward(from: 0).then((_) {
      callback();
      _controller.reset();
      _dragOffset.value = Offset.zero;
      _tween
        ..begin = Offset.zero
        ..end = Offset.zero;
    });
  }

  void _animateBack() {
    final screenWidth = MediaQuery.of(context).size.width;
    _tween
      ..begin = _dragOffset.value / screenWidth
      ..end = Offset.zero;
    _controller.forward(from: 0).then((_) {
      _dragOffset.value = Offset.zero;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return ListenableBuilder(
      listenable: _listenable,
      builder: (context, child) {
        final offset = _isDragging
            ? _dragOffset.value
            : Offset(
                _animation.value.dx * screenWidth,
                _animation.value.dy * screenWidth,
              );
        final rotation = offset.dx / screenWidth * _rotationFactor;

        return Transform.translate(
          offset: offset,
          child: Transform.rotate(
            angle: rotation,
            child: GestureDetector(
              onTap: widget.onTap,
              onPanStart: _onPanStart,
              onPanUpdate: _onPanUpdate,
              onPanEnd: _onPanEnd,
              child: QuestionCardContent(
                front: Text(
                  widget.card.front,
                  style: TextStyle(
                    fontSize: widget.fontSize,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                back: Text(
                  widget.card.formattedBack,
                  style: TextStyle(
                    fontSize: widget.fontSize,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                showAnswer: widget.showAnswer,
                enableFlipAnimation: widget.enableFlipAnimation,
                flipDuration: widget.flipDuration,
                isMixedIn: widget.card.isMixedIn,
                cardOffset: offset,
                leftBadgeText: context.l10n.tinderTestUnknownBadge,
                rightBadgeText: context.l10n.tinderTestKnownBadge,
              ),
            ),
          ),
        );
      },
    );
  }
}
