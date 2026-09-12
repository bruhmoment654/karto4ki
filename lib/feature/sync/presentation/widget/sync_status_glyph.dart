import 'package:flutter/material.dart';

import 'package:quizzerg/feature/sync/presentation/sync_status_visual.dart';

/// Иконка статуса на тональной подложке.
///
/// Общая для бейджа в шапке, карточки профиля и заголовка диалога — во всех
/// трёх местах дизайн рисует один и тот же квадрат/круг с глифом.
class SyncStatusGlyph extends StatelessWidget {
  final SyncStatusVisual visual;
  final double size;
  final BorderRadius? borderRadius;

  /// Тональный фон под глифом.
  static Color toneOf(SyncStatusVisual visual, ColorScheme colorScheme) =>
      visual.isNeutral
          ? colorScheme.surfaceContainerHigh
          : visual.color.withValues(alpha: 0.16);

  const SyncStatusGlyph({
    required this.visual,
    this.size = 48,
    this.borderRadius,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final glyphSize = size * 0.54;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: toneOf(visual, colorScheme),
        borderRadius: borderRadius ?? BorderRadius.circular(16),
      ),
      alignment: Alignment.center,
      child: visual.isSpinner
          ? SizedBox(
              width: glyphSize,
              height: glyphSize,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                color: visual.color,
              ),
            )
          : Icon(visual.icon, size: glyphSize, color: visual.color),
    );
  }
}
