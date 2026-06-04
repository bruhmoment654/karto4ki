import 'package:flutter/material.dart';

import 'package:quizzerg/uikit/theme/app_theme.dart';

enum Karto4kiButtonVariant {
  primary,
  secondary,
  accent,
  ghost,
  outline,
  destructive,
  success,
}

/// Кнопка дизайн-системы на каноничных M3-кнопках (pill-форма).
///
/// - primary → [FilledButton]
/// - secondary → [FilledButton.tonal]
/// - ghost → [TextButton]
/// - outline → [OutlinedButton]
/// - accent/destructive/success → Filled с tertiary/error/success-контейнером
class Karto4kiButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isExpanded;
  final IconData? icon;
  final Karto4kiButtonVariant variant;

  const Karto4kiButton({
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.isExpanded = false,
    this.icon,
    this.variant = Karto4kiButtonVariant.primary,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveOnPressed = isLoading ? null : onPressed;
    final child = _ButtonContent(label: label, isLoading: isLoading);
    final iconWidget = icon != null ? Icon(icon) : null;

    final button = _build(context, effectiveOnPressed, child, iconWidget);

    if (!isExpanded) return button;

    return SizedBox(width: double.infinity, child: button);
  }

  Widget _build(
    BuildContext context,
    VoidCallback? onPressed,
    Widget child,
    Widget? iconWidget,
  ) {
    final cs = Theme.of(context).colorScheme;

    switch (variant) {
      case Karto4kiButtonVariant.primary:
        return iconWidget == null
            ? FilledButton(onPressed: onPressed, child: child)
            : FilledButton.icon(
                onPressed: onPressed,
                icon: iconWidget,
                label: child,
              );
      case Karto4kiButtonVariant.secondary:
        return iconWidget == null
            ? FilledButton.tonal(onPressed: onPressed, child: child)
            : FilledButton.tonalIcon(
                onPressed: onPressed,
                icon: iconWidget,
                label: child,
              );
      case Karto4kiButtonVariant.ghost:
        return iconWidget == null
            ? TextButton(onPressed: onPressed, child: child)
            : TextButton.icon(
                onPressed: onPressed,
                icon: iconWidget,
                label: child,
              );
      case Karto4kiButtonVariant.outline:
        return iconWidget == null
            ? OutlinedButton(onPressed: onPressed, child: child)
            : OutlinedButton.icon(
                onPressed: onPressed,
                icon: iconWidget,
                label: child,
              );
      case Karto4kiButtonVariant.accent:
        return _filledColored(
          onPressed,
          child,
          iconWidget,
          background: cs.tertiaryContainer,
          foreground: cs.onTertiaryContainer,
        );
      case Karto4kiButtonVariant.destructive:
        return _filledColored(
          onPressed,
          child,
          iconWidget,
          background: cs.errorContainer,
          foreground: cs.onErrorContainer,
        );
      case Karto4kiButtonVariant.success:
        return _filledColored(
          onPressed,
          child,
          iconWidget,
          background: cs.success,
          foreground: cs.onSuccess,
        );
    }
  }

  Widget _filledColored(
    VoidCallback? onPressed,
    Widget child,
    Widget? iconWidget, {
    required Color background,
    required Color foreground,
  }) {
    final style = FilledButton.styleFrom(
      backgroundColor: background,
      foregroundColor: foreground,
    );
    return iconWidget == null
        ? FilledButton(onPressed: onPressed, style: style, child: child)
        : FilledButton.icon(
            onPressed: onPressed,
            style: style,
            icon: iconWidget,
            label: child,
          );
  }
}

class _ButtonContent extends StatelessWidget {
  final String label;
  final bool isLoading;

  const _ButtonContent({
    required this.label,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    if (!isLoading) {
      return Text(label);
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          width: 16,
          height: 16,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
        const SizedBox(width: 8),
        Text(label),
      ],
    );
  }
}
