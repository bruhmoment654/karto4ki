import 'package:equatable/equatable.dart';

/// Ошибка, обработанная в слое бинес-логики приложения.
///
/// Ожидается, что это единственный вид ошибки, который мы можем получить
/// в презентационном слое приложения.
abstract class Failure with EquatableMixin implements Exception {
  /// Сообщение ошибки.
  ///
  /// Должно иметь такое содержание, которое будет понятно при чтении логов.
  final String? message;

  /// Родительский [Exception], если имеется.
  ///
  /// Необходим для корректной фиксации логов.
  final Exception? parentException;

  /// [StackTrace] родительской ошибки, если есть.
  final StackTrace? stackTrace;

  @override
  List<Object?> get props => [message, parentException, stackTrace];

  const Failure({this.message, this.parentException, this.stackTrace});
}
