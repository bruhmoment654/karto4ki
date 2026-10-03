// Сигнатуры paint обязаны повторять порядок параметров базовых классов
// фреймворка, поэтому отключаем правило сортировки named-параметров.
// ignore_for_file: always_put_required_named_parameters_first
import 'package:flutter/material.dart';
import 'package:quizzerg/uikit/theme/app_theme.dart';

/// Слайдер оттенка (hue 0..360) для seed-цвета приложения: трек-радуга на
/// всю ширину и круглая ручка, залитая выбранным цветом. Ручка сама служит
/// превью цвета.
///
/// Градиент строится той же функцией, что и seed
/// ([AppTheme.seedColorFromHue]), поэтому цвет ручки совпадает с цветом
/// трека под ней.
class HueSlider extends StatelessWidget {
  static const _height = 36.0;
  static const _trackHeight = 16.0;

  /// Шаг опорных цветов градиента в градусах.
  static const _gradientStep = 30;

  static final _gradientColors = [
    for (var hue = 0; hue <= 360; hue += _gradientStep)
      AppTheme.seedColorFromHue(hue.toDouble()),
  ];

  /// Оттенок 0..360.
  final double hue;
  final ValueChanged<double>? onChanged;
  final ValueChanged<double>? onChangeEnd;
  final String? semanticLabel;

  const HueSlider({
    required this.hue,
    required this.onChanged,
    this.onChangeEnd,
    this.semanticLabel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        trackHeight: _trackHeight,
        // Трек на всю ширину, как в дизайне: ручка на краях выходит за него
        // наполовину.
        padding: EdgeInsets.zero,
        trackShape: _HueTrackShape(colors: _gradientColors),
        thumbShape: _HueThumbShape(
          color: AppTheme.seedColorFromHue(hue),
          // Обводка цветом подложки карточки отделяет ручку от трека.
          borderColor: cs.surfaceContainer,
        ),
        overlayShape: SliderComponentShape.noOverlay,
        tickMarkShape: SliderTickMarkShape.noTickMark,
        showValueIndicator: ShowValueIndicator.never,
      ),
      child: SizedBox(
        height: _height,
        child: Semantics(
          label: semanticLabel,
          child: Slider(
            value: hue.clamp(0, 360),
            max: 360,
            onChanged: onChanged,
            onChangeEnd: onChangeEnd,
          ),
        ),
      ),
    );
  }
}

class _HueTrackShape extends SliderTrackShape with BaseSliderTrackShape {
  final List<Color> colors;

  const _HueTrackShape({required this.colors});

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required TextDirection textDirection,
    required Offset thumbCenter,
    Offset? secondaryOffset,
    bool isDiscrete = false,
    bool isEnabled = false,
    double additionalActiveTrackHeight = 2,
  }) {
    final rect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );
    final paint = Paint()
      ..shader = LinearGradient(colors: colors).createShader(rect);

    context.canvas.drawRRect(
      RRect.fromRectAndRadius(rect, Radius.circular(rect.height / 2)),
      paint,
    );
  }
}

/// Круглая ручка: заливка выбранным цветом, обводка и мягкая тень.
/// При нажатии чуть увеличивается.
class _HueThumbShape extends SliderComponentShape {
  static const _diameter = 28.0;
  static const _borderWidth = 3.0;
  static const _pressedGrowth = 4.0;

  final Color color;
  final Color borderColor;

  const _HueThumbShape({required this.color, required this.borderColor});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) =>
      const Size.square(_diameter);

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final canvas = context.canvas;
    final radius = (_diameter + _pressedGrowth * activationAnimation.value) / 2;

    canvas
      ..drawCircle(
        center.translate(0, 1),
        radius,
        Paint()
          ..color = Colors.black.withValues(alpha: 0.4)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3),
      )
      ..drawCircle(center, radius, Paint()..color = borderColor)
      ..drawCircle(center, radius - _borderWidth, Paint()..color = color);
  }
}
