import 'package:freezed_annotation/freezed_annotation.dart';

part 'card_entity.freezed.dart';

/// Card entity.
@freezed
sealed class CardEntity with _$CardEntity {
  const factory CardEntity({
    /// Unique card identifier.
    required String id,

    /// Test identifier that owns this card.
    required String testId,

    /// Question (front side of the card).
    required String front,

    /// Answer (back side of the card).
    required String back,

    /// Creation date.
    required DateTime createdAt,

    /// Update date.
    required DateTime updatedAt,
  }) = _CardEntity;
}
