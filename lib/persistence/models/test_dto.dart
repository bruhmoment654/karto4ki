import 'package:json_annotation/json_annotation.dart';

part 'test_dto.g.dart';

/// Test DTO for storage.
@JsonSerializable()
class TestDto {
  final String id;
  final String title;
  final String? description;
  final String type;
  final DateTime createdAt;
  final DateTime updatedAt;

  const TestDto({
    required this.id,
    required this.title,
    this.description,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TestDto.fromJson(Map<String, dynamic> json) =>
      _$TestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TestDtoToJson(this);
}
