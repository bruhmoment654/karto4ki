import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'card_test_event.dart';
part 'card_test_state.dart';
part 'card_test_bloc.freezed.dart';

/// Bloc для экрана тестирования карточек.
///
/// Управляет логикой прохождения теста: загрузка набора карточек,
/// отслеживание текущей карточки и прогресса, сохранение результатов.
final class CardTestBloc extends Bloc<CardTestEvent, CardTestState> {
  CardTestBloc() : super(const CardTestState.initial()) {
    on<CardTestEvent>(
      (event, emit) => switch (event) {
        _CardTestEvent$Started() => _onStarted(event, emit),
      },
    );
  }

  Future<void> _onStarted(
    _CardTestEvent$Started event,
    Emitter<CardTestState> emit,
  ) async {
    // TODO(karto4ki): Реализовать загрузку данных.
  }
}
