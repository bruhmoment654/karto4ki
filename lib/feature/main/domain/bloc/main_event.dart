part of 'main_bloc.dart';

/// Main screen events.
@freezed
sealed class MainEvent with _$MainEvent {
  const factory MainEvent.loadCards() = MainEvent$LoadCards;

  const factory MainEvent.addCard(CardEntity card) = MainEvent$AddCard;

  const factory MainEvent.updateCard({
    required CardEntity oldCard,
    required CardEntity newCard,
  }) = MainEvent$UpdateCard;

  const factory MainEvent.deleteCard(CardEntity card) = MainEvent$DeleteCard;
}
