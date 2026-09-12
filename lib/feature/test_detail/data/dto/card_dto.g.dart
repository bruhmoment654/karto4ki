// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardDto _$CardDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('CardDto', json, ($checkedConvert) {
      final val = CardDto(
        id: $checkedConvert('id', (v) => v as String),
        testId: $checkedConvert('testId', (v) => v as String),
        front: $checkedConvert('front', (v) => v as String),
        answers: $checkedConvert(
          'answers',
          (v) => (v as List<dynamic>).map((e) => e as String).toList(),
        ),
        createdAt: $checkedConvert(
          'createdAt',
          (v) => const UtcDateTimeConverter().fromJson(v as String),
        ),
        updatedAt: $checkedConvert(
          'updatedAt',
          (v) => const UtcDateTimeConverter().fromJson(v as String),
        ),
        questionKey: $checkedConvert('questionKey', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$CardDtoToJson(CardDto instance) => <String, dynamic>{
  'id': instance.id,
  'testId': instance.testId,
  'front': instance.front,
  'answers': instance.answers,
  'questionKey': instance.questionKey,
  'createdAt': const UtcDateTimeConverter().toJson(instance.createdAt),
  'updatedAt': const UtcDateTimeConverter().toJson(instance.updatedAt),
};

Map<String, dynamic> _$CreateCardDtoToJson(CreateCardDto instance) =>
    <String, dynamic>{
      'testId': instance.testId,
      'front': instance.front,
      'answers': instance.answers,
    };

Map<String, dynamic> _$BatchCardItemDtoToJson(BatchCardItemDto instance) =>
    <String, dynamic>{'front': instance.front, 'answers': instance.answers};

Map<String, dynamic> _$BatchCreateCardsDtoToJson(
  BatchCreateCardsDto instance,
) => <String, dynamic>{
  'testId': instance.testId,
  'cards': instance.cards.map((e) => e.toJson()).toList(),
};

BatchCreateCardsResultDto _$BatchCreateCardsResultDtoFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('BatchCreateCardsResultDto', json, ($checkedConvert) {
  final val = BatchCreateCardsResultDto(
    created: $checkedConvert('created', (v) => (v as num).toInt()),
    skipped: $checkedConvert('skipped', (v) => (v as num).toInt()),
    ids: $checkedConvert(
      'ids',
      (v) =>
          (v as List<dynamic>?)?.map((e) => e as String).toList() ?? const [],
    ),
  );
  return val;
});
