import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karto4ki/feature/main/presentation/main_view.dart';

/// Билдер Bloc для [StateStreamable].
class StateStreamableBuilder<S> extends BlocBuilder<StateStreamable<S>, S> {
  const StateStreamableBuilder({
    required super.bloc,
    required super.builder,
    super.buildWhen,
    super.key, required MainView child,
  });
}
