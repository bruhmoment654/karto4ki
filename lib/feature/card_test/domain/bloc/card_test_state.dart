part of 'card_test_bloc.dart';

/// Состояние экрана тестирования карточек.
@freezed
sealed class CardTestState with _$CardTestState {
  const CardTestState._();

  const factory CardTestState.initial() = CardTestState$Initial;

  const factory CardTestState.loading() = CardTestState$Loading;

  const factory CardTestState.data() = CardTestState$Data;

  const factory CardTestState.error({required Object? error}) =
      CardTestState$Error;
}
