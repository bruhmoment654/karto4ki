part of 'card_test_bloc.dart';

/// События экрана тестирования карточек.
@freezed
sealed class CardTestEvent with _$CardTestEvent {
  const factory CardTestEvent.started() = _CardTestEvent$Started;
}
