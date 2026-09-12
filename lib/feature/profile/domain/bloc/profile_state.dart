part of 'profile_bloc.dart';

/// Состояние экрана профиля.
@freezed
sealed class ProfileState with _$ProfileState {
  const ProfileState._();

  /// Сводка загружается.
  const factory ProfileState.loading() = ProfileState$Loading;

  /// Сводка загружена.
  const factory ProfileState.loaded({
    required ProfileSummaryEntity summary,
  }) = ProfileState$Loaded;

  /// Ошибка загрузки.
  const factory ProfileState.error({
    required Failure failure,
  }) = ProfileState$Error;
}
