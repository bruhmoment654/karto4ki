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
      child: _QuestionCardContent(
        child: _isFlipped ? widget.back : widget.front,
        isFlipped: _isFlipped,
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

class _QuestionCardContent extends StatelessWidget {
  final Widget child;
  final bool isFlipped;

  const _QuestionCardContent({required this.child, required this.isFlipped});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final backgroundColor = isFlipped
        ? colorScheme.secondaryContainer
        : colorScheme.primaryContainer;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(child: child),
      ),
    );
  }
}
