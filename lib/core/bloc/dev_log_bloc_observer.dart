// ignore_for_file: strict_raw_type, avoid-nullable-interpolation

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surf_logger/surf_logger.dart';

class DevLogBlocObserver extends BlocObserver {
  final LogWriter logWriter;

  const DevLogBlocObserver(this.logWriter);

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    logWriter.log(
      '[BLOC] onCreate -- ${bloc.runtimeType}\n[BLOC] onCreate STATE -- ${bloc.state}',
    );
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    logWriter.log(
      '[BLOC] onEvent -- ${bloc.runtimeType}, $event \n[BLOC] onEvent STATE -- ${bloc.state}',
    );
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    logWriter.log('[BLOC] onChange -- ${bloc.runtimeType}, $change');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    logWriter.log('[BLOC] onTransition -- ${bloc.runtimeType}, $transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    logWriter.log(
      '[BLOC] onError -- ${bloc.runtimeType}, $error\n[BLOC] onError STATE -- ${bloc.state}',
    );
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    logWriter.log('[BLOC] onClose -- ${bloc.runtimeType}');
  }
}
