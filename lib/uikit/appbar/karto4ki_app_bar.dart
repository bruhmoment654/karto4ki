import 'package:flutter/material.dart';
import 'package:quizzerg/uikit/skeleton_gif/skeleton_gif.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final VoidCallback? onTap;
  final Widget? leading;
  final PreferredSizeWidget? bottom;
  final bool centerTitle;
  final List<Widget>? actions;
  final double elevation;
  final bool expanded;

  static const compactToolbarHeight = kToolbarHeight;
  static const expandedToolbarHeight = kToolbarHeight + 32;
  const DefaultAppBar({
    required this.title,
    this.onTap,
    this.leading,
    this.bottom,
    this.centerTitle = true,
    this.actions,
    this.elevation = 0,
    this.expanded = false,
    super.key,
  });

  const DefaultAppBar.expanded({
    required this.title,
    this.onTap,
    this.leading,
    this.bottom,
    this.centerTitle = true,
    this.actions,
    this.elevation = 0,
    super.key,
  }) : expanded = true;

  double get _toolbarHeight =>
      expanded ? expandedToolbarHeight : compactToolbarHeight;

  @override
  Size get preferredSize => Size.fromHeight(
        _toolbarHeight + (bottom?.preferredSize.height ?? 0),
      );

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final itemsColor = colorScheme.onSurfaceVariant;

    final styledTitle = DefaultTextStyle(
      style: (Theme.of(context).textTheme.titleLarge ?? const TextStyle())
          .copyWith(
        color: itemsColor,
      ),
      child: IconTheme(
        data: IconThemeData(color: itemsColor, size: 24),
        child: title,
      ),
    );

    final resolvedTitle =
        onTap != null ? IgnorePointer(child: styledTitle) : styledTitle;

    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: elevation,
      scrolledUnderElevation: 0,
      toolbarHeight: _toolbarHeight,
      leading: leading ?? const SkeletonGif(),
      centerTitle: centerTitle,
      title: resolvedTitle,
      flexibleSpace: onTap != null
          ? InkWell(
              onTap: onTap,
              child: const SizedBox.expand(),
            )
          : null,
      bottom: bottom,
      actions: actions,
    );
  }
}
