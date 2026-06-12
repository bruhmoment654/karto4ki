// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stats_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$AnswerEventDtoToJson(AnswerEventDto instance) =>
    <String, dynamic>{
      'cardId': instance.cardId,
      'isCorrect': instance.isCorrect,
      'answeredAt': instance.answeredAt,
    };

Map<String, dynamic> _$BatchAnswerEventsDtoToJson(
        BatchAnswerEventsDto instance) =>
    <String, dynamic>{
      'events': instance.events,
    };

BatchAnswerResultDto _$BatchAnswerResultDtoFromJson(
        Map<String, dynamic> json) =>
    BatchAnswerResultDto(
      applied: (json['applied'] as num).toInt(),
      notFound:
          (json['notFound'] as List<dynamic>).map((e) => e as String).toList(),
    );
