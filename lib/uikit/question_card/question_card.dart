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
  bool _isFlipped = false;

  void _flip() {
    setState(() {
      _isFlipped = !_isFlipped;
    });
    widget.onFlip?.call();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _flip,
      child: QuestionCardContent(
        front: widget.front,
        back: widget.back,
        showAnswer: _isFlipped,
        cardOffset: Offset.zero,
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
  final String? leftBadgeText;
  final String? rightBadgeText;

  const QuestionCardContent({
    required this.front,
    required this.back,
    required this.showAnswer,
    required this.cardOffset,
    super.key,
    this.leftBadgeText,
    this.rightBadgeText,
  });

  @override
  Widget build(BuildContext context) {
    final badgeText = switch (cardOffset.dx) {
      < 0 => leftBadgeText ?? '',
      > 0 => rightBadgeText ?? '',
      _ => '',
    };

    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedCrossFade(
                duration: const Duration(milliseconds: 200),
                crossFadeState: badgeText.isNotEmpty
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                firstChild: _QuestionCardText(text: badgeText),
                secondChild: const SizedBox.shrink(),
              ),
              const SizedBox(height: 16),
              front,
              AnimatedCrossFade(
                duration: const Duration(milliseconds: 200),
                crossFadeState: showAnswer
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                firstChild: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 24),
                    const Divider(),
                    const SizedBox(height: 24),
                    back,
                  ],
                ),
                secondChild: const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
