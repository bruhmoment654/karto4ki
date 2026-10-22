import 'package:flutter/material.dart';

import 'package:quizzerg/uikit/app_radii.dart';
import 'package:quizzerg/uikit/content_card/content_card.dart';
import 'package:quizzerg/uikit/skeleton/skeleton_box.dart';
import 'package:quizzerg/uikit/skeleton/skeleton_pulse.dart';
import 'package:quizzerg/uikit/spacing/height.dart';
import 'package:quizzerg/uikit/spacing/width.dart';
import 'package:quizzerg/uikit/theme/app_theme.dart';

/// Заглушка списка групп на время загрузки.
///
/// Повторяет геометрию и цветовой пул реальных карточек — переход
/// «скелетон → список» не двигает контент.
class GroupsListSkeleton extends StatelessWidget {
  const GroupsListSkeleton({this.itemCount = 3, super.key});

  /// Сколько карточек-заглушек показать.
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SkeletonPulse(
      child: Column(
        children: [
          for (var index = 0; index < itemCount; index++) ...[
            if (index > 0) const Height(16),
            _GroupCardSkeleton(index: index),
          ],
        ],
      ),
    );
  }
}

class _GroupCardSkeleton extends StatelessWidget {
  const _GroupCardSkeleton({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final pool = Theme.of(context).colorScheme.groupCardPool;
    final (background, foreground) = pool[index % pool.length];

    final shade = foreground.withValues(alpha: 0.14);
    final chipRadius = BorderRadius.circular(AppDimens.radius8);

    return ContentCard(
      backgroundColor: background,
      borderRadius: BorderRadius.circular(AppDimens.radius28),
      padding: const EdgeInsets.fromLTRB(20, 18, 18, 18),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SkeletonBox(
                  width: 160,
                  height: 26,
                  borderRadius: chipRadius,
                  color: shade,
                ),
                const Height(8),
                SkeletonBox(
                  width: 190,
                  borderRadius: chipRadius,
                  color: shade,
                ),
                const Height(14),
                Row(
                  children: [
                    SkeletonBox(
                      width: 92,
                      height: 28,
                      borderRadius: chipRadius,
                      color: shade,
                    ),
                    const Width(6),
                    SkeletonBox(
                      width: 84,
                      height: 28,
                      borderRadius: chipRadius,
                      color: shade,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Width(14),
          SkeletonBox(
            width: 64,
            height: 64,
            borderRadius: BorderRadius.circular(32),
            color: shade,
          ),
        ],
      ),
    );
  }
}
