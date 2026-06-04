import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quizzerg/uikit/motion/app_motion.dart';

/// Крупный expressive FAB (64dp, r28, primaryContainer/onPrimaryContainer).
///
/// Параметры размера/формы/цвета берутся из `floatingActionButtonTheme`.
/// [label] используется как tooltip (иконочный FAB по дизайну M3).
///
/// При появлении «выскакивает» с пружиной ([AppMotion.spring]) после небольшой
/// задержки. reduced-motion ([AppMotion.reduced]): сразу в финальном масштабе.
class AppFloatingActionButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;

  const AppFloatingActionButton({
    required this.label,
    required this.onPressed,
    this.icon,
    super.key,
  });

  @override
  State<AppFloatingActionButton> createState() =>
      _AppFloatingActionButtonState();
}

class _AppFloatingActionButtonState extends State<AppFloatingActionButton>
    with SingleTickerProviderStateMixin {
  static const _appearDelay = Duration(milliseconds: 250);

  late final AnimationController _controller;
  late final Animation<double> _scale;
  Timer? _delayTimer;
  bool _started = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: AppMotion.medium);
    _scale = CurvedAnimation(parent: _controller, curve: AppMotion.spring);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_started) return;
    _started = true;

    if (AppMotion.reduced(context)) {
      _controller.value = 1;
    } else {
      _delayTimer = Timer(_appearDelay, () {
        if (mounted) _controller.forward();
      });
    }
  }

  @override
  void dispose() {
    _delayTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scale,
      child: FloatingActionButton(
        onPressed: widget.onPressed,
        tooltip: widget.label,
        child: Icon(widget.icon ?? Icons.add, size: 28),
      ),
    );
  }
}
