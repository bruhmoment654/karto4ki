import 'package:flutter/material.dart';

class AppGlowButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color? color;
  final Color foregroundColor;
  final Widget child;

  const AppGlowButton({
    required this.onPressed,
    required this.child,
    this.color,
    this.foregroundColor = Colors.white,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final resolvedColor = color ?? Theme.of(context).colorScheme.primary;

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: resolvedColor.withValues(alpha: 0.4),
            blurRadius: 16,
            spreadRadius: 1,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: resolvedColor,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: IconTheme(
              data: IconThemeData(color: foregroundColor, size: 20),
              child: DefaultTextStyle(
                style: (Theme.of(context).textTheme.labelLarge ??
                        const TextStyle())
                    .copyWith(
                  color: foregroundColor,
                  fontWeight: FontWeight.w600,
                ),
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
