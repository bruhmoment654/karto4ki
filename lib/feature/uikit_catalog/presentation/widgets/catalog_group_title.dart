import 'package:flutter/material.dart';
import 'package:quizzerg/uikit/spacing/height.dart';

/// Заголовок над набором секций одной библиотеки компонентов.
class CatalogGroupTitle extends StatelessWidget {
  final String title;
  final String subtitle;

  const CatalogGroupTitle({
    required this.title,
    required this.subtitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: theme.textTheme.titleLarge),
          const Height(2),
          Text(
            subtitle,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
