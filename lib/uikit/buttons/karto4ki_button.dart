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
    final style = _resolveStyle(context);
    final effectiveOnPressed = isLoading ? null : onPressed;

    final button = icon == null
        ? ElevatedButton(
            onPressed: effectiveOnPressed,
            style: style,
            child: _ButtonContent(label: label, isLoading: isLoading),
          )
        : ElevatedButton.icon(
            onPressed: effectiveOnPressed,
            style: style,
            icon: Icon(icon),
            label: _ButtonContent(label: label, isLoading: isLoading),
          );

    if (!isExpanded) return button;

    return SizedBox(width: double.infinity, child: button);
  }

  ButtonStyle _resolveStyle(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final colors = _variantColors(colorScheme);

    return ElevatedButton.styleFrom(
      foregroundColor: colors.foreground,
      backgroundColor: colors.background,
      disabledForegroundColor: colors.foreground.withValues(alpha: 0.4),
      disabledBackgroundColor: colors.background.withValues(alpha: 0.4),
      textStyle: const TextStyle(fontWeight: FontWeight.w600),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: colors.borderSide,
      ),
    );
  }

  _VariantColors _variantColors(ColorScheme cs) => switch (variant) {
        Karto4kiButtonVariant.primary => _VariantColors(
            background: cs.primary,
            foreground: Colors.white,
          ),
        Karto4kiButtonVariant.secondary => _VariantColors(
            background: cs.secondary,
            foreground: cs.secondaryForeground,
          ),
        Karto4kiButtonVariant.accent => _VariantColors(
            background: cs.accent,
            foreground: Colors.white,
          ),
        Karto4kiButtonVariant.ghost => _VariantColors(
            background: Colors.transparent,
            foreground: cs.foreground,
          ),
        Karto4kiButtonVariant.outline => _VariantColors(
            background: Colors.transparent,
            foreground: cs.primary,
            borderSide: BorderSide(color: cs.primary, width: 2),
          ),
        Karto4kiButtonVariant.destructive => _VariantColors(
            background: cs.error,
            foreground: Colors.white,
          ),
        Karto4kiButtonVariant.success => _VariantColors(
            background: cs.success,
            foreground: Colors.white,
          ),
      };
}

class _VariantColors {
  final Color background;
  final Color foreground;
  final BorderSide borderSide;

  const _VariantColors({
    required this.background,
    required this.foreground,
    this.borderSide = BorderSide.none,
  });
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
