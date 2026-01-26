part of 'main_bloc.dart';

/// События главного экрана.
@freezed
sealed class MainEvent with _$MainEvent {
  const factory MainEvent.started() = _MainEvent$Started;
}
