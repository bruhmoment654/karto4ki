// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'test_session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TestSession {

/// Test identifier.
 String get testId;/// List of cards to go through.
 List<CardEntity> get cards;/// Current card index.
 int get currentIndex;/// Results for answered cards.
 List<CardResult> get results;/// Session start time.
 DateTime get startedAt;/// Session completion time (null if not completed).
 DateTime? get completedAt;
/// Create a copy of TestSession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TestSessionCopyWith<TestSession> get copyWith => _$TestSessionCopyWithImpl<TestSession>(this as TestSession, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TestSession&&(identical(other.testId, testId) || other.testId == testId)&&const DeepCollectionEquality().equals(other.cards, cards)&&(identical(other.currentIndex, currentIndex) || other.currentIndex == currentIndex)&&const DeepCollectionEquality().equals(other.results, results)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt));
}


@override
int get hashCode => Object.hash(runtimeType,testId,const DeepCollectionEquality().hash(cards),currentIndex,const DeepCollectionEquality().hash(results),startedAt,completedAt);

@override
String toString() {
  return 'TestSession(testId: $testId, cards: $cards, currentIndex: $currentIndex, results: $results, startedAt: $startedAt, completedAt: $completedAt)';
}


}

/// @nodoc
abstract mixin class $TestSessionCopyWith<$Res>  {
  factory $TestSessionCopyWith(TestSession value, $Res Function(TestSession) _then) = _$TestSessionCopyWithImpl;
@useResult
$Res call({
 String testId, List<CardEntity> cards, int currentIndex, List<CardResult> results, DateTime startedAt, DateTime? completedAt
});




}
/// @nodoc
class _$TestSessionCopyWithImpl<$Res>
    implements $TestSessionCopyWith<$Res> {
  _$TestSessionCopyWithImpl(this._self, this._then);

  final TestSession _self;
  final $Res Function(TestSession) _then;

/// Create a copy of TestSession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? testId = null,Object? cards = null,Object? currentIndex = null,Object? results = null,Object? startedAt = null,Object? completedAt = freezed,}) {
  return _then(_self.copyWith(
testId: null == testId ? _self.testId : testId // ignore: cast_nullable_to_non_nullable
as String,cards: null == cards ? _self.cards : cards // ignore: cast_nullable_to_non_nullable
as List<CardEntity>,currentIndex: null == currentIndex ? _self.currentIndex : currentIndex // ignore: cast_nullable_to_non_nullable
as int,results: null == results ? _self.results : results // ignore: cast_nullable_to_non_nullable
as List<CardResult>,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [TestSession].
extension TestSessionPatterns on TestSession {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TestSession value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TestSession() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TestSession value)  $default,){
final _that = this;
switch (_that) {
case _TestSession():
return $default(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TestSession value)?  $default,){
final _that = this;
switch (_that) {
case _TestSession() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String testId,  List<CardEntity> cards,  int currentIndex,  List<CardResult> results,  DateTime startedAt,  DateTime? completedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TestSession() when $default != null:
return $default(_that.testId,_that.cards,_that.currentIndex,_that.results,_that.startedAt,_that.completedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String testId,  List<CardEntity> cards,  int currentIndex,  List<CardResult> results,  DateTime startedAt,  DateTime? completedAt)  $default,) {final _that = this;
switch (_that) {
case _TestSession():
return $default(_that.testId,_that.cards,_that.currentIndex,_that.results,_that.startedAt,_that.completedAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String testId,  List<CardEntity> cards,  int currentIndex,  List<CardResult> results,  DateTime startedAt,  DateTime? completedAt)?  $default,) {final _that = this;
switch (_that) {
case _TestSession() when $default != null:
return $default(_that.testId,_that.cards,_that.currentIndex,_that.results,_that.startedAt,_that.completedAt);case _:
  return null;

}
}

}

/// @nodoc


class _TestSession extends TestSession {
  const _TestSession({required this.testId, required final  List<CardEntity> cards, required this.currentIndex, required final  List<CardResult> results, required this.startedAt, this.completedAt}): _cards = cards,_results = results,super._();
  

/// Test identifier.
@override final  String testId;
/// List of cards to go through.
 final  List<CardEntity> _cards;
/// List of cards to go through.
@override List<CardEntity> get cards {
  if (_cards is EqualUnmodifiableListView) return _cards;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cards);
}

/// Current card index.
@override final  int currentIndex;
/// Results for answered cards.
 final  List<CardResult> _results;
/// Results for answered cards.
@override List<CardResult> get results {
  if (_results is EqualUnmodifiableListView) return _results;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_results);
}

/// Session start time.
@override final  DateTime startedAt;
/// Session completion time (null if not completed).
@override final  DateTime? completedAt;

/// Create a copy of TestSession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TestSessionCopyWith<_TestSession> get copyWith => __$TestSessionCopyWithImpl<_TestSession>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TestSession&&(identical(other.testId, testId) || other.testId == testId)&&const DeepCollectionEquality().equals(other._cards, _cards)&&(identical(other.currentIndex, currentIndex) || other.currentIndex == currentIndex)&&const DeepCollectionEquality().equals(other._results, _results)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt));
}


@override
int get hashCode => Object.hash(runtimeType,testId,const DeepCollectionEquality().hash(_cards),currentIndex,const DeepCollectionEquality().hash(_results),startedAt,completedAt);

@override
String toString() {
  return 'TestSession(testId: $testId, cards: $cards, currentIndex: $currentIndex, results: $results, startedAt: $startedAt, completedAt: $completedAt)';
}


}

/// @nodoc
abstract mixin class _$TestSessionCopyWith<$Res> implements $TestSessionCopyWith<$Res> {
  factory _$TestSessionCopyWith(_TestSession value, $Res Function(_TestSession) _then) = __$TestSessionCopyWithImpl;
@override @useResult
$Res call({
 String testId, List<CardEntity> cards, int currentIndex, List<CardResult> results, DateTime startedAt, DateTime? completedAt
});




}
/// @nodoc
class __$TestSessionCopyWithImpl<$Res>
    implements _$TestSessionCopyWith<$Res> {
  __$TestSessionCopyWithImpl(this._self, this._then);

  final _TestSession _self;
  final $Res Function(_TestSession) _then;

/// Create a copy of TestSession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? testId = null,Object? cards = null,Object? currentIndex = null,Object? results = null,Object? startedAt = null,Object? completedAt = freezed,}) {
  return _then(_TestSession(
testId: null == testId ? _self.testId : testId // ignore: cast_nullable_to_non_nullable
as String,cards: null == cards ? _self._cards : cards // ignore: cast_nullable_to_non_nullable
as List<CardEntity>,currentIndex: null == currentIndex ? _self.currentIndex : currentIndex // ignore: cast_nullable_to_non_nullable
as int,results: null == results ? _self._results : results // ignore: cast_nullable_to_non_nullable
as List<CardResult>,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
