// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'groups_list_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GroupsListEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GroupsListEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GroupsListEvent()';
}


}

/// @nodoc
class $GroupsListEventCopyWith<$Res>  {
$GroupsListEventCopyWith(GroupsListEvent _, $Res Function(GroupsListEvent) __);
}


/// Adds pattern-matching-related methods to [GroupsListEvent].
extension GroupsListEventPatterns on GroupsListEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _GroupsListEvent$Started value)?  started,TResult Function( _GroupsListEvent$GroupAdded value)?  groupAdded,TResult Function( _GroupsListEvent$GroupDeleted value)?  groupDeleted,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GroupsListEvent$Started() when started != null:
return started(_that);case _GroupsListEvent$GroupAdded() when groupAdded != null:
return groupAdded(_that);case _GroupsListEvent$GroupDeleted() when groupDeleted != null:
return groupDeleted(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _GroupsListEvent$Started value)  started,required TResult Function( _GroupsListEvent$GroupAdded value)  groupAdded,required TResult Function( _GroupsListEvent$GroupDeleted value)  groupDeleted,}){
final _that = this;
switch (_that) {
case _GroupsListEvent$Started():
return started(_that);case _GroupsListEvent$GroupAdded():
return groupAdded(_that);case _GroupsListEvent$GroupDeleted():
return groupDeleted(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _GroupsListEvent$Started value)?  started,TResult? Function( _GroupsListEvent$GroupAdded value)?  groupAdded,TResult? Function( _GroupsListEvent$GroupDeleted value)?  groupDeleted,}){
final _that = this;
switch (_that) {
case _GroupsListEvent$Started() when started != null:
return started(_that);case _GroupsListEvent$GroupAdded() when groupAdded != null:
return groupAdded(_that);case _GroupsListEvent$GroupDeleted() when groupDeleted != null:
return groupDeleted(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( String title)?  groupAdded,TResult Function( String groupId)?  groupDeleted,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GroupsListEvent$Started() when started != null:
return started();case _GroupsListEvent$GroupAdded() when groupAdded != null:
return groupAdded(_that.title);case _GroupsListEvent$GroupDeleted() when groupDeleted != null:
return groupDeleted(_that.groupId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( String title)  groupAdded,required TResult Function( String groupId)  groupDeleted,}) {final _that = this;
switch (_that) {
case _GroupsListEvent$Started():
return started();case _GroupsListEvent$GroupAdded():
return groupAdded(_that.title);case _GroupsListEvent$GroupDeleted():
return groupDeleted(_that.groupId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( String title)?  groupAdded,TResult? Function( String groupId)?  groupDeleted,}) {final _that = this;
switch (_that) {
case _GroupsListEvent$Started() when started != null:
return started();case _GroupsListEvent$GroupAdded() when groupAdded != null:
return groupAdded(_that.title);case _GroupsListEvent$GroupDeleted() when groupDeleted != null:
return groupDeleted(_that.groupId);case _:
  return null;

}
}

}

/// @nodoc


class _GroupsListEvent$Started implements GroupsListEvent {
  const _GroupsListEvent$Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GroupsListEvent$Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GroupsListEvent.started()';
}


}




/// @nodoc


class _GroupsListEvent$GroupAdded implements GroupsListEvent {
  const _GroupsListEvent$GroupAdded({required this.title});
  

 final  String title;

/// Create a copy of GroupsListEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GroupsListEvent$GroupAddedCopyWith<_GroupsListEvent$GroupAdded> get copyWith => __$GroupsListEvent$GroupAddedCopyWithImpl<_GroupsListEvent$GroupAdded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GroupsListEvent$GroupAdded&&(identical(other.title, title) || other.title == title));
}


@override
int get hashCode => Object.hash(runtimeType,title);

@override
String toString() {
  return 'GroupsListEvent.groupAdded(title: $title)';
}


}

/// @nodoc
abstract mixin class _$GroupsListEvent$GroupAddedCopyWith<$Res> implements $GroupsListEventCopyWith<$Res> {
  factory _$GroupsListEvent$GroupAddedCopyWith(_GroupsListEvent$GroupAdded value, $Res Function(_GroupsListEvent$GroupAdded) _then) = __$GroupsListEvent$GroupAddedCopyWithImpl;
@useResult
$Res call({
 String title
});




}
/// @nodoc
class __$GroupsListEvent$GroupAddedCopyWithImpl<$Res>
    implements _$GroupsListEvent$GroupAddedCopyWith<$Res> {
  __$GroupsListEvent$GroupAddedCopyWithImpl(this._self, this._then);

  final _GroupsListEvent$GroupAdded _self;
  final $Res Function(_GroupsListEvent$GroupAdded) _then;

/// Create a copy of GroupsListEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? title = null,}) {
  return _then(_GroupsListEvent$GroupAdded(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _GroupsListEvent$GroupDeleted implements GroupsListEvent {
  const _GroupsListEvent$GroupDeleted({required this.groupId});
  

 final  String groupId;

/// Create a copy of GroupsListEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GroupsListEvent$GroupDeletedCopyWith<_GroupsListEvent$GroupDeleted> get copyWith => __$GroupsListEvent$GroupDeletedCopyWithImpl<_GroupsListEvent$GroupDeleted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GroupsListEvent$GroupDeleted&&(identical(other.groupId, groupId) || other.groupId == groupId));
}


@override
int get hashCode => Object.hash(runtimeType,groupId);

@override
String toString() {
  return 'GroupsListEvent.groupDeleted(groupId: $groupId)';
}


}

/// @nodoc
abstract mixin class _$GroupsListEvent$GroupDeletedCopyWith<$Res> implements $GroupsListEventCopyWith<$Res> {
  factory _$GroupsListEvent$GroupDeletedCopyWith(_GroupsListEvent$GroupDeleted value, $Res Function(_GroupsListEvent$GroupDeleted) _then) = __$GroupsListEvent$GroupDeletedCopyWithImpl;
@useResult
$Res call({
 String groupId
});




}
/// @nodoc
class __$GroupsListEvent$GroupDeletedCopyWithImpl<$Res>
    implements _$GroupsListEvent$GroupDeletedCopyWith<$Res> {
  __$GroupsListEvent$GroupDeletedCopyWithImpl(this._self, this._then);

  final _GroupsListEvent$GroupDeleted _self;
  final $Res Function(_GroupsListEvent$GroupDeleted) _then;

/// Create a copy of GroupsListEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? groupId = null,}) {
  return _then(_GroupsListEvent$GroupDeleted(
groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$GroupsListState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GroupsListState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GroupsListState()';
}


}

/// @nodoc
class $GroupsListStateCopyWith<$Res>  {
$GroupsListStateCopyWith(GroupsListState _, $Res Function(GroupsListState) __);
}


/// Adds pattern-matching-related methods to [GroupsListState].
extension GroupsListStatePatterns on GroupsListState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( GroupsListState$Loading value)?  loading,TResult Function( GroupsListState$Loaded value)?  loaded,TResult Function( GroupsListState$Error value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case GroupsListState$Loading() when loading != null:
return loading(_that);case GroupsListState$Loaded() when loaded != null:
return loaded(_that);case GroupsListState$Error() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( GroupsListState$Loading value)  loading,required TResult Function( GroupsListState$Loaded value)  loaded,required TResult Function( GroupsListState$Error value)  error,}){
final _that = this;
switch (_that) {
case GroupsListState$Loading():
return loading(_that);case GroupsListState$Loaded():
return loaded(_that);case GroupsListState$Error():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( GroupsListState$Loading value)?  loading,TResult? Function( GroupsListState$Loaded value)?  loaded,TResult? Function( GroupsListState$Error value)?  error,}){
final _that = this;
switch (_that) {
case GroupsListState$Loading() when loading != null:
return loading(_that);case GroupsListState$Loaded() when loaded != null:
return loaded(_that);case GroupsListState$Error() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function( List<TestGroupEntity> groups)?  loaded,TResult Function( Failure failure)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case GroupsListState$Loading() when loading != null:
return loading();case GroupsListState$Loaded() when loaded != null:
return loaded(_that.groups);case GroupsListState$Error() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function( List<TestGroupEntity> groups)  loaded,required TResult Function( Failure failure)  error,}) {final _that = this;
switch (_that) {
case GroupsListState$Loading():
return loading();case GroupsListState$Loaded():
return loaded(_that.groups);case GroupsListState$Error():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function( List<TestGroupEntity> groups)?  loaded,TResult? Function( Failure failure)?  error,}) {final _that = this;
switch (_that) {
case GroupsListState$Loading() when loading != null:
return loading();case GroupsListState$Loaded() when loaded != null:
return loaded(_that.groups);case GroupsListState$Error() when error != null:
return error(_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class GroupsListState$Loading extends GroupsListState {
  const GroupsListState$Loading(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GroupsListState$Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GroupsListState.loading()';
}


}




/// @nodoc


class GroupsListState$Loaded extends GroupsListState {
  const GroupsListState$Loaded({required final  List<TestGroupEntity> groups}): _groups = groups,super._();
  

 final  List<TestGroupEntity> _groups;
 List<TestGroupEntity> get groups {
  if (_groups is EqualUnmodifiableListView) return _groups;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_groups);
}


/// Create a copy of GroupsListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GroupsListState$LoadedCopyWith<GroupsListState$Loaded> get copyWith => _$GroupsListState$LoadedCopyWithImpl<GroupsListState$Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GroupsListState$Loaded&&const DeepCollectionEquality().equals(other._groups, _groups));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_groups));

@override
String toString() {
  return 'GroupsListState.loaded(groups: $groups)';
}


}

/// @nodoc
abstract mixin class $GroupsListState$LoadedCopyWith<$Res> implements $GroupsListStateCopyWith<$Res> {
  factory $GroupsListState$LoadedCopyWith(GroupsListState$Loaded value, $Res Function(GroupsListState$Loaded) _then) = _$GroupsListState$LoadedCopyWithImpl;
@useResult
$Res call({
 List<TestGroupEntity> groups
});




}
/// @nodoc
class _$GroupsListState$LoadedCopyWithImpl<$Res>
    implements $GroupsListState$LoadedCopyWith<$Res> {
  _$GroupsListState$LoadedCopyWithImpl(this._self, this._then);

  final GroupsListState$Loaded _self;
  final $Res Function(GroupsListState$Loaded) _then;

/// Create a copy of GroupsListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? groups = null,}) {
  return _then(GroupsListState$Loaded(
groups: null == groups ? _self._groups : groups // ignore: cast_nullable_to_non_nullable
as List<TestGroupEntity>,
  ));
}


}

/// @nodoc


class GroupsListState$Error extends GroupsListState {
  const GroupsListState$Error({required this.failure}): super._();
  

 final  Failure failure;

/// Create a copy of GroupsListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GroupsListState$ErrorCopyWith<GroupsListState$Error> get copyWith => _$GroupsListState$ErrorCopyWithImpl<GroupsListState$Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GroupsListState$Error&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,failure);

@override
String toString() {
  return 'GroupsListState.error(failure: $failure)';
}


}

/// @nodoc
abstract mixin class $GroupsListState$ErrorCopyWith<$Res> implements $GroupsListStateCopyWith<$Res> {
  factory $GroupsListState$ErrorCopyWith(GroupsListState$Error value, $Res Function(GroupsListState$Error) _then) = _$GroupsListState$ErrorCopyWithImpl;
@useResult
$Res call({
 Failure failure
});




}
/// @nodoc
class _$GroupsListState$ErrorCopyWithImpl<$Res>
    implements $GroupsListState$ErrorCopyWith<$Res> {
  _$GroupsListState$ErrorCopyWithImpl(this._self, this._then);

  final GroupsListState$Error _self;
  final $Res Function(GroupsListState$Error) _then;

/// Create a copy of GroupsListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(GroupsListState$Error(
failure: null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}


}

// dart format on
