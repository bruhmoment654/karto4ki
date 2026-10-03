import 'package:flutter/material.dart';
import 'package:quizzerg/feature/uikit_catalog/presentation/widgets/catalog_item.dart';
import 'package:quizzerg/uikit/app_radii.dart';
import 'package:quizzerg/uikit/content_card/content_card.dart';
import 'package:quizzerg/uikit/skeleton/skeleton_box.dart';
import 'package:quizzerg/uikit/skeleton/skeleton_pulse.dart';
import 'package:quizzerg/uikit/skeleton_gif/skeleton_gif.dart';
import 'package:quizzerg/uikit/spacing/height.dart';
import 'package:quizzerg/uikit/spacing/width.dart';

/// Заглушки загрузки.
class SkeletonsSection extends StatelessWidget {
  const SkeletonsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CatalogItem(
          title: 'SkeletonBox',
          description: 'Ширина по родителю или фиксированная',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SkeletonBox(),
              Height(8),
              SkeletonBox(width: 180),
              Height(8),
              SkeletonBox(width: 120, height: 32),
            ],
          ),
        ),
        CatalogItem(
          title: 'SkeletonPulse',
          description: 'Пульсация вокруг SkeletonBox',
          child: SkeletonPulse(child: _CardSkeleton()),
        ),
        CatalogItem(
          title: 'SkeletonGif',
          child: Center(child: SkeletonGif(height: 96)),
        ),
      ],
    );
  }
}

class _CardSkeleton extends StatelessWidget {
  const _CardSkeleton();

  @override
  Widget build(BuildContext context) {
    return ContentCard(
      child: Row(
        children: [
          SkeletonBox(
            width: 52,
            height: 52,
            borderRadius: BorderRadius.circular(AppDimens.radius12),
          ),
          const Width(12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SkeletonBox(width: 160, height: 18),
                Height(8),
                SkeletonBox(width: 100, height: 14),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
