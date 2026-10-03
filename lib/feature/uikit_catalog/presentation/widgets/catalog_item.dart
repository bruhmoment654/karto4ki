import 'package:flutter/material.dart';
import 'package:quizzerg/uikit/spacing/height.dart';

/// Демо одного компонента в каталоге: подпись и сам компонент.
class CatalogItem extends StatelessWidget {
  /// Имя компонента, как в коде.
  final String title;

  /// Что показано в демо: варианты, состояния.
  final String? description;

  final Widget child;

  const CatalogItem({
    required this.title,
    required this.child,
    this.description,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final description = this.description;

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.labelLarge?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
          if (description != null) ...[
            const Height(2),
            Text(
              description,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
          const Height(12),
          child,
        ],
      ),
    );
  }
}
