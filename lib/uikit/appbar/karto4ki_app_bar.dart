import 'package:flutter/material.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final IconData? titleIcon;
  final VoidCallback? onTap;
  final Widget? leading;
  final PreferredSizeWidget? bottom;
  final bool centerTitle;
  final List<Widget>? actions;
  final double elevation;

  static const toolbarHeight = kToolbarHeight + 32;

  const DefaultAppBar({
    required this.title,
    this.titleIcon,
    this.onTap,
    this.leading,
    this.bottom,
    this.centerTitle = true,
    this.actions,
    this.elevation = 0,
    super.key,
  });

  static const dividerHeight = 1.0;

  @override
  Size get preferredSize => Size.fromHeight(
        toolbarHeight + (bottom?.preferredSize.height ?? 0) + dividerHeight,
      );

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final itemsColor = colorScheme.onSurfaceVariant;

    final titleWidget = titleIcon != null
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(titleIcon, color: itemsColor, size: 24),
              const SizedBox(height: 8),
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: itemsColor,
                    ),
              ),
            ],
          )
        : Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: itemsColor,
                ),
          );

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
      toolbarHeight: toolbarHeight,
      leading: leading,
      centerTitle: centerTitle,
      title: titleWidget,
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
