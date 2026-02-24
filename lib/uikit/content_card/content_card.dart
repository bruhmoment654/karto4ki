import 'package:flutter/material.dart';

import 'package:quizzerg/uikit/app_radii.dart';
import 'package:quizzerg/uikit/content_card/content_card_painter.dart';
import 'package:quizzerg/uikit/content_card/content_card_type.dart';

class ContentCard extends StatelessWidget {
  final Widget child;
  final ContentCardType type;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final double? elevation;
  final double backgroundOpacity;

  const ContentCard({
    required this.child,
    this.type = ContentCardType.small,
    this.backgroundColor,
    this.borderRadius,
    this.padding,
    this.elevation,
    this.backgroundOpacity = 0.7,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final resolvedBorderRadius = borderRadius ?? _defaultBorderRadius(type);
    final baseColor =
        backgroundColor ?? Theme.of(context).colorScheme.surfaceContainer;
    final resolvedBg = baseColor.withValues(alpha: backgroundOpacity);

    return Material(
      elevation: elevation ?? _defaultElevation(type),
      color: Colors.transparent,
      borderRadius: resolvedBorderRadius,
      child: ClipRRect(
        borderRadius: resolvedBorderRadius,
        child: ColoredBox(
          color: resolvedBg,
          child: CustomPaint(
            painter: ContentCardPainter(
              type: type,
              accentColor: Theme.of(context).colorScheme.primary,
            ),
            child: Padding(
              padding: padding ?? _defaultPadding(type),
              child: child,
            ),
          ),
        ),
      ),
    );
  }

  static BorderRadius _defaultBorderRadius(ContentCardType type) =>
      switch (type) {
        ContentCardType.large || ContentCardType.medium =>
          BorderRadius.circular(AppDimens.radius16),
        ContentCardType.smallWide || ContentCardType.small =>
          BorderRadius.circular(AppDimens.radius8),
      };

  static double _defaultElevation(ContentCardType type) => switch (type) {
        ContentCardType.large => 8,
        _ => 0,
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
