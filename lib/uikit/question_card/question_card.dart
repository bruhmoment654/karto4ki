import 'dart:math' as math;

import 'package:flutter/material.dart';

class QuestionCard extends StatefulWidget {
  final Widget front;
  final Widget back;
  final VoidCallback? onFlip;

  const QuestionCard({
    required this.front,
    required this.back,
    this.onFlip,
    super.key,
  });

  factory QuestionCard.fromText({
    required String frontText,
    required String backText,
    VoidCallback? onFlip,
    Key? key,
  }) {
    return QuestionCard(
      front: _QuestionCardText(text: frontText),
      back: _QuestionCardText(text: backText),
      onFlip: onFlip,
      key: key,
    );
  }

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  final ValueNotifier<bool> _isFlipped = ValueNotifier(false);

  void _flip() {
    _isFlipped.value = !_isFlipped.value;
    widget.onFlip?.call();
  }

  @override
  void dispose() {
    _isFlipped.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _flip,
      child: ValueListenableBuilder<bool>(
        valueListenable: _isFlipped,
        builder: (context, isFlipped, child) {
          return QuestionCardContent(
            front: widget.front,
            back: widget.back,
            showAnswer: isFlipped,
            cardOffset: Offset.zero,
          );
        },
      ),
    );
  }
}

class _QuestionCardText extends StatelessWidget {
  final String text;

  const _QuestionCardText({required this.text});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Text(
      text,
      style: textTheme.headlineMedium?.copyWith(
        color: colorScheme.onPrimaryContainer,
        fontWeight: FontWeight.w600,
      ),
      textAlign: TextAlign.center,
    );
  }
}

class QuestionCardContent extends StatelessWidget {
  final Widget front;
  final Widget back;
  final bool showAnswer;
  final Offset cardOffset;
  final bool enableFlipAnimation;
  final Duration flipDuration;
  final String? leftBadgeText;
  final String? rightBadgeText;

  const QuestionCardContent({
    required this.front,
    required this.back,
    required this.showAnswer,
    required this.cardOffset,
    this.enableFlipAnimation = true,
    this.flipDuration = const Duration(milliseconds: 300),
    super.key,
    this.leftBadgeText,
    this.rightBadgeText,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final badgeText = switch (cardOffset.dx) {
      < 0 => leftBadgeText ?? '',
      > 0 => rightBadgeText ?? '',
      _ => '',
    };
    final showBadge = badgeText.isNotEmpty;
    final dxAbs = cardOffset.dx.abs();
    final showThreshold = screenWidth * 0.08;
    final maxDistance = screenWidth * 0.3;
    final badgeOpacity = dxAbs <= showThreshold
        ? 0.0
        : ((dxAbs - showThreshold) / (maxDistance - showThreshold))
            .clamp(0.0, 1.0)
            .toDouble();

    if (!enableFlipAnimation) {
      final angle = showAnswer ? math.pi : 0.0;
      final isBackVisible = angle > math.pi / 2;
      final transform = Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateY(angle);
      final face = isBackVisible
          ? Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(math.pi),
              child: _QuestionCardFace(
                badgeText: badgeText,
                showBadge: showBadge,
                badgeOpacity: badgeOpacity,
                body: back,
              ),
            )
          : _QuestionCardFace(
              badgeText: badgeText,
              showBadge: showBadge,
              badgeOpacity: badgeOpacity,
              body: front,
            );

      return Transform(
        alignment: Alignment.center,
        transform: transform,
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            padding: const EdgeInsets.all(24),
            child: Center(child: face),
          ),
        ),
      );
    }

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(
        begin: 0,
        end: showAnswer ? math.pi : 0,
      ),
      duration: flipDuration,
      curve: Curves.easeInOut,
      builder: (context, angle, child) {
        final isBackVisible = angle > math.pi / 2;
        final transform = Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateY(angle);
        final face = isBackVisible
            ? Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(math.pi),
                child: _QuestionCardFace(
                  badgeText: badgeText,
                  showBadge: showBadge,
                  badgeOpacity: badgeOpacity,
                  body: back,
                ),
              )
            : _QuestionCardFace(
                badgeText: badgeText,
                showBadge: showBadge,
                badgeOpacity: badgeOpacity,
                body: front,
              );

        return Transform(
          alignment: Alignment.center,
          transform: transform,
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              padding: const EdgeInsets.all(24),
              child: Center(child: face),
            ),
          ),
        );
      },
    );
  }
}

class _QuestionCardFace extends StatelessWidget {
  final String badgeText;
  final bool showBadge;
  final double badgeOpacity;
  final Widget body;

  const _QuestionCardFace({
    required this.badgeText,
    required this.showBadge,
    required this.badgeOpacity,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedOpacity(
          opacity: showBadge ? badgeOpacity : 0,
          duration: const Duration(milliseconds: 150),
          child: _QuestionCardText(text: badgeText),
        ),
        const SizedBox(height: 16),
        body,
      ],
    );
  }
}
