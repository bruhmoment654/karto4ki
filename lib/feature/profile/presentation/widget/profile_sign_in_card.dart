import 'package:flutter/material.dart';

import 'package:quizzerg/l10n/app_localizations_x.dart';
import 'package:quizzerg/uikit/content_card/content_card.dart';
import 'package:quizzerg/uikit/content_card/content_card_type.dart';
import 'package:quizzerg/uikit/pressable/scale_pressable.dart';
import 'package:quizzerg/uikit/spacing/height.dart';
import 'package:quizzerg/uikit/spacing/width.dart';

/// Первый блок профиля для гостя: приглашение войти.
///
/// Экран для гостя не блокируется — приложение offline-first, меняется
/// только этот блок.
class ProfileSignInCard extends StatelessWidget {
  final VoidCallback onTap;

  const ProfileSignInCard({required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = context.l10n;

    return ScalePressable(
      onTap: onTap,
      child: ContentCard(
        type: ContentCardType.large,
        padding: const EdgeInsets.all(18),
        backgroundColor: colorScheme.primaryContainer,
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colorScheme.onPrimaryContainer.withValues(alpha: 0.16),
              ),
              alignment: Alignment.center,
              child: Icon(
                Icons.person,
                size: 30,
                color: colorScheme.onPrimaryContainer,
              ),
            ),
            const Width(16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.profileSignInTitle,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: colorScheme.onPrimaryContainer,
                    ),
                  ),
                  const Height(2),
                  Text(
                    l10n.profileSignInSubtitle,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onPrimaryContainer
                          .withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: colorScheme.onPrimaryContainer),
          ],
        ),
      ),
    );
  }
}
