import 'package:flutter_bloc/flutter_bloc.dart';

/// Неизменяемый источник состояния для golden-тестов View.
///
/// View работает с [StateStreamable], поэтому в тестах достаточно отдать
/// фиксированное состояние без настоящего BLoC.
class FakeStateStreamable<S> implements StateStreamable<S> {
  @override
  final S state;

  const FakeStateStreamable(this.state);

  @override
  Stream<S> get stream => const Stream.empty();
}
