import 'package:flutter/material.dart';

import 'package:quizzerg/uikit/app_radii.dart';
import 'package:quizzerg/uikit/content_card/content_card_type.dart';
import 'package:quizzerg/uikit/theme/app_theme.dart';

class ContentCard extends StatelessWidget {
  final Widget child;
  final ContentCardType type;
  final Color? backgroundColor;
  final Color? borderColor;
  final double borderWidth;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final double? elevation;

  const ContentCard({
    required this.child,
    this.type = ContentCardType.small,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth = 1.0,
    this.borderRadius,
    this.padding,
    this.elevation,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final resolvedBorderRadius = borderRadius ?? _defaultBorderRadius(type);
    final bgColor = backgroundColor ?? colorScheme.card;
    final resolvedBorderColor =
        borderColor ?? colorScheme.border.withValues(alpha: 0.6);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: resolvedBorderRadius,
        border: Border.all(
          color: resolvedBorderColor,
          width: borderWidth,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
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

  static BorderRadius _defaultBorderRadius(ContentCardType type) =>
      switch (type) {
        ContentCardType.large ||
        ContentCardType.medium =>
          BorderRadius.circular(AppDimens.radius16),
        ContentCardType.smallWide ||
        ContentCardType.small =>
          BorderRadius.circular(AppDimens.radius8),
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
