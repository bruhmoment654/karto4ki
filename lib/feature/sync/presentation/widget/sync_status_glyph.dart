import 'package:flutter/material.dart';

import 'package:quizzerg/feature/sync/presentation/sync_status_visual.dart';
import 'package:quizzerg/uikit/motion/app_animated_switcher.dart';
import 'package:quizzerg/uikit/motion/app_motion.dart';
import 'package:quizzerg/uikit/progress/app_loading_indicator.dart';

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

  /// `false` — вместо спиннера статичная иконка состояния: загрузку на этом
  /// экране показывает что-то другое.
  final bool isSpinnerAllowed;

  const SyncStatusGlyph({
    required this.visual,
    this.size = 48,
    this.borderRadius,
    this.isSpinnerAllowed = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final glyphSize = size * 0.54;
    // Морфящийся полигон визуально легче глифа — по дизайну он чуть крупнее.
    final spinnerSize = size * 0.58;

    // При смене статуса тон подложки перетекает, глиф сменяется свитчером.
    return AnimatedContainer(
      duration: AppMotion.reduced(context)
          ? Duration.zero
          : AppAnimatedSwitcher.duration,
      curve: AppMotion.emphasized,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: toneOf(visual, colorScheme),
        borderRadius: borderRadius ?? BorderRadius.circular(16),
      ),
      alignment: Alignment.center,
      child: AppAnimatedSwitcher(
        child: visual.isSpinner && isSpinnerAllowed
            ? AppLoadingIndicator(
                key: const ValueKey('sync_spinner'),
                size: spinnerSize,
                color: visual.color,
              )
            : Icon(
                visual.icon,
                key: ValueKey((visual.icon, visual.color)),
                size: glyphSize,
                color: visual.color,
              ),
      ),
    );
  }
}
