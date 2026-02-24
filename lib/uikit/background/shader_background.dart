import 'package:flutter/material.dart';
import 'package:quizzerg/core/shader/shader_handler.dart';
import 'package:quizzerg/uikit/theme/app_theme.dart';

class ShaderBackground extends StatefulWidget {
  final bool animationEnabled;
  final Color accentColor;

  const ShaderBackground({
    this.animationEnabled = true,
    this.accentColor = AppTheme.defaultSeedColor,
    super.key,
  });

  @override
  State<ShaderBackground> createState() => _ShaderBackgroundState();
}

class _ShaderBackgroundState extends State<ShaderBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    );
    if (widget.animationEnabled) {
      _controller.repeat();
    } else {
      _controller.value = 0.35;
    }
  }

  @override
  void didUpdateWidget(ShaderBackground oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animationEnabled != oldWidget.animationEnabled) {
      if (widget.animationEnabled) {
        _controller.repeat();
      } else {
        _controller
          ..stop()
          ..value = 0.35;
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final handler = context.shaderHandler;

    return RepaintBoundary(
      child: CustomPaint(
        painter: _ShaderBackgroundPainter(
          handler: handler,
          animation: _controller,
          accentColor: widget.accentColor,
        ),
        child: const SizedBox.expand(),
      ),
    );
  }
}

class _ShaderBackgroundPainter extends CustomPainter {
  final ShaderHandler handler;
  final Animation<double> animation;
  final Color accentColor;

  _ShaderBackgroundPainter({
    required this.handler,
    required this.animation,
    required this.accentColor,
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final shader = handler.shader()
      ..setFloat(0, size.width)
      ..setFloat(1, size.height)
      ..setFloat(2, animation.value)
      ..setFloat(3, accentColor.r)
      ..setFloat(4, accentColor.g)
      ..setFloat(5, accentColor.b);

    canvas.drawRect(
      Offset.zero & size,
      Paint()..shader = shader,
    );
  }

  @override
  bool shouldRepaint(_ShaderBackgroundPainter oldDelegate) =>
      accentColor != oldDelegate.accentColor;
}
