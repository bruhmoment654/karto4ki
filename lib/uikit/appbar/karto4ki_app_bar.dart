import 'package:flutter/material.dart';

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
  static const dividerHeight = 1.0;

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
        _toolbarHeight + (bottom?.preferredSize.height ?? 0) + dividerHeight,
      );

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final itemsColor = colorScheme.onSurfaceVariant;

    final styledTitle = DefaultTextStyle(
      style: (Theme.of(context).textTheme.titleLarge ?? const TextStyle()).copyWith(
            color: itemsColor,
          ),
      child: IconTheme(
        data: IconThemeData(color: itemsColor, size: 24),
        child: title,
      ),
    );

    final resolvedTitle =
        onTap != null ? IgnorePointer(child: styledTitle) : styledTitle;

    final defaultBottom = PreferredSize(
      preferredSize: Size.fromHeight(
        (bottom?.preferredSize.height ?? 0) + dividerHeight,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (bottom != null) bottom!,
          Divider(
            height: dividerHeight,
            thickness: dividerHeight,
            color: colorScheme.onSurfaceVariant.withValues(alpha: 0.1),
          ),
        ],
      ),
    );

    return AppBar(
      backgroundColor: colorScheme.surface.withAlpha(50),
      elevation: elevation,
      scrolledUnderElevation: 0,
      toolbarHeight: _toolbarHeight,
      leading: leading,
      centerTitle: centerTitle,
      title: resolvedTitle,
      flexibleSpace: onTap != null
          ? InkWell(
              onTap: onTap,
              child: const SizedBox.expand(),
            )
          : null,
      bottom: defaultBottom,
      actions: actions,
    );
  }
}
