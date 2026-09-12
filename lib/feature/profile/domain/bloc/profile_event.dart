part of 'profile_bloc.dart';

/// События экрана профиля.
@freezed
sealed class ProfileEvent with _$ProfileEvent {
  /// Загрузить сводку профиля.
  const factory ProfileEvent.started() = _ProfileEvent$Started;
}
