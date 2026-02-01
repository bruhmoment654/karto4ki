// ignore_for_file: prefer-match-file-name

/// Function for object transformation.
typedef Closure<R, T> = R Function(T it);

/// Let extension.
extension LetX<T extends Object> on T {
  /// Calls [Closure] with the object itself as argument.
  R let<R>(Closure<R, T> closure) {
    return closure(this);
  }

  /// Calls [Closure] with the object itself as argument.
  R? run<R>(Closure<R?, T> closure) {
    return closure(this);
  }
}
