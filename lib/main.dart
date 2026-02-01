import 'package:flutter/material.dart';
import 'package:karto4ki/app/app_flow.dart';
import 'package:karto4ki/app/di/app_scope_register.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appScope = await AppScopeRegister().createScope();

  runApp(AppFlow(appScope: appScope));
}
