import 'package:karto4ki/core/feature/core/failure.dart';

/// Failure when requested entity is not found.
class NotFoundFailure extends Failure {
  final String entityName;

  const NotFoundFailure({
    required this.entityName,
    super.message,
    super.parentException,
    super.stackTrace,
  });

  @override
  List<Object?> get props => [...super.props, entityName];
}
