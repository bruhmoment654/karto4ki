import 'package:flutter/material.dart';
import 'package:karto4ki/feature/main/domain/entity/card_entity.dart';
import 'package:karto4ki/l10n/app_localizations_x.dart';
import 'package:karto4ki/uikit/question_card/question_card.dart';

class SwipeableCardWrapper extends StatefulWidget {
  final CardEntity card;
  final bool showAnswer;
  final VoidCallback onTap;
  final VoidCallback onSwipeLeft;
  final VoidCallback onSwipeRight;

  const SwipeableCardWrapper({
    required this.card,
    required this.showAnswer,
    required this.onTap,
    required this.onSwipeLeft,
    required this.onSwipeRight,
    super.key,
  });

  @override
  State<SwipeableCardWrapper> createState() => _SwipeableCardWrapperState();
}

class _SwipeableCardWrapperState extends State<SwipeableCardWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  /// Reused tween: update begin/end per gesture to avoid new Animation objects.
  final Tween<Offset> _tween = Tween<Offset>(
    begin: Offset.zero,
    end: Offset.zero,
  );
  Offset _dragOffset = Offset.zero;
  bool _isDragging = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = _tween.animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onPanStart(DragStartDetails details) {
    _isDragging = true;
    _controller.stop();
  }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      _dragOffset += details.delta;
    });
  }

  void _onPanEnd(DragEndDetails details) {
    _isDragging = false;
    final screenWidth = MediaQuery.of(context).size.width;
    final threshold = screenWidth * 0.3;

    if (_dragOffset.dx > threshold) {
      _animateOut(const Offset(1.5, 0), widget.onSwipeRight);
    } else if (_dragOffset.dx < -threshold) {
      _animateOut(const Offset(-1.5, 0), widget.onSwipeLeft);
    } else {
      _animateBack();
    }
  }

  void _animateOut(Offset target, VoidCallback callback) {
    final screenWidth = MediaQuery.of(context).size.width;
    _tween
      ..begin = _dragOffset / screenWidth
      ..end = target;
    _controller.forward(from: 0).then((_) {
      callback();
      _controller.reset();
      _dragOffset = Offset.zero;
      _tween
        ..begin = Offset.zero
        ..end = Offset.zero;
    });
  }

  void _animateBack() {
    final screenWidth = MediaQuery.of(context).size.width;
    _tween
      ..begin = _dragOffset / screenWidth
      ..end = Offset.zero;
    _controller.forward(from: 0).then((_) {
      _dragOffset = Offset.zero;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final offset = _isDragging
            ? _dragOffset
            : Offset(
                _animation.value.dx * screenWidth,
                _animation.value.dy * screenWidth,
              );
        final rotation = offset.dx / screenWidth * 0.3;

        return Transform.translate(
          offset: offset,
          child: Transform.rotate(
            angle: rotation,
            child: child,
          ),
        );
      },
      child: GestureDetector(
        onTap: widget.onTap,
        onPanStart: _onPanStart,
        onPanUpdate: _onPanUpdate,
        onPanEnd: _onPanEnd,
        child: QuestionCardContent(
          front: Text(
            widget.card.front,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          back: Text(
            widget.card.back,
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey[700],
            ),
            textAlign: TextAlign.center,
          ),
          showAnswer: widget.showAnswer,
          dragOffset: _dragOffset,
          leftBadgeText: context.l10n.tinderTestUnknownBadge,
          rightBadgeText: context.l10n.tinderTestKnownBadge,
        ),
      ),
    );
  }
}
