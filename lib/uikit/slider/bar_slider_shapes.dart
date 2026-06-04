// Сигнатуры paint обязаны повторять порядок параметров базовых классов
// фреймворка, поэтому отключаем правило сортировки named-параметров.
// ignore_for_file: always_put_required_named_parameters_first
import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Ручка-«пилюля» M3 Expressive: тонкая вертикальная полоса вместо круга.
///
/// Используется и в [Slider] (через `thumbShape`), и в `RangeSlider`
/// (через `rangeThumbShape`) — см. [BarRangeSliderThumbShape].
class BarSliderThumbShape extends SliderComponentShape {
  final double width;
  final double height;

  const BarSliderThumbShape({this.width = 4, this.height = 44});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) =>
      Size(width, height);

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
    final color = sliderTheme.thumbColor ??
        sliderTheme.activeTrackColor ??
        Colors.black;
    _paintBar(context.canvas, center, width, height, color);
  }
}

/// Та же ручка-полоса для `RangeSlider`.
class BarRangeSliderThumbShape extends RangeSliderThumbShape {
  final double width;
  final double height;

  const BarRangeSliderThumbShape({this.width = 4, this.height = 44});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) =>
      Size(width, height);

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    bool isDiscrete = false,
    bool isEnabled = false,
    bool isOnTop = false,
    SliderThemeData? sliderTheme,
    TextDirection? textDirection,
    Thumb? thumb,
    bool isPressed = false,
  }) {
    final color = sliderTheme?.thumbColor ??
        sliderTheme?.activeTrackColor ??
        Colors.black;
    _paintBar(context.canvas, center, width, height, color);
  }
}

void _paintBar(
  Canvas canvas,
  Offset center,
  double width,
  double height,
  Color color,
) {
  final rect = Rect.fromCenter(center: center, width: width, height: height);
  final rrect = RRect.fromRectAndRadius(rect, Radius.circular(width / 2));
  canvas.drawRRect(rrect, Paint()..color = color);
}

/// Трек одиночного [Slider] с «вырезом» под ручку: активный сегмент от старта
/// до ручки (с отступом [gap]), затем после отступа — неактивный сегмент.
/// Все сегменты со скруглёнными концами — эффект выреза трека thumb-ом.
class CutoutSliderTrackShape extends SliderTrackShape with BaseSliderTrackShape {
  final double gap;

  const CutoutSliderTrackShape({this.gap = 14});

  @override
  bool get isRounded => true;

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required Offset thumbCenter,
    Offset? secondaryOffset,
    bool isEnabled = false,
    bool isDiscrete = false,
    required TextDirection textDirection,
  }) {
    if (sliderTheme.trackHeight == null || sliderTheme.trackHeight! <= 0) {
      return;
    }
    final track = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );
    final active = sliderTheme.activeTrackColor ?? const Color(0xFF000000);
    final inactive = sliderTheme.inactiveTrackColor ?? const Color(0xFF000000);
    final canvas = context.canvas;
    final x = thumbCenter.dx;

    if (textDirection == TextDirection.ltr) {
      _drawSegment(canvas, track, track.left, x - gap, active);
      _drawSegment(canvas, track, x + gap, track.right, inactive);
    } else {
      _drawSegment(canvas, track, x + gap, track.right, active);
      _drawSegment(canvas, track, track.left, x - gap, inactive);
    }
  }
}

/// Трек `RangeSlider` с «вырезами» вокруг обеих ручек: неактивный — активный
/// (между ручками) — неактивный, с отступом [gap] и скруглёнными концами.
class CutoutRangeSliderTrackShape extends RangeSliderTrackShape
    with BaseRangeSliderTrackShape {
  final double gap;

  const CutoutRangeSliderTrackShape({this.gap = 14});

  @override
  bool get isRounded => true;

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required Offset startThumbCenter,
    required Offset endThumbCenter,
    bool isEnabled = false,
    bool isDiscrete = false,
    required TextDirection textDirection,
    double additionalActiveTrackHeight = 2,
  }) {
    if (sliderTheme.trackHeight == null || sliderTheme.trackHeight! <= 0) {
      return;
    }
    final track = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );
    final active = sliderTheme.activeTrackColor ?? const Color(0xFF000000);
    final inactive = sliderTheme.inactiveTrackColor ?? const Color(0xFF000000);
    final canvas = context.canvas;
    final leftX = math.min(startThumbCenter.dx, endThumbCenter.dx);
    final rightX = math.max(startThumbCenter.dx, endThumbCenter.dx);

    _drawSegment(canvas, track, track.left, leftX - gap, inactive);
    _drawSegment(canvas, track, leftX + gap, rightX - gap, active);
    _drawSegment(canvas, track, rightX + gap, track.right, inactive);
  }
}

/// Рисует сегмент-«пилюлю» между [left] и [right] (с зажимом в границы трека).
void _drawSegment(
  Canvas canvas,
  Rect track,
  double left,
  double right,
  Color color,
) {
  final l = left.clamp(track.left, track.right);
  final r = right.clamp(track.left, track.right);
  if (r - l <= 0) return;
  final rect = Rect.fromLTRB(l, track.top, r, track.bottom);
  canvas.drawRRect(
    RRect.fromRectAndRadius(rect, Radius.circular(track.height / 2)),
    Paint()..color = color,
  );
}
