import 'package:equatable/equatable.dart';

/// Error handled in application business logic layer.
///
/// Expected to be the only type of error we can receive
/// in application presentation layer.
abstract class Failure with EquatableMixin implements Exception {
  /// Error message.
  ///
  /// Should have content that is understandable when reading logs.
  final String? message;

  /// Parent [Exception], if any.
  ///
  /// Required for correct log recording.
  final Exception? parentException;

  /// Parent error [StackTrace], if any.
  final StackTrace? stackTrace;

  @override
  List<Object?> get props => [message, parentException, stackTrace];

  const Failure({this.message, this.parentException, this.stackTrace});
}
