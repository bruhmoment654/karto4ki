part of 'card_detail_bloc.dart';

/// Card detail screen state.
@freezed
sealed class CardDetailState with _$CardDetailState {
  const CardDetailState._();

  const factory CardDetailState.initial() = CardDetailState$Initial;

  const factory CardDetailState.loading() = CardDetailState$Loading;

  const factory CardDetailState.data() = CardDetailState$Data;

  const factory CardDetailState.error({required Failure failure}) =
      CardDetailState$Error;
}
