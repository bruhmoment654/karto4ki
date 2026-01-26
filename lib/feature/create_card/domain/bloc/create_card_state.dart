part of 'create_card_bloc.dart';

/// Состояние экрана создания карточки.
@freezed
sealed class CreateCardState with _$CreateCardState {
  const CreateCardState._();

  const factory CreateCardState.initial() = CreateCardState$Initial;

  const factory CreateCardState.loading() = CreateCardState$Loading;

  const factory CreateCardState.data() = CreateCardState$Data;

  const factory CreateCardState.error({required Object? error}) =
      CreateCardState$Error;
}
