// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'active_test_session_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActiveTestSessionDto _$ActiveTestSessionDtoFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'ActiveTestSessionDto',
      json,
      ($checkedConvert) {
        final val = ActiveTestSessionDto(
          testId: $checkedConvert('testId', (v) => v as String),
          testTitle: $checkedConvert('testTitle', (v) => v as String),
          currentIndex:
              $checkedConvert('currentIndex', (v) => (v as num).toInt()),
          startedAt:
              $checkedConvert('startedAt', (v) => DateTime.parse(v as String)),
          updatedAt:
              $checkedConvert('updatedAt', (v) => DateTime.parse(v as String)),
          cards: $checkedConvert(
              'cards',
              (v) => (v as List<dynamic>)
                  .map((e) =>
                      CardSnapshotDto.fromJson(e as Map<String, dynamic>))
                  .toList()),
          results: $checkedConvert(
              'results',
              (v) => (v as List<dynamic>)
                  .map((e) => CardResultDto.fromJson(e as Map<String, dynamic>))
                  .toList()),
          launchParams: $checkedConvert('launchParams',
              (v) => LaunchParamsDto.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Map<String, dynamic> _$ActiveTestSessionDtoToJson(
        ActiveTestSessionDto instance) =>
    <String, dynamic>{
      'testId': instance.testId,
      'testTitle': instance.testTitle,
      'currentIndex': instance.currentIndex,
      'startedAt': instance.startedAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'cards': instance.cards.map((e) => e.toJson()).toList(),
      'results': instance.results.map((e) => e.toJson()).toList(),
      'launchParams': instance.launchParams.toJson(),
    };
