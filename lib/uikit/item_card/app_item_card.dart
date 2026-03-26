import 'package:flutter/material.dart';

import 'package:quizzerg/uikit/content_card/content_card.dart';
import 'package:quizzerg/uikit/content_card/content_card_type.dart';
import 'package:quizzerg/uikit/theme/app_theme.dart';

/// Переиспользуемая карточка элемента списка.
///
/// Единый дизайн: иконка слева, заголовок + описание + подпись справа.
class AppItemCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final String? caption;
  final Widget? trailing;

  const AppItemCard({
    required this.icon,
    required this.title,
    this.subtitle,
    this.caption,
    this.trailing,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return ContentCard(
      type: ContentCardType.medium,
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: colorScheme.primary.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              size: 20,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.foreground,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle!,
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.mutedForeground,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
                if (caption != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    caption!,
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.mutedForeground,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}
