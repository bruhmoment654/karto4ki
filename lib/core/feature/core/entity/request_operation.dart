import 'package:karto4ki/core/feature/core/entity/result.dart';
import 'package:karto4ki/core/feature/core/failure.dart';

/// Typedef for all methods that may fail.
/// These are mostly repository methods.
typedef RequestOperation<T> = Future<Result<T, Object>>;

/// Разновидность [RequestOperation] для domain-части.
///
/// В отличие от обычного [RequestOperation], возвращает более конкретный
/// [Failure] вместо [Object].
typedef RequestOperationDomain<T> = Future<DomainResult<T>>;

/// Результат, адаптированный для домена.
typedef DomainResult<T> = Result<T, Failure>;
