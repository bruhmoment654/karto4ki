import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quizzerg/uikit/motion/app_motion.dart';

/// Крупный expressive FAB (64dp, r28, primaryContainer/onPrimaryContainer).
///
/// Параметры размера/формы/цвета берутся из `floatingActionButtonTheme`.
/// [label] используется как tooltip (иконочный FAB по дизайну M3).
///
/// При появлении «выскакивает» с пружиной ([AppMotion.spring]) после небольшой
/// задержки — но только если FAB на экране ещё не было. Если экран открыт
/// поверх другого с FAB, кнопка сразу на месте: общий hero переносит её между
/// экранами, и для пользователя она не пропадает.
///
/// [isVisible] прячет и показывает кнопку анимацией масштаба.
/// reduced-motion ([AppMotion.reduced]): без анимаций.
class AppFloatingActionButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isVisible;

  const AppFloatingActionButton({
    required this.label,
    required this.onPressed,
    this.icon,
    this.isVisible = true,
    super.key,
  });

  @override
  State<AppFloatingActionButton> createState() =>
      _AppFloatingActionButtonState();
}

class _AppFloatingActionButtonState extends State<AppFloatingActionButton>
    with SingleTickerProviderStateMixin {
  static const _appearDelay = Duration(milliseconds: 250);

  /// Сколько FAB смонтировано сейчас. Экран под открываемым остаётся в
  /// дереве, поэтому ненулевой счётчик значит «FAB уже был на экране».
  static int _mountedCount = 0;

  late final AnimationController _controller;
  late final Animation<double> _scale;
  late final bool _isAlreadyShown;
  Timer? _delayTimer;
  bool _isStarted = false;

  @override
  void initState() {
    super.initState();
    _isAlreadyShown = _mountedCount > 0;
    _mountedCount++;
    _controller = AnimationController(
      vsync: this,
      duration: AppMotion.medium,
      reverseDuration: AppMotion.fast,
    );
    _scale = CurvedAnimation(
      parent: _controller,
      curve: AppMotion.spring,
      reverseCurve: Curves.easeInCubic,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isStarted) return;
    _isStarted = true;

    if (!widget.isVisible) return;
    if (_isAlreadyShown || AppMotion.reduced(context)) {
      _controller.value = 1;
    } else {
      _delayTimer = Timer(_appearDelay, () {
        if (mounted && widget.isVisible) _controller.forward();
      });
    }
  }

  @override
  void didUpdateWidget(AppFloatingActionButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isVisible == widget.isVisible) return;

    _delayTimer?.cancel();
    if (AppMotion.reduced(context)) {
      _controller.value = widget.isVisible ? 1 : 0;
    } else if (widget.isVisible) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _mountedCount--;
    _delayTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !widget.isVisible,
      child: ExcludeSemantics(
        excluding: !widget.isVisible,
        child: ScaleTransition(
          scale: _scale,
          child: FloatingActionButton(
            onPressed: widget.onPressed,
            tooltip: widget.label,
            child: Icon(widget.icon ?? Icons.add, size: 28),
          ),
        ),
      ),
    );
  }
}
