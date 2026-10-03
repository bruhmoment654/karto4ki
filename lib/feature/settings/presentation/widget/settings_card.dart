import 'package:flutter/material.dart';

import 'package:quizzerg/uikit/app_radii.dart';
import 'package:quizzerg/uikit/content_card/content_card.dart';
import 'package:quizzerg/uikit/spacing/height.dart';
import 'package:quizzerg/uikit/spacing/width.dart';

/// Карточка-блок настроек по дизайну: иконка + заголовок и список секций.
class SettingsCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final List<Widget> children;
  final Duration fadeInDelay;

  const SettingsCard({
    required this.icon,
    required this.title,
    required this.children,
    this.fadeInDelay = Duration.zero,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ContentCard(
      fadeIn: true,
      fadeInDelay: fadeInDelay,
      borderRadius: BorderRadius.circular(AppDimens.radius28),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 22, color: theme.colorScheme.primary),
              const Width(10),
              Flexible(
                child: Text(title, style: theme.textTheme.titleMedium),
              ),
            ],
          ),
          const Height(16),
          ...children,
        ],
      ),
    );
  }
}
