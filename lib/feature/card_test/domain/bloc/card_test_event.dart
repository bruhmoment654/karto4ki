part of 'card_test_bloc.dart';

/// Card testing screen events.
@freezed
sealed class CardTestEvent with _$CardTestEvent {
  const factory CardTestEvent.started() = _CardTestEvent$Started;
}
