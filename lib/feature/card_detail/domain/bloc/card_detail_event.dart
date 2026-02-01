part of 'card_detail_bloc.dart';

/// События экрана карточки.
@freezed
sealed class CardDetailEvent with _$CardDetailEvent {
  const factory CardDetailEvent.started() = _CardDetailEvent$Started;
}
