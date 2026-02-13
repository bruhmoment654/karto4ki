import 'package:flutter/material.dart';
import 'package:quizzerg/app/app.dart';
import 'package:quizzerg/app/di/app_scope.dart';
import 'package:quizzerg/core/shader/shader_handler.dart';
import 'package:provider/provider.dart';

class AppFlow extends StatelessWidget {
  final IAppScope appScope;
  final ShaderHandler shaderHandler;

  const AppFlow({
    required this.appScope,
    required this.shaderHandler,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderScope(
      handler: shaderHandler,
      child: Provider<IAppScope>(
        create: (context) => appScope,
        child: const App(),
      ),
    );
  }
}
