import 'package:flutter/material.dart';

import 'package:quizzerg/uikit/app_radii.dart';
import 'package:quizzerg/uikit/content_card/content_card_type.dart';

class ContentCard extends StatelessWidget {
  final Widget child;
  final ContentCardType type;
  final Color? backgroundColor;

  /// Граница рисуется только если задан [borderColor] и [borderWidth] > 0.
  /// По умолчанию заполненная тональная поверхность M3 — без «Cupertino-обводки».
  final Color? borderColor;
  final double borderWidth;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;

  /// Тень рисуется только при [elevation] > 0 (elevated-карточка).
  final double? elevation;

  const ContentCard({
    required this.child,
    this.type = ContentCardType.small,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth = 0,
    this.borderRadius,
    this.padding,
    this.elevation,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final resolvedBorderRadius = borderRadius ?? _defaultBorderRadius(type);
    final bgColor = backgroundColor ?? colorScheme.surfaceContainer;
    final hasBorder = borderColor != null && borderWidth > 0;
    final hasShadow = elevation != null && elevation! > 0;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: resolvedBorderRadius,
        border: hasBorder
            ? Border.all(color: borderColor!, width: borderWidth)
            : null,
        boxShadow: hasShadow
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: elevation! * 2,
                  offset: Offset(0, elevation!),
                ),
              ]
            : null,
      ),
      child: ClipRRect(
        borderRadius: resolvedBorderRadius,
        child: Padding(
          padding: padding ?? _defaultPadding(type),
          child: child,
        ),
      ),
    );
  }

  // Маленькие карточки списков — r16 (lg); крупные/цветные — r28 (xl).
  static BorderRadius _defaultBorderRadius(ContentCardType type) =>
      switch (type) {
        ContentCardType.large ||
        ContentCardType.medium =>
          BorderRadius.circular(AppDimens.radius28),
        ContentCardType.smallWide ||
        ContentCardType.small =>
          BorderRadius.circular(AppDimens.radius16),
      };

  static EdgeInsetsGeometry _defaultPadding(ContentCardType type) =>
      switch (type) {
        ContentCardType.large => const EdgeInsets.all(24),
        ContentCardType.medium => const EdgeInsets.all(16),
        ContentCardType.smallWide =>
          const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        ContentCardType.small => const EdgeInsets.all(16),
      };
}
