import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quizzerg/app/app_flow.dart';
import 'package:quizzerg/app/di/app_scope_register.dart';
import 'package:quizzerg/core/shader/shader_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final appScope = await AppScopeRegister().createScope();
  final shaderHandler = await ShaderHandler.load();

  runApp(AppFlow(appScope: appScope, shaderHandler: shaderHandler));
}
