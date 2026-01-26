part of 'main_bloc.dart';

/// Состояние главного экрана.
@freezed
sealed class MainState with _$MainState {
  const MainState._();

  const factory MainState.initial() = MainState$Initial;

  const factory MainState.loading() = MainState$Loading;

  const factory MainState.data() = MainState$Data;

  const factory MainState.error({required Object? error}) = MainState$Error;
}
