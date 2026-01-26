import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';

/// Use `throttleTime` to throttle events.
///
/// Emits only one event in [duration] and ignores others.
EventTransformer<T> throttle<T>(Duration duration) {
  return (events, mapper) => events.throttleTime(duration).flatMap(mapper);
}

/// Use `debounceTime` to debounce events.
///
/// Emits only last event in [duration] and ignores others.
EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
