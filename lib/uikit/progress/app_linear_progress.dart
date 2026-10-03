import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:material_3_expressive/material_3_expressive.dart'
    show M3EProgressIndicator, M3EProgressIndicatorSize;
import 'package:quizzerg/uikit/m3e/m3e_scope.dart';
import 'package:quizzerg/uikit/motion/app_motion.dart';

/// Линейный индикатор M3 Expressive: плоский трек со скруглёнными концами,
/// зазором и отдельной stop-точкой у края (по дизайну).
///
/// [isWavy] — «змейка»: активная часть волной, волна бежит постоянно.
/// Для процессов, которые идут прямо сейчас (синхронизация); статичный
/// прогресс — плоский.
///
/// [value] `null` — прогресс неизвестен: плоская полоса — бегущий сегмент
/// пакета, «змейка» — от левого края, длина плавно тянется вперёд-назад.
/// Сам виджет пакета
/// значение не анимирует, поэтому смена [value] плавно доезжает здесь;
/// первое значение ставится сразу.
///
/// Растягивается на всю доступную ширину — нужна ограниченная ширина.
class AppLinearProgress extends StatelessWidget {
  const AppLinearProgress({
    required this.color,
    required this.trackColor,
    this.value,
    this.isWavy = false,
    this.semanticsLabel,
    super.key,
  });

  /// Заполнение 0..1 либо `null`, если прогресс неизвестен.
  final double? value;
  final Color color;
  final Color trackColor;
  final bool isWavy;
  final String? semanticsLabel;

  @override
  Widget build(BuildContext context) {
    final target = value;
    if (target == null) {
      return isWavy
          ? _StartAnchoredWave(
              color: color,
              trackColor: trackColor,
              semanticsLabel: semanticsLabel,
            )
          : _Indicator(
              color: color,
              trackColor: trackColor,
              isWavy: false,
              semanticsLabel: semanticsLabel,
            );
    }

    return TweenAnimationBuilder<double>(
      tween: Tween(end: target.clamp(0, 1)),
      duration: AppMotion.reduced(context) ? Duration.zero : AppMotion.fast,
      curve: AppMotion.emphasized,
      builder: (_, current, __) => _Indicator(
        value: current,
        color: color,
        trackColor: trackColor,
        isWavy: isWavy,
        semanticsLabel: semanticsLabel,
      ),
    );
  }
}

/// Неопределённая «змейка» от старта. У пакета для неизвестного прогресса
/// есть только сегменты, бегущие по треку, — здесь начало всегда у левого
/// края, а длина плавно тянется вперёд-назад.
class _StartAnchoredWave extends StatefulWidget {
  const _StartAnchoredWave({
    required this.color,
    required this.trackColor,
    this.semanticsLabel,
  });

  final Color color;
  final Color trackColor;
  final String? semanticsLabel;

  @override
  State<_StartAnchoredWave> createState() => _StartAnchoredWaveState();
}

class _StartAnchoredWaveState extends State<_StartAnchoredWave>
    with SingleTickerProviderStateMixin {
  static const _minLength = 0.15;
  static const _maxLength = 0.85;

  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1600),
  )..repeat(reverse: true);

  late final Animation<double> _length = Tween<double>(
    begin: _minLength,
    end: _maxLength,
  ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Длина змейки — не прогресс: процент наружу не озвучиваем.
    return Semantics(
      label: widget.semanticsLabel,
      child: ExcludeSemantics(
        child: AnimatedBuilder(
          animation: _length,
          builder: (_, __) => _Indicator(
            value: _length.value,
            color: widget.color,
            trackColor: widget.trackColor,
            isWavy: true,
          ),
        ),
      ),
    );
  }
}

class _Indicator extends StatelessWidget {
  const _Indicator({
    required this.color,
    required this.trackColor,
    required this.isWavy,
    this.value,
    this.semanticsLabel,
  });

  final double? value;
  final Color color;
  final Color trackColor;
  final bool isWavy;
  final String? semanticsLabel;

  /// Амплитуда волны от прогресса. Тема пакета включает волну скачком на 10%
  /// и выключает на 95% — здесь она плавно нарастает в начале и гаснет к
  /// концу, чтобы полоса не «щёлкала» при догрузке.
  static double _waveAmplitude(double progress) =>
      math.min(progress / 0.1, (1 - progress) / 0.05).clamp(0.0, 1.0);

  @override
  Widget build(BuildContext context) {
    final progress = value;
    if (progress == null) {
      // Бегущий сегмент пакета: stop-точки в неопределённом режиме нет.
      return M3EScope(
        child: M3EProgressIndicator.linear(
          linearSize: M3EProgressIndicatorSize.s,
          color: color,
          trackColor: trackColor,
          semanticsLabel: semanticsLabel,
        ),
      );
    }

    return CustomPaint(
      painter: _TrackPainter(
        progress: progress,
        trackColor: trackColor,
        dotColor: color,
        // Волну рисует пакет, плоскую активную часть — мы.
        activeColor: isWavy ? null : color,
      ),
      child: isWavy
          ? M3EScope(
              child: M3EProgressIndicator.linearWavy(
                value: progress,
                linearSize: M3EProgressIndicatorSize.s,
                color: color,
                showTrack: false,
                stopSize: 0,
                amplitudeForProgress: _waveAmplitude,
                semanticsLabel: semanticsLabel,
              ),
            )
          : Semantics(
              label: semanticsLabel,
              value: '${(progress * 100).round()}%',
              child: const SizedBox(
                width: double.infinity,
                height: _TrackPainter.stroke,
              ),
            ),
    );
  }
}

/// Трек и stop-точка по дизайну: трек обрывается перед краем, точка стоит
/// отдельно у самого края и по толщине равна линии. Пакет рисует точку
/// внутри конца трека и сжимает её до 2 px на треке 4 px — поэтому свои.
///
/// Начало линии совпадает с геометрией `M3ELinearProgressPainter`
/// (центр круглого конца в [_inset] от края), чтобы трек вставал ровно
/// после волны пакета. При обновлении `material_3_expressive` сверить.
class _TrackPainter extends CustomPainter {
  /// Толщина линии — как у пакета в размере `s`.
  static const stroke = 4.0;
  static const _inset = 4.0;
  static const _trailing = 4.0;

  /// Видимый зазор между активной частью и треком.
  static const _gap = 6.0;
  static const _dotDiameter = 4.0;

  /// Видимый зазор между концом трека и точкой.
  static const _dotGap = 2.0;

  _TrackPainter({
    required this.progress,
    required this.trackColor,
    required this.dotColor,
    this.activeColor,
  });

  final double progress;
  final Color trackColor;
  final Color dotColor;

  /// `null` — активную часть рисует кто-то другой (волна пакета).
  final Color? activeColor;

  @override
  void paint(Canvas canvas, Size size) {
    final p = progress.clamp(0.0, 1.0);
    final cy = size.height / 2;
    final contentRight = size.width - _trailing;
    final activeEndX = _inset + (contentRight - _inset) * p;
    final linePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = stroke;

    final active = activeColor;
    if (active != null && activeEndX > _inset) {
      canvas.drawLine(
        Offset(_inset, cy),
        Offset(activeEndX, cy),
        linePaint..color = active,
      );
    }

    if (p >= 1) return;

    // Центры круглых концов: видимые края отстоят на stroke / 2. Пока
    // активной части нет, трек начинается от самого края, без зазора.
    final hasActive = activeEndX > _inset;
    final trackStartX = hasActive ? activeEndX + stroke + _gap : _inset;
    final trackEndX = size.width - _dotDiameter - _dotGap - stroke / 2;
    if (trackStartX < trackEndX) {
      canvas.drawLine(
        Offset(trackStartX, cy),
        Offset(trackEndX, cy),
        linePaint..color = trackColor,
      );
    }

    canvas.drawCircle(
      Offset(size.width - _dotDiameter / 2, cy),
      _dotDiameter / 2,
      Paint()..color = dotColor,
    );
  }

  @override
  bool shouldRepaint(_TrackPainter oldDelegate) =>
      oldDelegate.progress != progress ||
      oldDelegate.trackColor != trackColor ||
      oldDelegate.dotColor != dotColor ||
      oldDelegate.activeColor != activeColor;
}
