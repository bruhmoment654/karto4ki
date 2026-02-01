import 'package:karto4ki/core/feature/core/failure.dart';

/// Unknown failure for unhandled exceptions.
class UnknownFailure extends Failure {
  const UnknownFailure({
    super.message,
    super.parentException,
    super.stackTrace,
  });

  factory UnknownFailure.fromException(Object error, [StackTrace? stackTrace]) {
    return UnknownFailure(
      message: error.toString(),
      parentException: error is Exception ? error : null,
      stackTrace: stackTrace,
    );
  }
}
