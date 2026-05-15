import 'package:json_annotation/json_annotation.dart';

part 'card_snapshot_dto.g.dart';

/// Снэпшот карточки в активной сессии.
@JsonSerializable(checked: true)
class CardSnapshotDto {
  final String id;
  final String testId;
  final String front;
  final List<String> answers;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isMixedIn;

  const CardSnapshotDto({
    required this.id,
    required this.testId,
    required this.front,
    required this.answers,
    required this.createdAt,
    required this.updatedAt,
    required this.isMixedIn,
  });

  factory CardSnapshotDto.fromJson(Map<String, dynamic> json) =>
      _$CardSnapshotDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CardSnapshotDtoToJson(this);
}
