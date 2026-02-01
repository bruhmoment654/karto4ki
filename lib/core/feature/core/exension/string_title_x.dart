extension StringTitleX on String {
  /// Делает первую букву заглавной, остальные маленькие.
  String get toCapitalized =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  /// Делает первую букву каждого слова заглавной, остальные маленькие.
  String get toTitleCase => replaceAll(
        RegExp(' +'),
        ' ',
      ).split(' ').map((str) => str.toCapitalized).join(' ');
}

/// Преобразует строку в null, если она пустая.
///
/// Уменьшает бойлерплейт с проверками на `isNotEmpty`.
extension MaybeStringX on String? {
  String? get notEmpty => (this?.isNotEmpty ?? true) ? this : null;
}
