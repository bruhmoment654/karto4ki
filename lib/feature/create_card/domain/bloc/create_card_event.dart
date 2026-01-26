part of 'create_card_bloc.dart';

/// События экрана создания карточки.
@freezed
sealed class CreateCardEvent with _$CreateCardEvent {
  const factory CreateCardEvent.started() = _CreateCardEvent$Started;
}
