import 'package:freezed_annotation/freezed_annotation.dart';

part 'test_group_entity.freezed.dart';

@freezed
sealed class TestGroupEntity with _$TestGroupEntity {
  const factory TestGroupEntity({
    required String id,
    required String title,
    required DateTime createdAt,
    required DateTime updatedAt,
    required int testCount,
  }) = _TestGroupEntity;
}
