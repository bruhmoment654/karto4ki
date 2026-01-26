import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_card_event.dart';
part 'create_card_state.dart';
part 'create_card_bloc.freezed.dart';

/// Bloc для экрана создания карточки.
///
/// Управляет логикой создания новой карточки: валидация введённых данных,
/// сохранение карточки в выбранный набор.
final class CreateCardBloc extends Bloc<CreateCardEvent, CreateCardState> {
  CreateCardBloc() : super(const CreateCardState.initial()) {
    on<CreateCardEvent>(
      (event, emit) => switch (event) {
        _CreateCardEvent$Started() => _onStarted(event, emit),
      },
    );
  }

  Future<void> _onStarted(
    _CreateCardEvent$Started event,
    Emitter<CreateCardState> emit,
  ) async {
    // TODO: Реализовать загрузку данных
  }
}
