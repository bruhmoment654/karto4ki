import 'package:flutter/material.dart';

import 'package:quizzerg/feature/auth/domain/entity/auth_user_entity.dart';
import 'package:quizzerg/feature/profile/presentation/widget/profile_avatar.dart';
import 'package:quizzerg/uikit/content_card/content_card.dart';
import 'package:quizzerg/uikit/content_card/content_card_type.dart';
import 'package:quizzerg/uikit/spacing/height.dart';
import 'package:quizzerg/uikit/spacing/width.dart';

/// Первый блок профиля для авторизованного: фото, имя, почта.
class ProfileAccountCard extends StatelessWidget {
  final AuthUserEntity? user;

  const ProfileAccountCard({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currentUser = user;

    return ContentCard(
      type: ContentCardType.large,
      padding: const EdgeInsets.all(18),
      child: Row(
        children: [
          ProfileAvatar(user: currentUser),
          const Width(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  currentUser?.title ?? '',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const Height(2),
                Text(
                  currentUser?.email ?? '',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
