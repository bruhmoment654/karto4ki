// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'question_stats_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$QuestionStatsEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuestionStatsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'QuestionStatsEvent()';
}


}

/// @nodoc
class $QuestionStatsEventCopyWith<$Res>  {
$QuestionStatsEventCopyWith(QuestionStatsEvent _, $Res Function(QuestionStatsEvent) __);
}


/// Adds pattern-matching-related methods to [QuestionStatsEvent].
extension QuestionStatsEventPatterns on QuestionStatsEvent {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _QuestionStatsEvent$Started value)?  started,TResult Function( _QuestionStatsEvent$SortChanged value)?  sortChanged,TResult Function( _QuestionStatsEvent$SortOrderToggled value)?  sortOrderToggled,TResult Function( _QuestionStatsEvent$SearchChanged value)?  searchChanged,TResult Function( _QuestionStatsEvent$SearchCleared value)?  searchCleared,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuestionStatsEvent$Started() when started != null:
return started(_that);case _QuestionStatsEvent$SortChanged() when sortChanged != null:
return sortChanged(_that);case _QuestionStatsEvent$SortOrderToggled() when sortOrderToggled != null:
return sortOrderToggled(_that);case _QuestionStatsEvent$SearchChanged() when searchChanged != null:
return searchChanged(_that);case _QuestionStatsEvent$SearchCleared() when searchCleared != null:
return searchCleared(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _QuestionStatsEvent$Started value)  started,required TResult Function( _QuestionStatsEvent$SortChanged value)  sortChanged,required TResult Function( _QuestionStatsEvent$SortOrderToggled value)  sortOrderToggled,required TResult Function( _QuestionStatsEvent$SearchChanged value)  searchChanged,required TResult Function( _QuestionStatsEvent$SearchCleared value)  searchCleared,}){
final _that = this;
switch (_that) {
case _QuestionStatsEvent$Started():
return started(_that);case _QuestionStatsEvent$SortChanged():
return sortChanged(_that);case _QuestionStatsEvent$SortOrderToggled():
return sortOrderToggled(_that);case _QuestionStatsEvent$SearchChanged():
return searchChanged(_that);case _QuestionStatsEvent$SearchCleared():
return searchCleared(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _QuestionStatsEvent$Started value)?  started,TResult? Function( _QuestionStatsEvent$SortChanged value)?  sortChanged,TResult? Function( _QuestionStatsEvent$SortOrderToggled value)?  sortOrderToggled,TResult? Function( _QuestionStatsEvent$SearchChanged value)?  searchChanged,TResult? Function( _QuestionStatsEvent$SearchCleared value)?  searchCleared,}){
final _that = this;
switch (_that) {
case _QuestionStatsEvent$Started() when started != null:
return started(_that);case _QuestionStatsEvent$SortChanged() when sortChanged != null:
return sortChanged(_that);case _QuestionStatsEvent$SortOrderToggled() when sortOrderToggled != null:
return sortOrderToggled(_that);case _QuestionStatsEvent$SearchChanged() when searchChanged != null:
return searchChanged(_that);case _QuestionStatsEvent$SearchCleared() when searchCleared != null:
return searchCleared(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( QuestionStatsSort sort)?  sortChanged,TResult Function()?  sortOrderToggled,TResult Function( String query)?  searchChanged,TResult Function()?  searchCleared,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuestionStatsEvent$Started() when started != null:
return started();case _QuestionStatsEvent$SortChanged() when sortChanged != null:
return sortChanged(_that.sort);case _QuestionStatsEvent$SortOrderToggled() when sortOrderToggled != null:
return sortOrderToggled();case _QuestionStatsEvent$SearchChanged() when searchChanged != null:
return searchChanged(_that.query);case _QuestionStatsEvent$SearchCleared() when searchCleared != null:
return searchCleared();case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( QuestionStatsSort sort)  sortChanged,required TResult Function()  sortOrderToggled,required TResult Function( String query)  searchChanged,required TResult Function()  searchCleared,}) {final _that = this;
switch (_that) {
case _QuestionStatsEvent$Started():
return started();case _QuestionStatsEvent$SortChanged():
return sortChanged(_that.sort);case _QuestionStatsEvent$SortOrderToggled():
return sortOrderToggled();case _QuestionStatsEvent$SearchChanged():
return searchChanged(_that.query);case _QuestionStatsEvent$SearchCleared():
return searchCleared();}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( QuestionStatsSort sort)?  sortChanged,TResult? Function()?  sortOrderToggled,TResult? Function( String query)?  searchChanged,TResult? Function()?  searchCleared,}) {final _that = this;
switch (_that) {
case _QuestionStatsEvent$Started() when started != null:
return started();case _QuestionStatsEvent$SortChanged() when sortChanged != null:
return sortChanged(_that.sort);case _QuestionStatsEvent$SortOrderToggled() when sortOrderToggled != null:
return sortOrderToggled();case _QuestionStatsEvent$SearchChanged() when searchChanged != null:
return searchChanged(_that.query);case _QuestionStatsEvent$SearchCleared() when searchCleared != null:
return searchCleared();case _:
  return null;

}
}

}

/// @nodoc


class _QuestionStatsEvent$Started implements QuestionStatsEvent {
  const _QuestionStatsEvent$Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuestionStatsEvent$Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'QuestionStatsEvent.started()';
}


}




/// @nodoc


class _QuestionStatsEvent$SortChanged implements QuestionStatsEvent {
  const _QuestionStatsEvent$SortChanged({required this.sort});
  

 final  QuestionStatsSort sort;

/// Create a copy of QuestionStatsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuestionStatsEvent$SortChangedCopyWith<_QuestionStatsEvent$SortChanged> get copyWith => __$QuestionStatsEvent$SortChangedCopyWithImpl<_QuestionStatsEvent$SortChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuestionStatsEvent$SortChanged&&(identical(other.sort, sort) || other.sort == sort));
}


@override
int get hashCode => Object.hash(runtimeType,sort);

@override
String toString() {
  return 'QuestionStatsEvent.sortChanged(sort: $sort)';
}


}

/// @nodoc
abstract mixin class _$QuestionStatsEvent$SortChangedCopyWith<$Res> implements $QuestionStatsEventCopyWith<$Res> {
  factory _$QuestionStatsEvent$SortChangedCopyWith(_QuestionStatsEvent$SortChanged value, $Res Function(_QuestionStatsEvent$SortChanged) _then) = __$QuestionStatsEvent$SortChangedCopyWithImpl;
@useResult
$Res call({
 QuestionStatsSort sort
});




}
/// @nodoc
class __$QuestionStatsEvent$SortChangedCopyWithImpl<$Res>
    implements _$QuestionStatsEvent$SortChangedCopyWith<$Res> {
  __$QuestionStatsEvent$SortChangedCopyWithImpl(this._self, this._then);

  final _QuestionStatsEvent$SortChanged _self;
  final $Res Function(_QuestionStatsEvent$SortChanged) _then;

/// Create a copy of QuestionStatsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? sort = null,}) {
  return _then(_QuestionStatsEvent$SortChanged(
sort: null == sort ? _self.sort : sort // ignore: cast_nullable_to_non_nullable
as QuestionStatsSort,
  ));
}


}

/// @nodoc


class _QuestionStatsEvent$SortOrderToggled implements QuestionStatsEvent {
  const _QuestionStatsEvent$SortOrderToggled();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuestionStatsEvent$SortOrderToggled);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'QuestionStatsEvent.sortOrderToggled()';
}


}




/// @nodoc


class _QuestionStatsEvent$SearchChanged implements QuestionStatsEvent {
  const _QuestionStatsEvent$SearchChanged({required this.query});
  

 final  String query;

/// Create a copy of QuestionStatsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuestionStatsEvent$SearchChangedCopyWith<_QuestionStatsEvent$SearchChanged> get copyWith => __$QuestionStatsEvent$SearchChangedCopyWithImpl<_QuestionStatsEvent$SearchChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuestionStatsEvent$SearchChanged&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode => Object.hash(runtimeType,query);

@override
String toString() {
  return 'QuestionStatsEvent.searchChanged(query: $query)';
}


}

/// @nodoc
abstract mixin class _$QuestionStatsEvent$SearchChangedCopyWith<$Res> implements $QuestionStatsEventCopyWith<$Res> {
  factory _$QuestionStatsEvent$SearchChangedCopyWith(_QuestionStatsEvent$SearchChanged value, $Res Function(_QuestionStatsEvent$SearchChanged) _then) = __$QuestionStatsEvent$SearchChangedCopyWithImpl;
@useResult
$Res call({
 String query
});




}
/// @nodoc
class __$QuestionStatsEvent$SearchChangedCopyWithImpl<$Res>
    implements _$QuestionStatsEvent$SearchChangedCopyWith<$Res> {
  __$QuestionStatsEvent$SearchChangedCopyWithImpl(this._self, this._then);

  final _QuestionStatsEvent$SearchChanged _self;
  final $Res Function(_QuestionStatsEvent$SearchChanged) _then;

/// Create a copy of QuestionStatsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? query = null,}) {
  return _then(_QuestionStatsEvent$SearchChanged(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _QuestionStatsEvent$SearchCleared implements QuestionStatsEvent {
  const _QuestionStatsEvent$SearchCleared();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuestionStatsEvent$SearchCleared);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'QuestionStatsEvent.searchCleared()';
}


}




/// @nodoc
mixin _$QuestionStatsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuestionStatsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'QuestionStatsState()';
}


}

/// @nodoc
class $QuestionStatsStateCopyWith<$Res>  {
$QuestionStatsStateCopyWith(QuestionStatsState _, $Res Function(QuestionStatsState) __);
}


/// Adds pattern-matching-related methods to [QuestionStatsState].
extension QuestionStatsStatePatterns on QuestionStatsState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( QuestionStatsState$Loading value)?  loading,TResult Function( QuestionStatsState$Loaded value)?  loaded,TResult Function( QuestionStatsState$Error value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case QuestionStatsState$Loading() when loading != null:
return loading(_that);case QuestionStatsState$Loaded() when loaded != null:
return loaded(_that);case QuestionStatsState$Error() when error != null:
return error(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( QuestionStatsState$Loading value)  loading,required TResult Function( QuestionStatsState$Loaded value)  loaded,required TResult Function( QuestionStatsState$Error value)  error,}){
final _that = this;
switch (_that) {
case QuestionStatsState$Loading():
return loading(_that);case QuestionStatsState$Loaded():
return loaded(_that);case QuestionStatsState$Error():
return error(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( QuestionStatsState$Loading value)?  loading,TResult? Function( QuestionStatsState$Loaded value)?  loaded,TResult? Function( QuestionStatsState$Error value)?  error,}){
final _that = this;
switch (_that) {
case QuestionStatsState$Loading() when loading != null:
return loading(_that);case QuestionStatsState$Loaded() when loaded != null:
return loaded(_that);case QuestionStatsState$Error() when error != null:
return error(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function( List<QuestionStatsEntity> stats,  bool hasAnyStats,  QuestionStatsSort sort,  SortOrder order,  String searchQuery)?  loaded,TResult Function( Failure failure)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case QuestionStatsState$Loading() when loading != null:
return loading();case QuestionStatsState$Loaded() when loaded != null:
return loaded(_that.stats,_that.hasAnyStats,_that.sort,_that.order,_that.searchQuery);case QuestionStatsState$Error() when error != null:
return error(_that.failure);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function( List<QuestionStatsEntity> stats,  bool hasAnyStats,  QuestionStatsSort sort,  SortOrder order,  String searchQuery)  loaded,required TResult Function( Failure failure)  error,}) {final _that = this;
switch (_that) {
case QuestionStatsState$Loading():
return loading();case QuestionStatsState$Loaded():
return loaded(_that.stats,_that.hasAnyStats,_that.sort,_that.order,_that.searchQuery);case QuestionStatsState$Error():
return error(_that.failure);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function( List<QuestionStatsEntity> stats,  bool hasAnyStats,  QuestionStatsSort sort,  SortOrder order,  String searchQuery)?  loaded,TResult? Function( Failure failure)?  error,}) {final _that = this;
switch (_that) {
case QuestionStatsState$Loading() when loading != null:
return loading();case QuestionStatsState$Loaded() when loaded != null:
return loaded(_that.stats,_that.hasAnyStats,_that.sort,_that.order,_that.searchQuery);case QuestionStatsState$Error() when error != null:
return error(_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class QuestionStatsState$Loading extends QuestionStatsState {
  const QuestionStatsState$Loading(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuestionStatsState$Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'QuestionStatsState.loading()';
}


}




/// @nodoc


class QuestionStatsState$Loaded extends QuestionStatsState {
  const QuestionStatsState$Loaded({required final  List<QuestionStatsEntity> stats, required this.hasAnyStats, required this.sort, required this.order, required this.searchQuery}): _stats = stats,super._();
  

/// Отфильтрованный и отсортированный список для показа.
 final  List<QuestionStatsEntity> _stats;
/// Отфильтрованный и отсортированный список для показа.
 List<QuestionStatsEntity> get stats {
  if (_stats is EqualUnmodifiableListView) return _stats;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stats);
}

/// Есть ли вообще статистика — отличает «пусто» от «ничего не нашлось».
 final  bool hasAnyStats;
 final  QuestionStatsSort sort;
 final  SortOrder order;
 final  String searchQuery;

/// Create a copy of QuestionStatsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuestionStatsState$LoadedCopyWith<QuestionStatsState$Loaded> get copyWith => _$QuestionStatsState$LoadedCopyWithImpl<QuestionStatsState$Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuestionStatsState$Loaded&&const DeepCollectionEquality().equals(other._stats, _stats)&&(identical(other.hasAnyStats, hasAnyStats) || other.hasAnyStats == hasAnyStats)&&(identical(other.sort, sort) || other.sort == sort)&&(identical(other.order, order) || other.order == order)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_stats),hasAnyStats,sort,order,searchQuery);

@override
String toString() {
  return 'QuestionStatsState.loaded(stats: $stats, hasAnyStats: $hasAnyStats, sort: $sort, order: $order, searchQuery: $searchQuery)';
}


}

/// @nodoc
abstract mixin class $QuestionStatsState$LoadedCopyWith<$Res> implements $QuestionStatsStateCopyWith<$Res> {
  factory $QuestionStatsState$LoadedCopyWith(QuestionStatsState$Loaded value, $Res Function(QuestionStatsState$Loaded) _then) = _$QuestionStatsState$LoadedCopyWithImpl;
@useResult
$Res call({
 List<QuestionStatsEntity> stats, bool hasAnyStats, QuestionStatsSort sort, SortOrder order, String searchQuery
});




}
/// @nodoc
class _$QuestionStatsState$LoadedCopyWithImpl<$Res>
    implements $QuestionStatsState$LoadedCopyWith<$Res> {
  _$QuestionStatsState$LoadedCopyWithImpl(this._self, this._then);

  final QuestionStatsState$Loaded _self;
  final $Res Function(QuestionStatsState$Loaded) _then;

/// Create a copy of QuestionStatsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? stats = null,Object? hasAnyStats = null,Object? sort = null,Object? order = null,Object? searchQuery = null,}) {
  return _then(QuestionStatsState$Loaded(
stats: null == stats ? _self._stats : stats // ignore: cast_nullable_to_non_nullable
as List<QuestionStatsEntity>,hasAnyStats: null == hasAnyStats ? _self.hasAnyStats : hasAnyStats // ignore: cast_nullable_to_non_nullable
as bool,sort: null == sort ? _self.sort : sort // ignore: cast_nullable_to_non_nullable
as QuestionStatsSort,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as SortOrder,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class QuestionStatsState$Error extends QuestionStatsState {
  const QuestionStatsState$Error({required this.failure}): super._();
  

 final  Failure failure;

/// Create a copy of QuestionStatsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuestionStatsState$ErrorCopyWith<QuestionStatsState$Error> get copyWith => _$QuestionStatsState$ErrorCopyWithImpl<QuestionStatsState$Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuestionStatsState$Error&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,failure);

@override
String toString() {
  return 'QuestionStatsState.error(failure: $failure)';
}


}

/// @nodoc
abstract mixin class $QuestionStatsState$ErrorCopyWith<$Res> implements $QuestionStatsStateCopyWith<$Res> {
  factory $QuestionStatsState$ErrorCopyWith(QuestionStatsState$Error value, $Res Function(QuestionStatsState$Error) _then) = _$QuestionStatsState$ErrorCopyWithImpl;
@useResult
$Res call({
 Failure failure
});




}
/// @nodoc
class _$QuestionStatsState$ErrorCopyWithImpl<$Res>
    implements $QuestionStatsState$ErrorCopyWith<$Res> {
  _$QuestionStatsState$ErrorCopyWithImpl(this._self, this._then);

  final QuestionStatsState$Error _self;
  final $Res Function(QuestionStatsState$Error) _then;

/// Create a copy of QuestionStatsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(QuestionStatsState$Error(
failure: null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}


}

// dart format on
