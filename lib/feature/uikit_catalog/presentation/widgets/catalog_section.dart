import 'package:flutter/material.dart';
import 'package:quizzerg/uikit/app_radii.dart';
import 'package:quizzerg/uikit/content_card/content_card.dart';
import 'package:quizzerg/uikit/content_card/content_card_type.dart';
import 'package:quizzerg/uikit/dropdown/app_dropdown.dart';

/// Сворачиваемая группа компонентов каталога.
class CatalogSection extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget child;

  const CatalogSection({
    required this.icon,
    required this.title,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ContentCard(
      type: ContentCardType.medium,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: AppDropdown(
        title: title,
        leading: _SectionIcon(icon: icon),
        child: Padding(padding: const EdgeInsets.only(top: 12), child: child),
      ),
    );
  }
}

class _SectionIcon extends StatelessWidget {
  final IconData icon;

  const _SectionIcon({required this.icon});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(AppDimens.radius12),
      ),
      child: Icon(icon, size: 22, color: colorScheme.onSecondaryContainer),
    );
  }
}
