import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:quizzerg/uikit/motion/app_motion.dart';
import 'package:quizzerg/uikit/progress/wave_fill_painter.dart';

/// Прогресс-полоска с entrance-анимацией: заполняется 0→[value], по залитой
/// части дважды пробегает светлый блик, а её незаполненный фронт колышется
/// синусоидой (как поверхность воды в итогах теста).
///
/// reduced-motion ([AppMotion.reduced]): полоска сразу на финальном значении,
/// без блика и без колыхания фронта.
class WaveFillBar extends StatefulWidget {
  const WaveFillBar({
    required this.value,
    required this.color,
    required this.backgroundColor,
    this.minHeight = 6,
    super.key,
  });

  /// Целевое заполнение 0..1.
  final double value;
  final Color color;
  final Color backgroundColor;
  final double minHeight;

  @override
  State<WaveFillBar> createState() => _WaveFillBarState();
}

class _WaveFillBarState extends State<WaveFillBar>
    with TickerProviderStateMixin {
  late final AnimationController _fill;
  late final AnimationController _shimmer;
  late final AnimationController _drift;
  late Animation<double> _fillAnimation;
  bool _started = false;
  bool _shimmerActive = false;
  int _shimmerCycles = 0;

  static const _maxShimmerCycles = 2;

  /// Амплитуда колыхания фронта в логических пикселях.
  static const _waveAmplitude = 1.2;

  @override
  void initState() {
    super.initState();
    _fill = AnimationController(vsync: this, duration: AppMotion.fill);
    _shimmer = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _drift = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2600),
    );
    _fillAnimation = _buildFillAnimation();

    _fill.addStatusListener((status) {
      if (status == AnimationStatus.completed && widget.value > 0) {
        _startShimmer();
      }
    });
    _shimmer.addStatusListener((status) {
      if (status != AnimationStatus.completed) return;
      _shimmerCycles++;
      if (_shimmerCycles < _maxShimmerCycles) {
        _shimmer.forward(from: 0);
      } else {
        setState(() => _shimmerActive = false);
      }
    });
  }

  Animation<double> _buildFillAnimation() => Tween<double>(
        begin: 0,
        end: widget.value,
      ).animate(CurvedAnimation(parent: _fill, curve: AppMotion.emphasized));

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_started) return;
    _started = true;

    if (AppMotion.reduced(context)) {
      _fill.value = 1;
    } else {
      _fill.forward();
      _drift.repeat();
    }
  }

  @override
  void didUpdateWidget(WaveFillBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _fillAnimation = _buildFillAnimation();
      if (!AppMotion.reduced(context)) _fill.forward(from: 0);
    }
  }

  void _startShimmer() {
    _shimmerCycles = 0;
    setState(() => _shimmerActive = true);
    _shimmer.forward(from: 0);
  }

  @override
  void dispose() {
    _fill.dispose();
    _shimmer.dispose();
    _drift.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final amplitude = AppMotion.reduced(context) ? 0.0 : _waveAmplitude;

    return SizedBox(
      height: widget.minHeight,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(99),
        child: AnimatedBuilder(
          animation: Listenable.merge([_fillAnimation, _shimmer, _drift]),
          builder: (context, _) {
            final fillFactor = _fillAnimation.value.clamp(0.0, 1.0);

            return Stack(
              children: [
                // Трек + залитая часть с колышущимся фронтом.
                Positioned.fill(
                  child: CustomPaint(
                    painter: WaveFillPainter(
                      end: fillFactor,
                      phase: _drift.value * 2 * math.pi,
                      amplitude: amplitude,
                      color: widget.color,
                      background: widget.backgroundColor,
                    ),
                  ),
                ),
                // Бегущий по залитой части блик.
                if (_shimmerActive)
                  Positioned.fill(
                    child: FractionallySizedBox(
                      widthFactor: fillFactor,
                      alignment: Alignment.centerLeft,
                      child: IgnorePointer(
                        child: _ShimmerBand(progress: _shimmer.value),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

/// Светлая полоса-блик, пробегающая слева направо по залитой части.
class _ShimmerBand extends StatelessWidget {
  const _ShimmerBand({required this.progress});

  /// Позиция блика 0..1.
  final double progress;

  @override
  Widget build(BuildContext context) {
    final dx = -1 + 2 * progress;

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(dx - 0.5, 0),
          end: Alignment(dx + 0.5, 0),
          colors: const [
            Colors.transparent,
            Colors.white24,
            Colors.transparent,
          ],
        ),
      ),
    );
  }
}
