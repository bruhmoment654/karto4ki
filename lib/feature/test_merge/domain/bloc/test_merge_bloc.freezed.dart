// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'test_merge_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TestMergeEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TestMergeEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TestMergeEvent()';
}


}

/// @nodoc
class $TestMergeEventCopyWith<$Res>  {
$TestMergeEventCopyWith(TestMergeEvent _, $Res Function(TestMergeEvent) __);
}


/// Adds pattern-matching-related methods to [TestMergeEvent].
extension TestMergeEventPatterns on TestMergeEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _TestMergeEvent$Started value)?  started,TResult Function( _TestMergeEvent$TestToggled value)?  testToggled,TResult Function( _TestMergeEvent$MergeConfirmed value)?  mergeConfirmed,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TestMergeEvent$Started() when started != null:
return started(_that);case _TestMergeEvent$TestToggled() when testToggled != null:
return testToggled(_that);case _TestMergeEvent$MergeConfirmed() when mergeConfirmed != null:
return mergeConfirmed(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _TestMergeEvent$Started value)  started,required TResult Function( _TestMergeEvent$TestToggled value)  testToggled,required TResult Function( _TestMergeEvent$MergeConfirmed value)  mergeConfirmed,}){
final _that = this;
switch (_that) {
case _TestMergeEvent$Started():
return started(_that);case _TestMergeEvent$TestToggled():
return testToggled(_that);case _TestMergeEvent$MergeConfirmed():
return mergeConfirmed(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _TestMergeEvent$Started value)?  started,TResult? Function( _TestMergeEvent$TestToggled value)?  testToggled,TResult? Function( _TestMergeEvent$MergeConfirmed value)?  mergeConfirmed,}){
final _that = this;
switch (_that) {
case _TestMergeEvent$Started() when started != null:
return started(_that);case _TestMergeEvent$TestToggled() when testToggled != null:
return testToggled(_that);case _TestMergeEvent$MergeConfirmed() when mergeConfirmed != null:
return mergeConfirmed(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String initialTestId)?  started,TResult Function( String testId)?  testToggled,TResult Function( String title)?  mergeConfirmed,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TestMergeEvent$Started() when started != null:
return started(_that.initialTestId);case _TestMergeEvent$TestToggled() when testToggled != null:
return testToggled(_that.testId);case _TestMergeEvent$MergeConfirmed() when mergeConfirmed != null:
return mergeConfirmed(_that.title);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String initialTestId)  started,required TResult Function( String testId)  testToggled,required TResult Function( String title)  mergeConfirmed,}) {final _that = this;
switch (_that) {
case _TestMergeEvent$Started():
return started(_that.initialTestId);case _TestMergeEvent$TestToggled():
return testToggled(_that.testId);case _TestMergeEvent$MergeConfirmed():
return mergeConfirmed(_that.title);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String initialTestId)?  started,TResult? Function( String testId)?  testToggled,TResult? Function( String title)?  mergeConfirmed,}) {final _that = this;
switch (_that) {
case _TestMergeEvent$Started() when started != null:
return started(_that.initialTestId);case _TestMergeEvent$TestToggled() when testToggled != null:
return testToggled(_that.testId);case _TestMergeEvent$MergeConfirmed() when mergeConfirmed != null:
return mergeConfirmed(_that.title);case _:
  return null;

}
}

}

/// @nodoc


class _TestMergeEvent$Started implements TestMergeEvent {
  const _TestMergeEvent$Started({required this.initialTestId});
  

 final  String initialTestId;

/// Create a copy of TestMergeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TestMergeEvent$StartedCopyWith<_TestMergeEvent$Started> get copyWith => __$TestMergeEvent$StartedCopyWithImpl<_TestMergeEvent$Started>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TestMergeEvent$Started&&(identical(other.initialTestId, initialTestId) || other.initialTestId == initialTestId));
}


@override
int get hashCode => Object.hash(runtimeType,initialTestId);

@override
String toString() {
  return 'TestMergeEvent.started(initialTestId: $initialTestId)';
}


}

/// @nodoc
abstract mixin class _$TestMergeEvent$StartedCopyWith<$Res> implements $TestMergeEventCopyWith<$Res> {
  factory _$TestMergeEvent$StartedCopyWith(_TestMergeEvent$Started value, $Res Function(_TestMergeEvent$Started) _then) = __$TestMergeEvent$StartedCopyWithImpl;
@useResult
$Res call({
 String initialTestId
});




}
/// @nodoc
class __$TestMergeEvent$StartedCopyWithImpl<$Res>
    implements _$TestMergeEvent$StartedCopyWith<$Res> {
  __$TestMergeEvent$StartedCopyWithImpl(this._self, this._then);

  final _TestMergeEvent$Started _self;
  final $Res Function(_TestMergeEvent$Started) _then;

/// Create a copy of TestMergeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? initialTestId = null,}) {
  return _then(_TestMergeEvent$Started(
initialTestId: null == initialTestId ? _self.initialTestId : initialTestId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _TestMergeEvent$TestToggled implements TestMergeEvent {
  const _TestMergeEvent$TestToggled({required this.testId});
  

 final  String testId;

/// Create a copy of TestMergeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TestMergeEvent$TestToggledCopyWith<_TestMergeEvent$TestToggled> get copyWith => __$TestMergeEvent$TestToggledCopyWithImpl<_TestMergeEvent$TestToggled>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TestMergeEvent$TestToggled&&(identical(other.testId, testId) || other.testId == testId));
}


@override
int get hashCode => Object.hash(runtimeType,testId);

@override
String toString() {
  return 'TestMergeEvent.testToggled(testId: $testId)';
}


}

/// @nodoc
abstract mixin class _$TestMergeEvent$TestToggledCopyWith<$Res> implements $TestMergeEventCopyWith<$Res> {
  factory _$TestMergeEvent$TestToggledCopyWith(_TestMergeEvent$TestToggled value, $Res Function(_TestMergeEvent$TestToggled) _then) = __$TestMergeEvent$TestToggledCopyWithImpl;
@useResult
$Res call({
 String testId
});




}
/// @nodoc
class __$TestMergeEvent$TestToggledCopyWithImpl<$Res>
    implements _$TestMergeEvent$TestToggledCopyWith<$Res> {
  __$TestMergeEvent$TestToggledCopyWithImpl(this._self, this._then);

  final _TestMergeEvent$TestToggled _self;
  final $Res Function(_TestMergeEvent$TestToggled) _then;

/// Create a copy of TestMergeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? testId = null,}) {
  return _then(_TestMergeEvent$TestToggled(
testId: null == testId ? _self.testId : testId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _TestMergeEvent$MergeConfirmed implements TestMergeEvent {
  const _TestMergeEvent$MergeConfirmed({required this.title});
  

 final  String title;

/// Create a copy of TestMergeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TestMergeEvent$MergeConfirmedCopyWith<_TestMergeEvent$MergeConfirmed> get copyWith => __$TestMergeEvent$MergeConfirmedCopyWithImpl<_TestMergeEvent$MergeConfirmed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TestMergeEvent$MergeConfirmed&&(identical(other.title, title) || other.title == title));
}


@override
int get hashCode => Object.hash(runtimeType,title);

@override
String toString() {
  return 'TestMergeEvent.mergeConfirmed(title: $title)';
}


}

/// @nodoc
abstract mixin class _$TestMergeEvent$MergeConfirmedCopyWith<$Res> implements $TestMergeEventCopyWith<$Res> {
  factory _$TestMergeEvent$MergeConfirmedCopyWith(_TestMergeEvent$MergeConfirmed value, $Res Function(_TestMergeEvent$MergeConfirmed) _then) = __$TestMergeEvent$MergeConfirmedCopyWithImpl;
@useResult
$Res call({
 String title
});




}
/// @nodoc
class __$TestMergeEvent$MergeConfirmedCopyWithImpl<$Res>
    implements _$TestMergeEvent$MergeConfirmedCopyWith<$Res> {
  __$TestMergeEvent$MergeConfirmedCopyWithImpl(this._self, this._then);

  final _TestMergeEvent$MergeConfirmed _self;
  final $Res Function(_TestMergeEvent$MergeConfirmed) _then;

/// Create a copy of TestMergeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? title = null,}) {
  return _then(_TestMergeEvent$MergeConfirmed(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$TestMergeState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TestMergeState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TestMergeState()';
}


}

/// @nodoc
class $TestMergeStateCopyWith<$Res>  {
$TestMergeStateCopyWith(TestMergeState _, $Res Function(TestMergeState) __);
}


/// Adds pattern-matching-related methods to [TestMergeState].
extension TestMergeStatePatterns on TestMergeState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( TestMergeState$Loading value)?  loading,TResult Function( TestMergeState$Loaded value)?  loaded,TResult Function( TestMergeState$Merging value)?  merging,TResult Function( TestMergeState$Success value)?  success,TResult Function( TestMergeState$Error value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case TestMergeState$Loading() when loading != null:
return loading(_that);case TestMergeState$Loaded() when loaded != null:
return loaded(_that);case TestMergeState$Merging() when merging != null:
return merging(_that);case TestMergeState$Success() when success != null:
return success(_that);case TestMergeState$Error() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( TestMergeState$Loading value)  loading,required TResult Function( TestMergeState$Loaded value)  loaded,required TResult Function( TestMergeState$Merging value)  merging,required TResult Function( TestMergeState$Success value)  success,required TResult Function( TestMergeState$Error value)  error,}){
final _that = this;
switch (_that) {
case TestMergeState$Loading():
return loading(_that);case TestMergeState$Loaded():
return loaded(_that);case TestMergeState$Merging():
return merging(_that);case TestMergeState$Success():
return success(_that);case TestMergeState$Error():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( TestMergeState$Loading value)?  loading,TResult? Function( TestMergeState$Loaded value)?  loaded,TResult? Function( TestMergeState$Merging value)?  merging,TResult? Function( TestMergeState$Success value)?  success,TResult? Function( TestMergeState$Error value)?  error,}){
final _that = this;
switch (_that) {
case TestMergeState$Loading() when loading != null:
return loading(_that);case TestMergeState$Loaded() when loaded != null:
return loaded(_that);case TestMergeState$Merging() when merging != null:
return merging(_that);case TestMergeState$Success() when success != null:
return success(_that);case TestMergeState$Error() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function( List<TestEntity> tests,  Set<String> selectedTestIds,  String initialTestId)?  loaded,TResult Function()?  merging,TResult Function( String newTestId)?  success,TResult Function( Failure failure)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case TestMergeState$Loading() when loading != null:
return loading();case TestMergeState$Loaded() when loaded != null:
return loaded(_that.tests,_that.selectedTestIds,_that.initialTestId);case TestMergeState$Merging() when merging != null:
return merging();case TestMergeState$Success() when success != null:
return success(_that.newTestId);case TestMergeState$Error() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function( List<TestEntity> tests,  Set<String> selectedTestIds,  String initialTestId)  loaded,required TResult Function()  merging,required TResult Function( String newTestId)  success,required TResult Function( Failure failure)  error,}) {final _that = this;
switch (_that) {
case TestMergeState$Loading():
return loading();case TestMergeState$Loaded():
return loaded(_that.tests,_that.selectedTestIds,_that.initialTestId);case TestMergeState$Merging():
return merging();case TestMergeState$Success():
return success(_that.newTestId);case TestMergeState$Error():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function( List<TestEntity> tests,  Set<String> selectedTestIds,  String initialTestId)?  loaded,TResult? Function()?  merging,TResult? Function( String newTestId)?  success,TResult? Function( Failure failure)?  error,}) {final _that = this;
switch (_that) {
case TestMergeState$Loading() when loading != null:
return loading();case TestMergeState$Loaded() when loaded != null:
return loaded(_that.tests,_that.selectedTestIds,_that.initialTestId);case TestMergeState$Merging() when merging != null:
return merging();case TestMergeState$Success() when success != null:
return success(_that.newTestId);case TestMergeState$Error() when error != null:
return error(_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class TestMergeState$Loading extends TestMergeState {
  const TestMergeState$Loading(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TestMergeState$Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TestMergeState.loading()';
}


}




/// @nodoc


class TestMergeState$Loaded extends TestMergeState {
  const TestMergeState$Loaded({required final  List<TestEntity> tests, required final  Set<String> selectedTestIds, required this.initialTestId}): _tests = tests,_selectedTestIds = selectedTestIds,super._();
  

 final  List<TestEntity> _tests;
 List<TestEntity> get tests {
  if (_tests is EqualUnmodifiableListView) return _tests;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tests);
}

 final  Set<String> _selectedTestIds;
 Set<String> get selectedTestIds {
  if (_selectedTestIds is EqualUnmodifiableSetView) return _selectedTestIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_selectedTestIds);
}

 final  String initialTestId;

/// Create a copy of TestMergeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TestMergeState$LoadedCopyWith<TestMergeState$Loaded> get copyWith => _$TestMergeState$LoadedCopyWithImpl<TestMergeState$Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TestMergeState$Loaded&&const DeepCollectionEquality().equals(other._tests, _tests)&&const DeepCollectionEquality().equals(other._selectedTestIds, _selectedTestIds)&&(identical(other.initialTestId, initialTestId) || other.initialTestId == initialTestId));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_tests),const DeepCollectionEquality().hash(_selectedTestIds),initialTestId);

@override
String toString() {
  return 'TestMergeState.loaded(tests: $tests, selectedTestIds: $selectedTestIds, initialTestId: $initialTestId)';
}


}

/// @nodoc
abstract mixin class $TestMergeState$LoadedCopyWith<$Res> implements $TestMergeStateCopyWith<$Res> {
  factory $TestMergeState$LoadedCopyWith(TestMergeState$Loaded value, $Res Function(TestMergeState$Loaded) _then) = _$TestMergeState$LoadedCopyWithImpl;
@useResult
$Res call({
 List<TestEntity> tests, Set<String> selectedTestIds, String initialTestId
});




}
/// @nodoc
class _$TestMergeState$LoadedCopyWithImpl<$Res>
    implements $TestMergeState$LoadedCopyWith<$Res> {
  _$TestMergeState$LoadedCopyWithImpl(this._self, this._then);

  final TestMergeState$Loaded _self;
  final $Res Function(TestMergeState$Loaded) _then;

/// Create a copy of TestMergeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tests = null,Object? selectedTestIds = null,Object? initialTestId = null,}) {
  return _then(TestMergeState$Loaded(
tests: null == tests ? _self._tests : tests // ignore: cast_nullable_to_non_nullable
as List<TestEntity>,selectedTestIds: null == selectedTestIds ? _self._selectedTestIds : selectedTestIds // ignore: cast_nullable_to_non_nullable
as Set<String>,initialTestId: null == initialTestId ? _self.initialTestId : initialTestId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class TestMergeState$Merging extends TestMergeState {
  const TestMergeState$Merging(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TestMergeState$Merging);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TestMergeState.merging()';
}


}




/// @nodoc


class TestMergeState$Success extends TestMergeState {
  const TestMergeState$Success({required this.newTestId}): super._();
  

 final  String newTestId;

/// Create a copy of TestMergeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TestMergeState$SuccessCopyWith<TestMergeState$Success> get copyWith => _$TestMergeState$SuccessCopyWithImpl<TestMergeState$Success>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TestMergeState$Success&&(identical(other.newTestId, newTestId) || other.newTestId == newTestId));
}


@override
int get hashCode => Object.hash(runtimeType,newTestId);

@override
String toString() {
  return 'TestMergeState.success(newTestId: $newTestId)';
}


}

/// @nodoc
abstract mixin class $TestMergeState$SuccessCopyWith<$Res> implements $TestMergeStateCopyWith<$Res> {
  factory $TestMergeState$SuccessCopyWith(TestMergeState$Success value, $Res Function(TestMergeState$Success) _then) = _$TestMergeState$SuccessCopyWithImpl;
@useResult
$Res call({
 String newTestId
});




}
/// @nodoc
class _$TestMergeState$SuccessCopyWithImpl<$Res>
    implements $TestMergeState$SuccessCopyWith<$Res> {
  _$TestMergeState$SuccessCopyWithImpl(this._self, this._then);

  final TestMergeState$Success _self;
  final $Res Function(TestMergeState$Success) _then;

/// Create a copy of TestMergeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? newTestId = null,}) {
  return _then(TestMergeState$Success(
newTestId: null == newTestId ? _self.newTestId : newTestId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class TestMergeState$Error extends TestMergeState {
  const TestMergeState$Error({required this.failure}): super._();
  

 final  Failure failure;

/// Create a copy of TestMergeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TestMergeState$ErrorCopyWith<TestMergeState$Error> get copyWith => _$TestMergeState$ErrorCopyWithImpl<TestMergeState$Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TestMergeState$Error&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,failure);

@override
String toString() {
  return 'TestMergeState.error(failure: $failure)';
}


}

/// @nodoc
abstract mixin class $TestMergeState$ErrorCopyWith<$Res> implements $TestMergeStateCopyWith<$Res> {
  factory $TestMergeState$ErrorCopyWith(TestMergeState$Error value, $Res Function(TestMergeState$Error) _then) = _$TestMergeState$ErrorCopyWithImpl;
@useResult
$Res call({
 Failure failure
});




}
/// @nodoc
class _$TestMergeState$ErrorCopyWithImpl<$Res>
    implements $TestMergeState$ErrorCopyWith<$Res> {
  _$TestMergeState$ErrorCopyWithImpl(this._self, this._then);

  final TestMergeState$Error _self;
  final $Res Function(TestMergeState$Error) _then;

/// Create a copy of TestMergeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(TestMergeState$Error(
failure: null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}


}

// dart format on
