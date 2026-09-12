// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_stats_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionStatsDto _$QuestionStatsDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('QuestionStatsDto', json, ($checkedConvert) {
      final val = QuestionStatsDto(
        id: $checkedConvert('id', (v) => v as String),
        questionKey: $checkedConvert('questionKey', (v) => v as String),
        frontText: $checkedConvert('frontText', (v) => v as String),
        backText: $checkedConvert('backText', (v) => v as String),
        streak: $checkedConvert('streak', (v) => (v as num).toInt()),
        totalCorrect: $checkedConvert(
          'totalCorrect',
          (v) => (v as num).toInt(),
        ),
        totalIncorrect: $checkedConvert(
          'totalIncorrect',
          (v) => (v as num).toInt(),
        ),
        totalShown: $checkedConvert('totalShown', (v) => (v as num).toInt()),
        createdAt: $checkedConvert(
          'createdAt',
          (v) => const UtcDateTimeConverter().fromJson(v as String),
        ),
        updatedAt: $checkedConvert(
          'updatedAt',
          (v) => const UtcDateTimeConverter().fromJson(v as String),
        ),
        lastAnsweredAt: $checkedConvert(
          'lastAnsweredAt',
          (v) => const NullableUtcDateTimeConverter().fromJson(v as String?),
        ),
        lastShownAt: $checkedConvert(
          'lastShownAt',
          (v) => const NullableUtcDateTimeConverter().fromJson(v as String?),
        ),
      );
      return val;
    });

Map<String, dynamic> _$QuestionStatsDtoToJson(QuestionStatsDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'questionKey': instance.questionKey,
      'frontText': instance.frontText,
      'backText': instance.backText,
      'streak': instance.streak,
      'totalCorrect': instance.totalCorrect,
      'totalIncorrect': instance.totalIncorrect,
      'totalShown': instance.totalShown,
      'lastAnsweredAt': const NullableUtcDateTimeConverter().toJson(
        instance.lastAnsweredAt,
      ),
      'lastShownAt': const NullableUtcDateTimeConverter().toJson(
        instance.lastShownAt,
      ),
      'createdAt': const UtcDateTimeConverter().toJson(instance.createdAt),
      'updatedAt': const UtcDateTimeConverter().toJson(instance.updatedAt),
    };
