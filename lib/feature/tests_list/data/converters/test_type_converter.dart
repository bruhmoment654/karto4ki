import 'package:karto4ki/feature/tests_list/domain/entity/test_type.dart';

/// Converter for [TestType] enum to/from String.
abstract final class TestTypeConverter {
  /// Converts [TestType] to String.
  static String toDto(TestType type) => type.name;

  /// Converts String to [TestType].
  static TestType fromDto(String dto) {
    return TestType.values.firstWhere(
      (t) => t.name == dto,
      orElse: () => TestType.tinder,
    );
  }
}
