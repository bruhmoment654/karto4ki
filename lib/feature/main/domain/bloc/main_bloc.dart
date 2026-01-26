import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'main_event.dart';
part 'main_state.dart';
part 'main_bloc.freezed.dart';

/// Bloc для главного экрана.
///
/// TODO: Уточнить бизнес-логику главного экрана.
final class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(const MainState.initial()) {
    on<MainEvent>(
      (event, emit) => switch (event) {
        _MainEvent$Started() => _onStarted(event, emit),
      },
    );
  }

  Future<void> _onStarted(
    _MainEvent$Started event,
    Emitter<MainState> emit,
  ) async {
    // TODO: Реализовать загрузку данных
  }
}
