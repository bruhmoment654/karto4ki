part of 'main_bloc.dart';

/// Main screen state.
@freezed
sealed class MainState with _$MainState {
  const MainState._();

  const factory MainState.loading() = MainState$Loading;

  const factory MainState.data({
    required List<CardEntity> cards,
  }) = MainState$Data;
}
