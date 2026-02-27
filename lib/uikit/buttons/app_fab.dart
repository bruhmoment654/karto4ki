import 'package:flutter/material.dart';

import 'package:quizzerg/uikit/content_card/content_card.dart';

class AppFloatingActionButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;

  const AppFloatingActionButton({
    required this.label,
    required this.onPressed,
    this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme.labelMedium?.copyWith(
          color: colorScheme.onSurface,
          fontWeight: FontWeight.w600,
        );

    return GestureDetector(
      onTap: onPressed,
      child: ContentCard(
        elevation: 5,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(label, style: textStyle),
            if (icon != null) ...[
              const SizedBox(width: 4),
              Icon(icon, size: 16, color: colorScheme.onSurface),
            ],
          ],
        ),
      ),
    );
  }
}
