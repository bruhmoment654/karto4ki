import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quizzerg/feature/main/domain/entity/card_entity.dart';
import 'package:quizzerg/feature/main/domain/repository/i_main_repository.dart';

part 'main_event.dart';
part 'main_state.dart';
part 'main_bloc.freezed.dart';

/// Bloc for main screen.
final class MainBloc extends Bloc<MainEvent, MainState> {
  final IMainRepository _mainRepository;

  MainBloc(this._mainRepository) : super(const MainState.loading()) {
    on<MainEvent>(
      (event, emit) => switch (event) {
        MainEvent$LoadCards() => _onLoadCards(event, emit),
        MainEvent$AddCard() => _onAddCard(event, emit),
        MainEvent$UpdateCard() => _onUpdateCard(event, emit),
        MainEvent$DeleteCard() => _onDeleteCard(event, emit),
      },
    );
  }

  void _onLoadCards(
    MainEvent$LoadCards event,
    Emitter<MainState> emit,
  ) {
    final cards = _mainRepository.getCardList();
    emit(MainState.data(cards: cards));
  }

  void _onAddCard(
    MainEvent$AddCard event,
    Emitter<MainState> emit,
  ) {
    final currentState = state;
    if (currentState is! MainState$Data) return;

    final cards = [...currentState.cards, event.card];
    _mainRepository.updateCardList(cards);
    emit(currentState.copyWith(cards: cards));
  }

  void _onUpdateCard(
    MainEvent$UpdateCard event,
    Emitter<MainState> emit,
  ) {
    final currentState = state;
    if (currentState is! MainState$Data) return;

    final cards = currentState.cards.toList();
    final index = cards.indexWhere(
      (c) =>
          c.front == event.oldCard.front ||
          c.formattedBack == event.oldCard.formattedBack,
    );
    if (index == -1) return;

    cards[index] = event.newCard;
    _mainRepository.updateCardList(cards);
    emit(currentState.copyWith(cards: cards));
  }

  void _onDeleteCard(
    MainEvent$DeleteCard event,
    Emitter<MainState> emit,
  ) {
    final currentState = state;
    if (currentState is! MainState$Data) return;

    final cards = currentState.cards.where((c) => c != event.card).toList();
    _mainRepository.updateCardList(cards);
    emit(currentState.copyWith(cards: cards));
  }
}
