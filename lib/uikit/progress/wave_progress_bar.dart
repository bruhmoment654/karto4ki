import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:quizzerg/uikit/motion/app_motion.dart';
import 'package:quizzerg/uikit/progress/wave_fill_painter.dart';

/// Полоска рабочего прогресса в том же дизайне, что и `WaveFillBar`:
/// скруглённый трек и колышущийся синусоидой фронт заливки.
///
/// В отличие от `WaveFillBar` рассчитана на часто меняющееся значение —
/// заливка плавно едет от текущего значения к новому, а не перезапускается
/// с нуля. Блика нет: он уместен как награда за результат, а на рабочем
/// прогрессе только шумит.
///
/// [value] `null` — прогресс неизвестен: по треку бежит залитый сегмент.
///
/// reduced-motion ([AppMotion.reduced]): фронт плоский и значение ставится
/// сразу, а при неизвестном прогрессе показывается обычный
/// [LinearProgressIndicator] — застывшая полоска врала бы, что работа встала.
class WaveProgressBar extends StatefulWidget {
  const WaveProgressBar({
    required this.color,
    required this.backgroundColor,
    this.value,
    this.minHeight = 6,
    super.key,
  });

  /// Заполнение 0..1 либо `null`, если прогресс неизвестен.
  final double? value;
  final Color color;
  final Color backgroundColor;
  final double minHeight;

  @override
  State<WaveProgressBar> createState() => _WaveProgressBarState();
}

class _WaveProgressBarState extends State<WaveProgressBar>
    with TickerProviderStateMixin {
  late final AnimationController _fill;
  late final AnimationController _drift;
  late final AnimationController _indeterminate;
  late final Tween<double> _tween;
  late final Animation<double> _fillAnimation;
  bool _started = false;

  /// Амплитуда колыхания фронта в логических пикселях.
  static const _waveAmplitude = 1.2;

  /// Доля трека под бегущим сегментом при неизвестном прогрессе.
  static const _segmentWidth = 0.3;

  @override
  void initState() {
    super.initState();
    final initial = widget.value ?? 0;
    _fill = AnimationController(vsync: this, duration: AppMotion.fast);
    _drift = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2600),
    );
    _indeterminate = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );
    _tween = Tween<double>(begin: initial, end: initial);
    _fillAnimation = _tween.animate(
      CurvedAnimation(parent: _fill, curve: AppMotion.emphasized),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_started) return;
    _started = true;
    _syncRepeatingAnimations();
  }

  @override
  void didUpdateWidget(WaveProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) _animateTo(widget.value);
    _syncRepeatingAnimations();
  }

  @override
  void dispose() {
    _fill.dispose();
    _drift.dispose();
    _indeterminate.dispose();
    super.dispose();
  }

  /// Колыхание фронта и бег сегмента крутятся только когда нужны: лишний
  /// тикер на экране с прогрессом синка работал бы всё время его показа.
  void _syncRepeatingAnimations() {
    final isReduced = AppMotion.reduced(context);
    _toggle(_drift, isActive: !isReduced);
    _toggle(_indeterminate, isActive: !isReduced && widget.value == null);
  }

  void _toggle(AnimationController controller, {required bool isActive}) {
    if (isActive && !controller.isAnimating) {
      controller.repeat();
    } else if (!isActive && controller.isAnimating) {
      controller.stop();
    }
  }

  /// Плавный переезд от текущего показанного значения к новому.
  void _animateTo(double? target) {
    final value = target ?? 0;
    if (AppMotion.reduced(context)) {
      _tween
        ..begin = value
        ..end = value;
      _fill.value = 1;

      return;
    }

    _tween
      ..begin = _fillAnimation.value
      ..end = value;
    _fill.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    final isReduced = AppMotion.reduced(context);
    if (isReduced && widget.value == null) {
      return LinearProgressIndicator(
        minHeight: widget.minHeight,
        backgroundColor: widget.backgroundColor,
        valueColor: AlwaysStoppedAnimation<Color>(widget.color),
      );
    }

    // Как у LinearProgressIndicator: при свободных констрейнтах полоска
    // занимает всю доступную ширину, иначе в Column она схлопнулась бы в ноль.
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(height: widget.minHeight)
          .copyWith(minWidth: double.infinity),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(99),
        child: AnimatedBuilder(
          animation: Listenable.merge([_fillAnimation, _drift, _indeterminate]),
          builder: (context, _) {
            final span = widget.value == null
                ? _runningSpan()
                : (start: 0.0, end: _fillAnimation.value.clamp(0.0, 1.0));

            return CustomPaint(
              painter: WaveFillPainter(
                start: span.start,
                end: span.end,
                phase: _drift.value * 2 * math.pi,
                amplitude: isReduced ? 0 : _waveAmplitude,
                color: widget.color,
                background: widget.backgroundColor,
              ),
            );
          },
        ),
      ),
    );
  }

  /// Границы бегущего сегмента: въезжает слева и уезжает за правый край.
  ({double start, double end}) _runningSpan() {
    final head = _indeterminate.value * (1 + _segmentWidth);

    return (
      start: (head - _segmentWidth).clamp(0.0, 1.0),
      end: head.clamp(0.0, 1.0),
    );
  }
}
