import 'package:freezed_annotation/freezed_annotation.dart';

part 'card_entity.freezed.dart';

/// Card entity.
@freezed
sealed class CardEntity with _$CardEntity {
  const factory CardEntity({
    /// Question.
    required String front,

    /// Answer.
    required String back,
  }) = _CardEntity;
}
