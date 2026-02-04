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
        dragOffset: Offset.zero,
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
  final Offset dragOffset;
  final String? leftBadgeText;
  final String? rightBadgeText;

  const QuestionCardContent({
    required this.front,
    required this.back,
    required this.showAnswer,
    required this.dragOffset,
    super.key,
    this.leftBadgeText,
    this.rightBadgeText,
  });

  @override
  Widget build(BuildContext context) {
    final leftOpacity = (dragOffset.dx.abs() / 100).clamp(0.0, 1.0);
    final showLeft = dragOffset.dx < 0 && leftBadgeText != null;
    final showRight = dragOffset.dx > 0 && rightBadgeText != null;

    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(24),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  front,
                  if (showAnswer) ...[
                    const SizedBox(height: 24),
                    const Divider(),
                    const SizedBox(height: 24),
                    back,
                  ],
                ],
              ),
            ),
            if (showLeft)
              Positioned(
                top: 16,
                left: 16,
                child: Opacity(
                  opacity: leftOpacity,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.red, width: 3),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      leftBadgeText!,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            if (showRight)
              Positioned(
                top: 16,
                right: 16,
                child: Opacity(
                  opacity: leftOpacity,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green, width: 3),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      rightBadgeText!,
                      style: const TextStyle(
                        color: Colors.green,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
