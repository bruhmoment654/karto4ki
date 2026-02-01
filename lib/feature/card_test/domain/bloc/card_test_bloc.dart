import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:karto4ki/core/feature/core/failure.dart';

part 'card_test_event.dart';
part 'card_test_state.dart';
part 'card_test_bloc.freezed.dart';

/// Bloc for card testing screen.
///
/// Manages test execution logic: loading card set,
/// tracking current card and progress, saving results.
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
    // TODO(karto4ki): Implement data loading.
  }
}
