import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'card_detail_event.dart';
part 'card_detail_state.dart';
part 'card_detail_bloc.freezed.dart';

/// Bloc for card detail screen.
///
/// Manages card viewing, creation and editing logic:
/// input data validation, card saving.
final class CardDetailBloc extends Bloc<CardDetailEvent, CardDetailState> {
  CardDetailBloc() : super(const CardDetailState.initial()) {
    on<CardDetailEvent>(
      (event, emit) => switch (event) {
        _CardDetailEvent$Started() => _onStarted(event, emit),
      },
    );
  }

  Future<void> _onStarted(
    _CardDetailEvent$Started event,
    Emitter<CardDetailState> emit,
  ) async {
    // TODO(karto4ki): Implement data loading.
  }
}
