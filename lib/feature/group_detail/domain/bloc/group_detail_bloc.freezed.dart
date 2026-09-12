// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group_detail_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GroupDetailEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GroupDetailEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GroupDetailEvent()';
}


}

/// @nodoc
class $GroupDetailEventCopyWith<$Res>  {
$GroupDetailEventCopyWith(GroupDetailEvent _, $Res Function(GroupDetailEvent) __);
}


/// Adds pattern-matching-related methods to [GroupDetailEvent].
extension GroupDetailEventPatterns on GroupDetailEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _GroupDetailEvent$Started value)?  started,TResult Function( _GroupDetailEvent$TestAdded value)?  testAdded,TResult Function( _GroupDetailEvent$TestRemoved value)?  testRemoved,TResult Function( _GroupDetailEvent$TitleUpdated value)?  titleUpdated,TResult Function( _GroupDetailEvent$TestGroupsUpdated value)?  testGroupsUpdated,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GroupDetailEvent$Started() when started != null:
return started(_that);case _GroupDetailEvent$TestAdded() when testAdded != null:
return testAdded(_that);case _GroupDetailEvent$TestRemoved() when testRemoved != null:
return testRemoved(_that);case _GroupDetailEvent$TitleUpdated() when titleUpdated != null:
return titleUpdated(_that);case _GroupDetailEvent$TestGroupsUpdated() when testGroupsUpdated != null:
return testGroupsUpdated(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _GroupDetailEvent$Started value)  started,required TResult Function( _GroupDetailEvent$TestAdded value)  testAdded,required TResult Function( _GroupDetailEvent$TestRemoved value)  testRemoved,required TResult Function( _GroupDetailEvent$TitleUpdated value)  titleUpdated,required TResult Function( _GroupDetailEvent$TestGroupsUpdated value)  testGroupsUpdated,}){
final _that = this;
switch (_that) {
case _GroupDetailEvent$Started():
return started(_that);case _GroupDetailEvent$TestAdded():
return testAdded(_that);case _GroupDetailEvent$TestRemoved():
return testRemoved(_that);case _GroupDetailEvent$TitleUpdated():
return titleUpdated(_that);case _GroupDetailEvent$TestGroupsUpdated():
return testGroupsUpdated(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _GroupDetailEvent$Started value)?  started,TResult? Function( _GroupDetailEvent$TestAdded value)?  testAdded,TResult? Function( _GroupDetailEvent$TestRemoved value)?  testRemoved,TResult? Function( _GroupDetailEvent$TitleUpdated value)?  titleUpdated,TResult? Function( _GroupDetailEvent$TestGroupsUpdated value)?  testGroupsUpdated,}){
final _that = this;
switch (_that) {
case _GroupDetailEvent$Started() when started != null:
return started(_that);case _GroupDetailEvent$TestAdded() when testAdded != null:
return testAdded(_that);case _GroupDetailEvent$TestRemoved() when testRemoved != null:
return testRemoved(_that);case _GroupDetailEvent$TitleUpdated() when titleUpdated != null:
return titleUpdated(_that);case _GroupDetailEvent$TestGroupsUpdated() when testGroupsUpdated != null:
return testGroupsUpdated(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String groupId)?  started,TResult Function( String title,  String? description)?  testAdded,TResult Function( String testId)?  testRemoved,TResult Function( String title)?  titleUpdated,TResult Function( String testId,  List<String> groupIds)?  testGroupsUpdated,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GroupDetailEvent$Started() when started != null:
return started(_that.groupId);case _GroupDetailEvent$TestAdded() when testAdded != null:
return testAdded(_that.title,_that.description);case _GroupDetailEvent$TestRemoved() when testRemoved != null:
return testRemoved(_that.testId);case _GroupDetailEvent$TitleUpdated() when titleUpdated != null:
return titleUpdated(_that.title);case _GroupDetailEvent$TestGroupsUpdated() when testGroupsUpdated != null:
return testGroupsUpdated(_that.testId,_that.groupIds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String groupId)  started,required TResult Function( String title,  String? description)  testAdded,required TResult Function( String testId)  testRemoved,required TResult Function( String title)  titleUpdated,required TResult Function( String testId,  List<String> groupIds)  testGroupsUpdated,}) {final _that = this;
switch (_that) {
case _GroupDetailEvent$Started():
return started(_that.groupId);case _GroupDetailEvent$TestAdded():
return testAdded(_that.title,_that.description);case _GroupDetailEvent$TestRemoved():
return testRemoved(_that.testId);case _GroupDetailEvent$TitleUpdated():
return titleUpdated(_that.title);case _GroupDetailEvent$TestGroupsUpdated():
return testGroupsUpdated(_that.testId,_that.groupIds);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String groupId)?  started,TResult? Function( String title,  String? description)?  testAdded,TResult? Function( String testId)?  testRemoved,TResult? Function( String title)?  titleUpdated,TResult? Function( String testId,  List<String> groupIds)?  testGroupsUpdated,}) {final _that = this;
switch (_that) {
case _GroupDetailEvent$Started() when started != null:
return started(_that.groupId);case _GroupDetailEvent$TestAdded() when testAdded != null:
return testAdded(_that.title,_that.description);case _GroupDetailEvent$TestRemoved() when testRemoved != null:
return testRemoved(_that.testId);case _GroupDetailEvent$TitleUpdated() when titleUpdated != null:
return titleUpdated(_that.title);case _GroupDetailEvent$TestGroupsUpdated() when testGroupsUpdated != null:
return testGroupsUpdated(_that.testId,_that.groupIds);case _:
  return null;

}
}

}

/// @nodoc


class _GroupDetailEvent$Started implements GroupDetailEvent {
  const _GroupDetailEvent$Started({required this.groupId});
  

 final  String groupId;

/// Create a copy of GroupDetailEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GroupDetailEvent$StartedCopyWith<_GroupDetailEvent$Started> get copyWith => __$GroupDetailEvent$StartedCopyWithImpl<_GroupDetailEvent$Started>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GroupDetailEvent$Started&&(identical(other.groupId, groupId) || other.groupId == groupId));
}


@override
int get hashCode => Object.hash(runtimeType,groupId);

@override
String toString() {
  return 'GroupDetailEvent.started(groupId: $groupId)';
}


}

/// @nodoc
abstract mixin class _$GroupDetailEvent$StartedCopyWith<$Res> implements $GroupDetailEventCopyWith<$Res> {
  factory _$GroupDetailEvent$StartedCopyWith(_GroupDetailEvent$Started value, $Res Function(_GroupDetailEvent$Started) _then) = __$GroupDetailEvent$StartedCopyWithImpl;
@useResult
$Res call({
 String groupId
});




}
/// @nodoc
class __$GroupDetailEvent$StartedCopyWithImpl<$Res>
    implements _$GroupDetailEvent$StartedCopyWith<$Res> {
  __$GroupDetailEvent$StartedCopyWithImpl(this._self, this._then);

  final _GroupDetailEvent$Started _self;
  final $Res Function(_GroupDetailEvent$Started) _then;

/// Create a copy of GroupDetailEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? groupId = null,}) {
  return _then(_GroupDetailEvent$Started(
groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _GroupDetailEvent$TestAdded implements GroupDetailEvent {
  const _GroupDetailEvent$TestAdded({required this.title, this.description});
  

 final  String title;
 final  String? description;

/// Create a copy of GroupDetailEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GroupDetailEvent$TestAddedCopyWith<_GroupDetailEvent$TestAdded> get copyWith => __$GroupDetailEvent$TestAddedCopyWithImpl<_GroupDetailEvent$TestAdded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GroupDetailEvent$TestAdded&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode => Object.hash(runtimeType,title,description);

@override
String toString() {
  return 'GroupDetailEvent.testAdded(title: $title, description: $description)';
}


}

/// @nodoc
abstract mixin class _$GroupDetailEvent$TestAddedCopyWith<$Res> implements $GroupDetailEventCopyWith<$Res> {
  factory _$GroupDetailEvent$TestAddedCopyWith(_GroupDetailEvent$TestAdded value, $Res Function(_GroupDetailEvent$TestAdded) _then) = __$GroupDetailEvent$TestAddedCopyWithImpl;
@useResult
$Res call({
 String title, String? description
});




}
/// @nodoc
class __$GroupDetailEvent$TestAddedCopyWithImpl<$Res>
    implements _$GroupDetailEvent$TestAddedCopyWith<$Res> {
  __$GroupDetailEvent$TestAddedCopyWithImpl(this._self, this._then);

  final _GroupDetailEvent$TestAdded _self;
  final $Res Function(_GroupDetailEvent$TestAdded) _then;

/// Create a copy of GroupDetailEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? title = null,Object? description = freezed,}) {
  return _then(_GroupDetailEvent$TestAdded(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _GroupDetailEvent$TestRemoved implements GroupDetailEvent {
  const _GroupDetailEvent$TestRemoved({required this.testId});
  

 final  String testId;

/// Create a copy of GroupDetailEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GroupDetailEvent$TestRemovedCopyWith<_GroupDetailEvent$TestRemoved> get copyWith => __$GroupDetailEvent$TestRemovedCopyWithImpl<_GroupDetailEvent$TestRemoved>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GroupDetailEvent$TestRemoved&&(identical(other.testId, testId) || other.testId == testId));
}


@override
int get hashCode => Object.hash(runtimeType,testId);

@override
String toString() {
  return 'GroupDetailEvent.testRemoved(testId: $testId)';
}


}

/// @nodoc
abstract mixin class _$GroupDetailEvent$TestRemovedCopyWith<$Res> implements $GroupDetailEventCopyWith<$Res> {
  factory _$GroupDetailEvent$TestRemovedCopyWith(_GroupDetailEvent$TestRemoved value, $Res Function(_GroupDetailEvent$TestRemoved) _then) = __$GroupDetailEvent$TestRemovedCopyWithImpl;
@useResult
$Res call({
 String testId
});




}
/// @nodoc
class __$GroupDetailEvent$TestRemovedCopyWithImpl<$Res>
    implements _$GroupDetailEvent$TestRemovedCopyWith<$Res> {
  __$GroupDetailEvent$TestRemovedCopyWithImpl(this._self, this._then);

  final _GroupDetailEvent$TestRemoved _self;
  final $Res Function(_GroupDetailEvent$TestRemoved) _then;

/// Create a copy of GroupDetailEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? testId = null,}) {
  return _then(_GroupDetailEvent$TestRemoved(
testId: null == testId ? _self.testId : testId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _GroupDetailEvent$TitleUpdated implements GroupDetailEvent {
  const _GroupDetailEvent$TitleUpdated({required this.title});
  

 final  String title;

/// Create a copy of GroupDetailEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GroupDetailEvent$TitleUpdatedCopyWith<_GroupDetailEvent$TitleUpdated> get copyWith => __$GroupDetailEvent$TitleUpdatedCopyWithImpl<_GroupDetailEvent$TitleUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GroupDetailEvent$TitleUpdated&&(identical(other.title, title) || other.title == title));
}


@override
int get hashCode => Object.hash(runtimeType,title);

@override
String toString() {
  return 'GroupDetailEvent.titleUpdated(title: $title)';
}


}

/// @nodoc
abstract mixin class _$GroupDetailEvent$TitleUpdatedCopyWith<$Res> implements $GroupDetailEventCopyWith<$Res> {
  factory _$GroupDetailEvent$TitleUpdatedCopyWith(_GroupDetailEvent$TitleUpdated value, $Res Function(_GroupDetailEvent$TitleUpdated) _then) = __$GroupDetailEvent$TitleUpdatedCopyWithImpl;
@useResult
$Res call({
 String title
});




}
/// @nodoc
class __$GroupDetailEvent$TitleUpdatedCopyWithImpl<$Res>
    implements _$GroupDetailEvent$TitleUpdatedCopyWith<$Res> {
  __$GroupDetailEvent$TitleUpdatedCopyWithImpl(this._self, this._then);

  final _GroupDetailEvent$TitleUpdated _self;
  final $Res Function(_GroupDetailEvent$TitleUpdated) _then;

/// Create a copy of GroupDetailEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? title = null,}) {
  return _then(_GroupDetailEvent$TitleUpdated(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _GroupDetailEvent$TestGroupsUpdated implements GroupDetailEvent {
  const _GroupDetailEvent$TestGroupsUpdated({required this.testId, required final  List<String> groupIds}): _groupIds = groupIds;
  

 final  String testId;
 final  List<String> _groupIds;
 List<String> get groupIds {
  if (_groupIds is EqualUnmodifiableListView) return _groupIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_groupIds);
}


/// Create a copy of GroupDetailEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GroupDetailEvent$TestGroupsUpdatedCopyWith<_GroupDetailEvent$TestGroupsUpdated> get copyWith => __$GroupDetailEvent$TestGroupsUpdatedCopyWithImpl<_GroupDetailEvent$TestGroupsUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GroupDetailEvent$TestGroupsUpdated&&(identical(other.testId, testId) || other.testId == testId)&&const DeepCollectionEquality().equals(other._groupIds, _groupIds));
}


@override
int get hashCode => Object.hash(runtimeType,testId,const DeepCollectionEquality().hash(_groupIds));

@override
String toString() {
  return 'GroupDetailEvent.testGroupsUpdated(testId: $testId, groupIds: $groupIds)';
}


}

/// @nodoc
abstract mixin class _$GroupDetailEvent$TestGroupsUpdatedCopyWith<$Res> implements $GroupDetailEventCopyWith<$Res> {
  factory _$GroupDetailEvent$TestGroupsUpdatedCopyWith(_GroupDetailEvent$TestGroupsUpdated value, $Res Function(_GroupDetailEvent$TestGroupsUpdated) _then) = __$GroupDetailEvent$TestGroupsUpdatedCopyWithImpl;
@useResult
$Res call({
 String testId, List<String> groupIds
});




}
/// @nodoc
class __$GroupDetailEvent$TestGroupsUpdatedCopyWithImpl<$Res>
    implements _$GroupDetailEvent$TestGroupsUpdatedCopyWith<$Res> {
  __$GroupDetailEvent$TestGroupsUpdatedCopyWithImpl(this._self, this._then);

  final _GroupDetailEvent$TestGroupsUpdated _self;
  final $Res Function(_GroupDetailEvent$TestGroupsUpdated) _then;

/// Create a copy of GroupDetailEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? testId = null,Object? groupIds = null,}) {
  return _then(_GroupDetailEvent$TestGroupsUpdated(
testId: null == testId ? _self.testId : testId // ignore: cast_nullable_to_non_nullable
as String,groupIds: null == groupIds ? _self._groupIds : groupIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

/// @nodoc
mixin _$GroupDetailState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GroupDetailState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GroupDetailState()';
}


}

/// @nodoc
class $GroupDetailStateCopyWith<$Res>  {
$GroupDetailStateCopyWith(GroupDetailState _, $Res Function(GroupDetailState) __);
}


/// Adds pattern-matching-related methods to [GroupDetailState].
extension GroupDetailStatePatterns on GroupDetailState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( GroupDetailState$Loading value)?  loading,TResult Function( GroupDetailState$Loaded value)?  loaded,TResult Function( GroupDetailState$Error value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case GroupDetailState$Loading() when loading != null:
return loading(_that);case GroupDetailState$Loaded() when loaded != null:
return loaded(_that);case GroupDetailState$Error() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( GroupDetailState$Loading value)  loading,required TResult Function( GroupDetailState$Loaded value)  loaded,required TResult Function( GroupDetailState$Error value)  error,}){
final _that = this;
switch (_that) {
case GroupDetailState$Loading():
return loading(_that);case GroupDetailState$Loaded():
return loaded(_that);case GroupDetailState$Error():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( GroupDetailState$Loading value)?  loading,TResult? Function( GroupDetailState$Loaded value)?  loaded,TResult? Function( GroupDetailState$Error value)?  error,}){
final _that = this;
switch (_that) {
case GroupDetailState$Loading() when loading != null:
return loading(_that);case GroupDetailState$Loaded() when loaded != null:
return loaded(_that);case GroupDetailState$Error() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function( TestGroupEntity group,  List<TestEntity> tests,  List<TestGroupEntity> allGroups,  Map<String, List<String>> groupIdsByTest)?  loaded,TResult Function( Failure failure)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case GroupDetailState$Loading() when loading != null:
return loading();case GroupDetailState$Loaded() when loaded != null:
return loaded(_that.group,_that.tests,_that.allGroups,_that.groupIdsByTest);case GroupDetailState$Error() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function( TestGroupEntity group,  List<TestEntity> tests,  List<TestGroupEntity> allGroups,  Map<String, List<String>> groupIdsByTest)  loaded,required TResult Function( Failure failure)  error,}) {final _that = this;
switch (_that) {
case GroupDetailState$Loading():
return loading();case GroupDetailState$Loaded():
return loaded(_that.group,_that.tests,_that.allGroups,_that.groupIdsByTest);case GroupDetailState$Error():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function( TestGroupEntity group,  List<TestEntity> tests,  List<TestGroupEntity> allGroups,  Map<String, List<String>> groupIdsByTest)?  loaded,TResult? Function( Failure failure)?  error,}) {final _that = this;
switch (_that) {
case GroupDetailState$Loading() when loading != null:
return loading();case GroupDetailState$Loaded() when loaded != null:
return loaded(_that.group,_that.tests,_that.allGroups,_that.groupIdsByTest);case GroupDetailState$Error() when error != null:
return error(_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class GroupDetailState$Loading extends GroupDetailState {
  const GroupDetailState$Loading(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GroupDetailState$Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GroupDetailState.loading()';
}


}




/// @nodoc


class GroupDetailState$Loaded extends GroupDetailState {
  const GroupDetailState$Loaded({required this.group, required final  List<TestEntity> tests, required final  List<TestGroupEntity> allGroups, required final  Map<String, List<String>> groupIdsByTest}): _tests = tests,_allGroups = allGroups,_groupIdsByTest = groupIdsByTest,super._();
  

 final  TestGroupEntity group;
 final  List<TestEntity> _tests;
 List<TestEntity> get tests {
  if (_tests is EqualUnmodifiableListView) return _tests;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tests);
}

/// Все группы приложения — нужны диалогу «добавить в группу».
 final  List<TestGroupEntity> _allGroups;
/// Все группы приложения — нужны диалогу «добавить в группу».
 List<TestGroupEntity> get allGroups {
  if (_allGroups is EqualUnmodifiableListView) return _allGroups;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_allGroups);
}

/// Привязки «тест -> id групп». Держим в состоянии, чтобы UI не ходил
/// в репозиторий за ними при открытии диалогов.
 final  Map<String, List<String>> _groupIdsByTest;
/// Привязки «тест -> id групп». Держим в состоянии, чтобы UI не ходил
/// в репозиторий за ними при открытии диалогов.
 Map<String, List<String>> get groupIdsByTest {
  if (_groupIdsByTest is EqualUnmodifiableMapView) return _groupIdsByTest;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_groupIdsByTest);
}


/// Create a copy of GroupDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GroupDetailState$LoadedCopyWith<GroupDetailState$Loaded> get copyWith => _$GroupDetailState$LoadedCopyWithImpl<GroupDetailState$Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GroupDetailState$Loaded&&(identical(other.group, group) || other.group == group)&&const DeepCollectionEquality().equals(other._tests, _tests)&&const DeepCollectionEquality().equals(other._allGroups, _allGroups)&&const DeepCollectionEquality().equals(other._groupIdsByTest, _groupIdsByTest));
}


@override
int get hashCode => Object.hash(runtimeType,group,const DeepCollectionEquality().hash(_tests),const DeepCollectionEquality().hash(_allGroups),const DeepCollectionEquality().hash(_groupIdsByTest));

@override
String toString() {
  return 'GroupDetailState.loaded(group: $group, tests: $tests, allGroups: $allGroups, groupIdsByTest: $groupIdsByTest)';
}


}

/// @nodoc
abstract mixin class $GroupDetailState$LoadedCopyWith<$Res> implements $GroupDetailStateCopyWith<$Res> {
  factory $GroupDetailState$LoadedCopyWith(GroupDetailState$Loaded value, $Res Function(GroupDetailState$Loaded) _then) = _$GroupDetailState$LoadedCopyWithImpl;
@useResult
$Res call({
 TestGroupEntity group, List<TestEntity> tests, List<TestGroupEntity> allGroups, Map<String, List<String>> groupIdsByTest
});


$TestGroupEntityCopyWith<$Res> get group;

}
/// @nodoc
class _$GroupDetailState$LoadedCopyWithImpl<$Res>
    implements $GroupDetailState$LoadedCopyWith<$Res> {
  _$GroupDetailState$LoadedCopyWithImpl(this._self, this._then);

  final GroupDetailState$Loaded _self;
  final $Res Function(GroupDetailState$Loaded) _then;

/// Create a copy of GroupDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? group = null,Object? tests = null,Object? allGroups = null,Object? groupIdsByTest = null,}) {
  return _then(GroupDetailState$Loaded(
group: null == group ? _self.group : group // ignore: cast_nullable_to_non_nullable
as TestGroupEntity,tests: null == tests ? _self._tests : tests // ignore: cast_nullable_to_non_nullable
as List<TestEntity>,allGroups: null == allGroups ? _self._allGroups : allGroups // ignore: cast_nullable_to_non_nullable
as List<TestGroupEntity>,groupIdsByTest: null == groupIdsByTest ? _self._groupIdsByTest : groupIdsByTest // ignore: cast_nullable_to_non_nullable
as Map<String, List<String>>,
  ));
}

/// Create a copy of GroupDetailState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TestGroupEntityCopyWith<$Res> get group {
  
  return $TestGroupEntityCopyWith<$Res>(_self.group, (value) {
    return _then(_self.copyWith(group: value));
  });
}
}

/// @nodoc


class GroupDetailState$Error extends GroupDetailState {
  const GroupDetailState$Error({required this.failure}): super._();
  

 final  Failure failure;

/// Create a copy of GroupDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GroupDetailState$ErrorCopyWith<GroupDetailState$Error> get copyWith => _$GroupDetailState$ErrorCopyWithImpl<GroupDetailState$Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GroupDetailState$Error&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,failure);

@override
String toString() {
  return 'GroupDetailState.error(failure: $failure)';
}


}

/// @nodoc
abstract mixin class $GroupDetailState$ErrorCopyWith<$Res> implements $GroupDetailStateCopyWith<$Res> {
  factory $GroupDetailState$ErrorCopyWith(GroupDetailState$Error value, $Res Function(GroupDetailState$Error) _then) = _$GroupDetailState$ErrorCopyWithImpl;
@useResult
$Res call({
 Failure failure
});




}
/// @nodoc
class _$GroupDetailState$ErrorCopyWithImpl<$Res>
    implements $GroupDetailState$ErrorCopyWith<$Res> {
  _$GroupDetailState$ErrorCopyWithImpl(this._self, this._then);

  final GroupDetailState$Error _self;
  final $Res Function(GroupDetailState$Error) _then;

/// Create a copy of GroupDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(GroupDetailState$Error(
failure: null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}


}

// dart format on
