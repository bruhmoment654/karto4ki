import 'package:freezed_annotation/freezed_annotation.dart';

part 'card_entity.freezed.dart';

/// Сущность карточки.
@freezed
sealed class CardEntity with _$CardEntity {
  const factory CardEntity({
    /// Вопрос.
    required String front,

    /// Ответ.
    required String back,
  }) = _CardEntity;
}
