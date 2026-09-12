// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tests_list_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TestsListEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TestsListEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TestsListEvent()';
}


}

/// @nodoc
class $TestsListEventCopyWith<$Res>  {
$TestsListEventCopyWith(TestsListEvent _, $Res Function(TestsListEvent) __);
}


/// Adds pattern-matching-related methods to [TestsListEvent].
extension TestsListEventPatterns on TestsListEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _TestsListEvent$Started value)?  started,TResult Function( _TestsListEvent$TestAdded value)?  testAdded,TResult Function( _TestsListEvent$TestDeleted value)?  testDeleted,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TestsListEvent$Started() when started != null:
return started(_that);case _TestsListEvent$TestAdded() when testAdded != null:
return testAdded(_that);case _TestsListEvent$TestDeleted() when testDeleted != null:
return testDeleted(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _TestsListEvent$Started value)  started,required TResult Function( _TestsListEvent$TestAdded value)  testAdded,required TResult Function( _TestsListEvent$TestDeleted value)  testDeleted,}){
final _that = this;
switch (_that) {
case _TestsListEvent$Started():
return started(_that);case _TestsListEvent$TestAdded():
return testAdded(_that);case _TestsListEvent$TestDeleted():
return testDeleted(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _TestsListEvent$Started value)?  started,TResult? Function( _TestsListEvent$TestAdded value)?  testAdded,TResult? Function( _TestsListEvent$TestDeleted value)?  testDeleted,}){
final _that = this;
switch (_that) {
case _TestsListEvent$Started() when started != null:
return started(_that);case _TestsListEvent$TestAdded() when testAdded != null:
return testAdded(_that);case _TestsListEvent$TestDeleted() when testDeleted != null:
return testDeleted(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( String title,  String? description)?  testAdded,TResult Function( String testId)?  testDeleted,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TestsListEvent$Started() when started != null:
return started();case _TestsListEvent$TestAdded() when testAdded != null:
return testAdded(_that.title,_that.description);case _TestsListEvent$TestDeleted() when testDeleted != null:
return testDeleted(_that.testId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( String title,  String? description)  testAdded,required TResult Function( String testId)  testDeleted,}) {final _that = this;
switch (_that) {
case _TestsListEvent$Started():
return started();case _TestsListEvent$TestAdded():
return testAdded(_that.title,_that.description);case _TestsListEvent$TestDeleted():
return testDeleted(_that.testId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( String title,  String? description)?  testAdded,TResult? Function( String testId)?  testDeleted,}) {final _that = this;
switch (_that) {
case _TestsListEvent$Started() when started != null:
return started();case _TestsListEvent$TestAdded() when testAdded != null:
return testAdded(_that.title,_that.description);case _TestsListEvent$TestDeleted() when testDeleted != null:
return testDeleted(_that.testId);case _:
  return null;

}
}

}

/// @nodoc


class _TestsListEvent$Started implements TestsListEvent {
  const _TestsListEvent$Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TestsListEvent$Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TestsListEvent.started()';
}


}




/// @nodoc


class _TestsListEvent$TestAdded implements TestsListEvent {
  const _TestsListEvent$TestAdded({required this.title, this.description});
  

 final  String title;
 final  String? description;

/// Create a copy of TestsListEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TestsListEvent$TestAddedCopyWith<_TestsListEvent$TestAdded> get copyWith => __$TestsListEvent$TestAddedCopyWithImpl<_TestsListEvent$TestAdded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TestsListEvent$TestAdded&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode => Object.hash(runtimeType,title,description);

@override
String toString() {
  return 'TestsListEvent.testAdded(title: $title, description: $description)';
}


}

/// @nodoc
abstract mixin class _$TestsListEvent$TestAddedCopyWith<$Res> implements $TestsListEventCopyWith<$Res> {
  factory _$TestsListEvent$TestAddedCopyWith(_TestsListEvent$TestAdded value, $Res Function(_TestsListEvent$TestAdded) _then) = __$TestsListEvent$TestAddedCopyWithImpl;
@useResult
$Res call({
 String title, String? description
});




}
/// @nodoc
class __$TestsListEvent$TestAddedCopyWithImpl<$Res>
    implements _$TestsListEvent$TestAddedCopyWith<$Res> {
  __$TestsListEvent$TestAddedCopyWithImpl(this._self, this._then);

  final _TestsListEvent$TestAdded _self;
  final $Res Function(_TestsListEvent$TestAdded) _then;

/// Create a copy of TestsListEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? title = null,Object? description = freezed,}) {
  return _then(_TestsListEvent$TestAdded(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _TestsListEvent$TestDeleted implements TestsListEvent {
  const _TestsListEvent$TestDeleted({required this.testId});
  

 final  String testId;

/// Create a copy of TestsListEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TestsListEvent$TestDeletedCopyWith<_TestsListEvent$TestDeleted> get copyWith => __$TestsListEvent$TestDeletedCopyWithImpl<_TestsListEvent$TestDeleted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TestsListEvent$TestDeleted&&(identical(other.testId, testId) || other.testId == testId));
}


@override
int get hashCode => Object.hash(runtimeType,testId);

@override
String toString() {
  return 'TestsListEvent.testDeleted(testId: $testId)';
}


}

/// @nodoc
abstract mixin class _$TestsListEvent$TestDeletedCopyWith<$Res> implements $TestsListEventCopyWith<$Res> {
  factory _$TestsListEvent$TestDeletedCopyWith(_TestsListEvent$TestDeleted value, $Res Function(_TestsListEvent$TestDeleted) _then) = __$TestsListEvent$TestDeletedCopyWithImpl;
@useResult
$Res call({
 String testId
});




}
/// @nodoc
class __$TestsListEvent$TestDeletedCopyWithImpl<$Res>
    implements _$TestsListEvent$TestDeletedCopyWith<$Res> {
  __$TestsListEvent$TestDeletedCopyWithImpl(this._self, this._then);

  final _TestsListEvent$TestDeleted _self;
  final $Res Function(_TestsListEvent$TestDeleted) _then;

/// Create a copy of TestsListEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? testId = null,}) {
  return _then(_TestsListEvent$TestDeleted(
testId: null == testId ? _self.testId : testId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$TestsListState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TestsListState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TestsListState()';
}


}

/// @nodoc
class $TestsListStateCopyWith<$Res>  {
$TestsListStateCopyWith(TestsListState _, $Res Function(TestsListState) __);
}


/// Adds pattern-matching-related methods to [TestsListState].
extension TestsListStatePatterns on TestsListState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( TestsListState$Loading value)?  loading,TResult Function( TestsListState$Loaded value)?  loaded,TResult Function( TestsListState$Error value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case TestsListState$Loading() when loading != null:
return loading(_that);case TestsListState$Loaded() when loaded != null:
return loaded(_that);case TestsListState$Error() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( TestsListState$Loading value)  loading,required TResult Function( TestsListState$Loaded value)  loaded,required TResult Function( TestsListState$Error value)  error,}){
final _that = this;
switch (_that) {
case TestsListState$Loading():
return loading(_that);case TestsListState$Loaded():
return loaded(_that);case TestsListState$Error():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( TestsListState$Loading value)?  loading,TResult? Function( TestsListState$Loaded value)?  loaded,TResult? Function( TestsListState$Error value)?  error,}){
final _that = this;
switch (_that) {
case TestsListState$Loading() when loading != null:
return loading(_that);case TestsListState$Loaded() when loaded != null:
return loaded(_that);case TestsListState$Error() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function( List<TestEntity> tests)?  loaded,TResult Function( Failure failure)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case TestsListState$Loading() when loading != null:
return loading();case TestsListState$Loaded() when loaded != null:
return loaded(_that.tests);case TestsListState$Error() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function( List<TestEntity> tests)  loaded,required TResult Function( Failure failure)  error,}) {final _that = this;
switch (_that) {
case TestsListState$Loading():
return loading();case TestsListState$Loaded():
return loaded(_that.tests);case TestsListState$Error():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function( List<TestEntity> tests)?  loaded,TResult? Function( Failure failure)?  error,}) {final _that = this;
switch (_that) {
case TestsListState$Loading() when loading != null:
return loading();case TestsListState$Loaded() when loaded != null:
return loaded(_that.tests);case TestsListState$Error() when error != null:
return error(_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class TestsListState$Loading extends TestsListState {
  const TestsListState$Loading(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TestsListState$Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TestsListState.loading()';
}


}




/// @nodoc


class TestsListState$Loaded extends TestsListState {
  const TestsListState$Loaded({required final  List<TestEntity> tests}): _tests = tests,super._();
  

 final  List<TestEntity> _tests;
 List<TestEntity> get tests {
  if (_tests is EqualUnmodifiableListView) return _tests;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tests);
}


/// Create a copy of TestsListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TestsListState$LoadedCopyWith<TestsListState$Loaded> get copyWith => _$TestsListState$LoadedCopyWithImpl<TestsListState$Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TestsListState$Loaded&&const DeepCollectionEquality().equals(other._tests, _tests));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_tests));

@override
String toString() {
  return 'TestsListState.loaded(tests: $tests)';
}


}

/// @nodoc
abstract mixin class $TestsListState$LoadedCopyWith<$Res> implements $TestsListStateCopyWith<$Res> {
  factory $TestsListState$LoadedCopyWith(TestsListState$Loaded value, $Res Function(TestsListState$Loaded) _then) = _$TestsListState$LoadedCopyWithImpl;
@useResult
$Res call({
 List<TestEntity> tests
});




}
/// @nodoc
class _$TestsListState$LoadedCopyWithImpl<$Res>
    implements $TestsListState$LoadedCopyWith<$Res> {
  _$TestsListState$LoadedCopyWithImpl(this._self, this._then);

  final TestsListState$Loaded _self;
  final $Res Function(TestsListState$Loaded) _then;

/// Create a copy of TestsListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tests = null,}) {
  return _then(TestsListState$Loaded(
tests: null == tests ? _self._tests : tests // ignore: cast_nullable_to_non_nullable
as List<TestEntity>,
  ));
}


}

/// @nodoc


class TestsListState$Error extends TestsListState {
  const TestsListState$Error({required this.failure}): super._();
  

 final  Failure failure;

/// Create a copy of TestsListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TestsListState$ErrorCopyWith<TestsListState$Error> get copyWith => _$TestsListState$ErrorCopyWithImpl<TestsListState$Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TestsListState$Error&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,failure);

@override
String toString() {
  return 'TestsListState.error(failure: $failure)';
}


}

/// @nodoc
abstract mixin class $TestsListState$ErrorCopyWith<$Res> implements $TestsListStateCopyWith<$Res> {
  factory $TestsListState$ErrorCopyWith(TestsListState$Error value, $Res Function(TestsListState$Error) _then) = _$TestsListState$ErrorCopyWithImpl;
@useResult
$Res call({
 Failure failure
});




}
/// @nodoc
class _$TestsListState$ErrorCopyWithImpl<$Res>
    implements $TestsListState$ErrorCopyWith<$Res> {
  _$TestsListState$ErrorCopyWithImpl(this._self, this._then);

  final TestsListState$Error _self;
  final $Res Function(TestsListState$Error) _then;

/// Create a copy of TestsListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(TestsListState$Error(
failure: null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}


}

// dart format on
