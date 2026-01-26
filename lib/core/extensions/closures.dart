// ignore_for_file: prefer-match-file-name

/// Функция для преобразования объекта.
typedef Closure<R, T> = R Function(T it);

/// Let extension.
extension LetX<T extends Object> on T {
  /// Вызывает [Closure] с самим объектом в качестве аргумента.
  R let<R>(Closure<R, T> closure) {
    return closure(this);
  }

  /// Вызывает [Closure] с самим объектом в качестве аргумента.
  R? run<R>(Closure<R?, T> closure) {
    return closure(this);
  }
}
