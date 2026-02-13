import 'package:flutter/material.dart';
import 'package:quizzerg/core/shader/shader_handler.dart';

class ShaderBackground extends StatefulWidget {
  const ShaderBackground({super.key});

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
    )..repeat();
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
        ),
        child: const SizedBox.expand(),
      ),
    );
  }
}

class _ShaderBackgroundPainter extends CustomPainter {
  final ShaderHandler handler;
  final Animation<double> animation;

  _ShaderBackgroundPainter({
    required this.handler,
    required this.animation,
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final shader = handler.shader()
      ..setFloat(0, size.width)
      ..setFloat(1, size.height)
      ..setFloat(2, animation.value);

    canvas.drawRect(
      Offset.zero & size,
      Paint()..shader = shader,
    );
  }

  @override
  bool shouldRepaint(_ShaderBackgroundPainter oldDelegate) => false;
}
