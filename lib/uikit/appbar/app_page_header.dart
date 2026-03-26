import 'package:flutter/material.dart';
import 'package:quizzerg/uikit/pressable/scale_pressable.dart';

import 'package:quizzerg/uikit/skeleton_gif/skeleton_gif.dart';
import 'package:quizzerg/uikit/theme/app_theme.dart';

/// Переиспользуемый заголовок страницы.
///
/// Два варианта:
/// - [AppPageHeader] — заголовок + подзаголовок слева, экшен справа.
/// - [AppPageHeader.withBack] — шеврон назад, SkeletonGif + заголовок
///   в колонке, экшен справа.
class AppPageHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final VoidCallback? onTitlePressed;
  final Widget? action;

  const AppPageHeader({
    required this.title,
    this.subtitle,
    this.onTitlePressed,
    this.action,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: onTitlePressed,
                  child: Text(
                    title,
                    style: textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.foreground,
                    ),
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    subtitle!,
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.mutedForeground,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (action != null) ...[
            const SizedBox(width: 16),
            action!,
          ],
        ],
      ),
    );
  }

  /// Вариант с кнопкой назад (шеврон).
  static Widget withBack({
    required String title,
    required VoidCallback onBackPressed,
    String? subtitle,
    VoidCallback? onTitlePressed,
    Widget? action,
    Color? foregroundColor,
    Color? subtitleColor,
    Key? key,
  }) {
    return _AppPageHeaderWithBack(
      title: title,
      onBackPressed: onBackPressed,
      subtitle: subtitle,
      onTitlePressed: onTitlePressed,
      action: action,
      foregroundColor: foregroundColor,
      subtitleColor: subtitleColor,
      key: key,
    );
  }
}

class _AppPageHeaderWithBack extends StatelessWidget {
  final String title;
  final String? subtitle;
  final VoidCallback onBackPressed;
  final VoidCallback? onTitlePressed;
  final Widget? action;
  final Color? foregroundColor;
  final Color? subtitleColor;

  const _AppPageHeaderWithBack({
    required this.title,
    required this.onBackPressed,
    this.subtitle,
    this.onTitlePressed,
    this.action,
    this.foregroundColor,
    this.subtitleColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
      bottom: false,
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(4, 4, 16, 0),
          child: Row(
            children: [
              IconButton(
                onPressed: onBackPressed,
                icon: Icon(
                  Icons.chevron_left,
                  color: foregroundColor ?? colorScheme.foreground,
                  size: 28,
                ),
              ),
              const SkeletonGif(height: 36),
              const Spacer(),
              if (action != null) action!,
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(44, 12, 16, 24),
          child: GestureDetector(
            onTap: onTitlePressed,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: foregroundColor ?? colorScheme.foreground,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    subtitle!,
                    style: textTheme.bodyMedium?.copyWith(
                      color: subtitleColor ?? colorScheme.mutedForeground,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
      ),
    );
  }

}
