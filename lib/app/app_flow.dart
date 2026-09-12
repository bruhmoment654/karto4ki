import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:quizzerg/app/app.dart';
import 'package:quizzerg/app/di/app_scope.dart';
import 'package:quizzerg/core/shader/shader_handler.dart';

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
        // Блоки глобальные и живут ровно один раз — их читают и главная,
        // и профиль, и экран входа, и тема приложения.
        child: MultiBlocProvider(
          providers: [
            BlocProvider.value(value: appScope.authBloc),
            BlocProvider.value(value: appScope.syncBloc),
            BlocProvider.value(value: appScope.settingsBloc),
          ],
          child: const App(),
        ),
      ),
    );
  }
}
