import 'dart:ui';

import 'package:flutter/widgets.dart';

class ShaderHandler {
  final FragmentProgram? _program;

  ShaderHandler._(this._program);

  static Future<ShaderHandler> load() async {
    final program = await FragmentProgram.fromAsset(
      'assets/shaders/background.frag',
    );

    return ShaderHandler._(program);
  }

  @visibleForTesting
  ShaderHandler.forTesting() : _program = null;

  bool get isAvailable => _program != null;

  FragmentShader shader() => _program!.fragmentShader();
}

class ShaderScope extends InheritedWidget {
  final ShaderHandler handler;

  const ShaderScope({
    required this.handler,
    required super.child,
    super.key,
  });

  static ShaderHandler of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<ShaderScope>();
    assert(scope != null, 'ShaderScope is not found in context');

    return scope!.handler;
  }

  @override
  bool updateShouldNotify(ShaderScope oldWidget) =>
      handler != oldWidget.handler;
}

extension ShaderScopeX on BuildContext {
  ShaderHandler get shaderHandler => ShaderScope.of(this);
}
