// ignore_for_file: prefer-declaring-const-constructor

import 'package:flutter_bloc/flutter_bloc.dart';

/// Обёртка для уникального значения.
///
/// Используется для передачи уникального значения в [Bloc]. Чаще всего, чтобы
/// показывать несколько раз одно и то же событие.
final class SideEffectValue<T> {
  final T value;

  SideEffectValue(this.value);

  @override
  String toString() => 'SideEffect($value)';
}
