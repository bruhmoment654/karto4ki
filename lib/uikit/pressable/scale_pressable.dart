import 'package:flutter/material.dart';

const double _defaultOnPressScale = 0.95;
const Duration _defaultOnPressDuration = Duration(milliseconds: 150);

/// Pressable wrapper with subtle scale animation.
class ScalePressable extends StatefulWidget {
  const ScalePressable({
    required this.child,
    super.key,
    this.onTap,
    this.behavior = HitTestBehavior.opaque,
    this.pressedScale = _defaultOnPressScale,
    this.duration = _defaultOnPressDuration,
  });

  final Widget child;
  final VoidCallback? onTap;
  final HitTestBehavior behavior;
  final double pressedScale;
  final Duration duration;

  @override
  State<ScalePressable> createState() => _ScalePressableState();
}

class _ScalePressableState extends State<ScalePressable> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    if (widget.onTap == null) return widget.child;

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTap: () => widget.onTap?.call(),
      onTapCancel: () => setState(() => _isPressed = false),
      behavior: widget.behavior,
      child: AnimatedScale(
        scale: _isPressed ? widget.pressedScale : 1,
        curve: Curves.easeInOut,
        duration: widget.duration,
        child: widget.child,
      ),
    );
  }
}
