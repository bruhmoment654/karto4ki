/// Точность ответов по последним прохождениям тестов.
abstract final class AccuracyCalculator {
  /// По скольким последним прохождениям теста считается его точность.
  static const attemptsWindow = 10;

  /// Точность группы — среднее точностей её тестов.
  ///
  /// Тесты без прохождений (`null`) не учитываются; `null`, если таких
  /// тестов нет вовсе.
  static double? groupAccuracy(Iterable<double?> testAccuracies) {
    final known = testAccuracies.nonNulls.toList();
    if (known.isEmpty) return null;

    return known.reduce((sum, value) => sum + value) / known.length;
  }
}
