// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answer_event_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnswerEventDto _$AnswerEventDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'AnswerEventDto',
      json,
      ($checkedConvert) {
        final val = AnswerEventDto(
          cardId: $checkedConvert('cardId', (v) => v as String),
          isCorrect: $checkedConvert('isCorrect', (v) => v as bool),
          answeredAt: $checkedConvert('answeredAt',
              (v) => const UtcDateTimeConverter().fromJson(v as String)),
        );
        return val;
      },
    );

Map<String, dynamic> _$AnswerEventDtoToJson(AnswerEventDto instance) =>
    <String, dynamic>{
      'cardId': instance.cardId,
      'isCorrect': instance.isCorrect,
      'answeredAt': const UtcDateTimeConverter().toJson(instance.answeredAt),
    };

Map<String, dynamic> _$BatchAnswerEventDtoToJson(
        BatchAnswerEventDto instance) =>
    <String, dynamic>{
      'events': instance.events.map((e) => e.toJson()).toList(),
    };

BatchAnswerResultDto _$BatchAnswerResultDtoFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'BatchAnswerResultDto',
      json,
      ($checkedConvert) {
        final val = BatchAnswerResultDto(
          applied: $checkedConvert('applied', (v) => (v as num).toInt()),
          notFound: $checkedConvert(
              'notFound',
              (v) =>
                  (v as List<dynamic>?)?.map((e) => e as String).toList() ??
                  const []),
          duplicates:
              $checkedConvert('duplicates', (v) => (v as num?)?.toInt() ?? 0),
        );
        return val;
      },
    );
