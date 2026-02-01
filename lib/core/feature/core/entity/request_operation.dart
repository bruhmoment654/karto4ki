import 'package:karto4ki/core/feature/core/entity/result.dart';
import 'package:karto4ki/core/feature/core/failure.dart';

/// Typedef for all methods that may fail.
/// These are mostly repository methods.
typedef RequestOperation<T> = Future<Result<T, Object>>;

/// [RequestOperation] variant for domain layer.
///
/// Unlike regular [RequestOperation], returns more specific
/// [Failure] instead of [Object].
typedef RequestOperationDomain<T> = Future<DomainResult<T>>;

/// Result adapted for domain.
typedef DomainResult<T> = Result<T, Failure>;
