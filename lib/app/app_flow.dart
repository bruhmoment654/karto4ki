import 'package:flutter/material.dart';
import 'package:karto4ki/app/app.dart';
import 'package:karto4ki/app/di/app_scope.dart';
import 'package:provider/provider.dart';

class AppFlow extends StatelessWidget {
  final IAppScope appScope;

  const AppFlow({
    required this.appScope,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Provider<IAppScope>(
      create: (context) => appScope,
      child: const App(),
    );
  }
}
