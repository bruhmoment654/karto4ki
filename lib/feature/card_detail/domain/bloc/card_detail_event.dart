part of 'card_detail_bloc.dart';

/// Card detail screen events.
@freezed
sealed class CardDetailEvent with _$CardDetailEvent {
  const factory CardDetailEvent.started() = _CardDetailEvent$Started;
}
