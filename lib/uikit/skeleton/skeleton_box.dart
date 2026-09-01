import 'package:flutter/material.dart';

import 'package:quizzerg/uikit/app_radii.dart';

/// Прямоугольник-заглушка для скелетонов загрузки.
///
/// Рисует блок нейтрального цвета на месте будущего контента. Для «дыхания»
/// оберните группу таких блоков в `SkeletonPulse`.
class SkeletonBox extends StatelessWidget {
  const SkeletonBox({
    this.width,
    this.height = 16,
    this.borderRadius,
    this.color,
    super.key,
  });

  /// `null` — блок растягивается по ширине родителя.
  final double? width;

  final double height;

  final BorderRadius? borderRadius;

  /// Цвет заглушки. По умолчанию — приглушённый тон поверхности.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: width,
      height: height,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color ?? colorScheme.onSurfaceVariant.withValues(alpha: 0.14),
          borderRadius:
              borderRadius ?? BorderRadius.circular(AppDimens.radius8),
        ),
      ),
    );
  }
}
