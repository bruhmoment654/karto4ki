import 'package:flutter/material.dart';

import 'package:quizzerg/uikit/theme/app_theme.dart';

class AppSlider extends StatelessWidget {
  final double value;
  final ValueChanged<double>? onChanged;
  final double min;
  final double max;
  final int? divisions;
  final String? label;

  const AppSlider({
    required this.value,
    required this.onChanged,
    this.min = 0.0,
    this.max = 1.0,
    this.divisions,
    this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
        trackHeight: 8,
        trackShape: const RoundedRectSliderTrackShape(),
        activeTrackColor: colorScheme.primary,
        inactiveTrackColor: colorScheme.muted,
        thumbColor: Colors.white,
        thumbShape: _ThumbShape(borderColor: colorScheme.primary),
      ),
      child: Slider(
        value: value,
        onChanged: onChanged,
        min: min,
        max: max,
        divisions: divisions,
        label: label,
      ),
    );
  }
}

class _ThumbShape extends RoundSliderThumbShape {
  final Color borderColor;

  const _ThumbShape({required this.borderColor})
      : super(enabledThumbRadius: 10);

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

    final shadowPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.15)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);
    canvas.drawCircle(center + const Offset(0, 1), 10, shadowPaint);

    final fillPaint = Paint()..color = Colors.white;
    canvas.drawCircle(center, 10, fillPaint);

    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawCircle(center, 10, borderPaint);
  }
}
