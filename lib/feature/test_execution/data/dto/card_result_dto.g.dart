// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_result_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardResultDto _$CardResultDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'CardResultDto',
      json,
      ($checkedConvert) {
        final val = CardResultDto(
          cardId: $checkedConvert('cardId', (v) => v as String),
          isCorrect: $checkedConvert('isCorrect', (v) => v as bool),
          answeredAt:
              $checkedConvert('answeredAt', (v) => DateTime.parse(v as String)),
        );
        return val;
      },
    );

Map<String, dynamic> _$CardResultDtoToJson(CardResultDto instance) =>
    <String, dynamic>{
      'cardId': instance.cardId,
      'isCorrect': instance.isCorrect,
      'answeredAt': instance.answeredAt.toIso8601String(),
    };
