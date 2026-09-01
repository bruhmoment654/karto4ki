/// Значение поля PATCH-запроса, различающее «не трогать» и «очистить».
///
/// Отсутствие [PatchValue] (само поле равно `null`) — ключ в тело не
/// попадает и сервер поле не меняет. `PatchValue(null)` — в теле уходит
/// `"field": null`, то есть поле очищается.
class PatchValue<T> {
  final T value;

  const PatchValue(this.value);
}

/// Помощник сборки тела PATCH-запроса.
abstract final class PatchBody {
  /// Кладёт [value] в [target] по ключу [key], если поле задано.
  static void put<T>(
    Map<String, Object?> target,
    String key,
    PatchValue<T>? value,
  ) {
    if (value == null) return;

    target[key] = value.value;
  }
}
