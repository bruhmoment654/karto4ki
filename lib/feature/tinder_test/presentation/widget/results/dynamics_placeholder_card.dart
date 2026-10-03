import 'package:flutter/material.dart';
import 'package:quizzerg/l10n/app_localizations_x.dart';
import 'package:quizzerg/uikit/app_radii.dart';
import 'package:quizzerg/uikit/shape/shape_plate.dart';
import 'package:quizzerg/uikit/spacing/height.dart';
import 'package:quizzerg/uikit/spacing/width.dart';

/// Вместо динамики при первом прохождении: сравнивать пока не с чем.
class DynamicsPlaceholderCard extends StatelessWidget {
  const DynamicsPlaceholderCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(AppDimens.radius28),
      ),
      child: Row(
        children: [
          ShapePlate(
            kind: ShapePlateKind.cookie7Sided,
            size: 48,
            color: colorScheme.secondaryContainer,
            child: Icon(
              Icons.timeline,
              size: 24,
              color: colorScheme.onSecondaryContainer,
            ),
          ),
          const Width(14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10n.tinderTestResultsDynamicsPlaceholderTitle,
                  style: textTheme.titleMedium,
                ),
                const Height(2),
                Text(
                  context.l10n.tinderTestResultsDynamicsPlaceholderSubtitle,
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
