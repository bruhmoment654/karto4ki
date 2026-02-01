// ignore_for_file: prefer-declaring-const-constructor

import 'package:flutter_bloc/flutter_bloc.dart';

/// Wrapper for unique value.
///
/// Used for passing unique value to [Bloc]. Most often to
/// display the same event multiple times.
final class SideEffectValue<T> {
  final T value;

  SideEffectValue(this.value);

  @override
  String toString() => 'SideEffect($value)';
}
