import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Линейный прогресс-бар с плавной анимацией значения.
class AnimatedLinearProgress extends StatefulWidget {
  final ValueListenable<double> progress;
  final Color? backgroundColor;
  final Color? valueColor;
  final Duration duration;
  final Curve curve;
  final double minHeight;

  const AnimatedLinearProgress({
    required this.progress,
    this.backgroundColor,
    this.valueColor,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
    this.minHeight = 4,
    super.key,
  });

  @override
  State<AnimatedLinearProgress> createState() =>
      _AnimatedLinearProgressState();
}

class _AnimatedLinearProgressState extends State<AnimatedLinearProgress>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Tween<double> _tween;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    final initial = widget.progress.value;
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _tween = Tween<double>(begin: initial, end: initial);
    _animation = _tween.animate(
      CurvedAnimation(parent: _controller, curve: widget.curve),
    );
    widget.progress.addListener(_onProgressChanged);
  }

  @override
  void didUpdateWidget(AnimatedLinearProgress oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.progress != widget.progress) {
      oldWidget.progress.removeListener(_onProgressChanged);
      widget.progress.addListener(_onProgressChanged);
      _animateTo(widget.progress.value);
    }
    if (oldWidget.duration != widget.duration ||
        oldWidget.curve != widget.curve) {
      _controller.duration = widget.duration;
      _animation = _tween.animate(
        CurvedAnimation(parent: _controller, curve: widget.curve),
      );
    }
  }

  @override
  void dispose() {
    widget.progress.removeListener(_onProgressChanged);
    _controller.dispose();
    super.dispose();
  }

  void _onProgressChanged() {
    _animateTo(widget.progress.value);
  }

  void _animateTo(double target) {
    _tween
      ..begin = _animation.value
      ..end = target;
    _controller.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return LinearProgressIndicator(
          value: _animation.value,
          backgroundColor: widget.backgroundColor,
          valueColor: switch (widget.valueColor) {
            final color? => AlwaysStoppedAnimation<Color>(color),
            null => null,
          },
          minHeight: widget.minHeight,
        );
      },
    );
  }
}
