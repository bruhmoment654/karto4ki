// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sync_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SyncEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SyncEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SyncEvent()';
}


}

/// @nodoc
class $SyncEventCopyWith<$Res>  {
$SyncEventCopyWith(SyncEvent _, $Res Function(SyncEvent) __);
}


/// Adds pattern-matching-related methods to [SyncEvent].
extension SyncEventPatterns on SyncEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _SyncEvent$Started value)?  started,TResult Function( _SyncEvent$Requested value)?  requested,TResult Function( _SyncEvent$LocalMutation value)?  localMutation,TResult Function( _SyncEvent$ConnectivityChanged value)?  connectivityChanged,TResult Function( _SyncEvent$AuthChanged value)?  authChanged,TResult Function( _SyncEvent$ConflictsShown value)?  conflictsShown,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SyncEvent$Started() when started != null:
return started(_that);case _SyncEvent$Requested() when requested != null:
return requested(_that);case _SyncEvent$LocalMutation() when localMutation != null:
return localMutation(_that);case _SyncEvent$ConnectivityChanged() when connectivityChanged != null:
return connectivityChanged(_that);case _SyncEvent$AuthChanged() when authChanged != null:
return authChanged(_that);case _SyncEvent$ConflictsShown() when conflictsShown != null:
return conflictsShown(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _SyncEvent$Started value)  started,required TResult Function( _SyncEvent$Requested value)  requested,required TResult Function( _SyncEvent$LocalMutation value)  localMutation,required TResult Function( _SyncEvent$ConnectivityChanged value)  connectivityChanged,required TResult Function( _SyncEvent$AuthChanged value)  authChanged,required TResult Function( _SyncEvent$ConflictsShown value)  conflictsShown,}){
final _that = this;
switch (_that) {
case _SyncEvent$Started():
return started(_that);case _SyncEvent$Requested():
return requested(_that);case _SyncEvent$LocalMutation():
return localMutation(_that);case _SyncEvent$ConnectivityChanged():
return connectivityChanged(_that);case _SyncEvent$AuthChanged():
return authChanged(_that);case _SyncEvent$ConflictsShown():
return conflictsShown(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _SyncEvent$Started value)?  started,TResult? Function( _SyncEvent$Requested value)?  requested,TResult? Function( _SyncEvent$LocalMutation value)?  localMutation,TResult? Function( _SyncEvent$ConnectivityChanged value)?  connectivityChanged,TResult? Function( _SyncEvent$AuthChanged value)?  authChanged,TResult? Function( _SyncEvent$ConflictsShown value)?  conflictsShown,}){
final _that = this;
switch (_that) {
case _SyncEvent$Started() when started != null:
return started(_that);case _SyncEvent$Requested() when requested != null:
return requested(_that);case _SyncEvent$LocalMutation() when localMutation != null:
return localMutation(_that);case _SyncEvent$ConnectivityChanged() when connectivityChanged != null:
return connectivityChanged(_that);case _SyncEvent$AuthChanged() when authChanged != null:
return authChanged(_that);case _SyncEvent$ConflictsShown() when conflictsShown != null:
return conflictsShown(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function()?  requested,TResult Function()?  localMutation,TResult Function( List<ConnectivityResult> results)?  connectivityChanged,TResult Function( SyncAuthStatus status)?  authChanged,TResult Function()?  conflictsShown,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SyncEvent$Started() when started != null:
return started();case _SyncEvent$Requested() when requested != null:
return requested();case _SyncEvent$LocalMutation() when localMutation != null:
return localMutation();case _SyncEvent$ConnectivityChanged() when connectivityChanged != null:
return connectivityChanged(_that.results);case _SyncEvent$AuthChanged() when authChanged != null:
return authChanged(_that.status);case _SyncEvent$ConflictsShown() when conflictsShown != null:
return conflictsShown();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function()  requested,required TResult Function()  localMutation,required TResult Function( List<ConnectivityResult> results)  connectivityChanged,required TResult Function( SyncAuthStatus status)  authChanged,required TResult Function()  conflictsShown,}) {final _that = this;
switch (_that) {
case _SyncEvent$Started():
return started();case _SyncEvent$Requested():
return requested();case _SyncEvent$LocalMutation():
return localMutation();case _SyncEvent$ConnectivityChanged():
return connectivityChanged(_that.results);case _SyncEvent$AuthChanged():
return authChanged(_that.status);case _SyncEvent$ConflictsShown():
return conflictsShown();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function()?  requested,TResult? Function()?  localMutation,TResult? Function( List<ConnectivityResult> results)?  connectivityChanged,TResult? Function( SyncAuthStatus status)?  authChanged,TResult? Function()?  conflictsShown,}) {final _that = this;
switch (_that) {
case _SyncEvent$Started() when started != null:
return started();case _SyncEvent$Requested() when requested != null:
return requested();case _SyncEvent$LocalMutation() when localMutation != null:
return localMutation();case _SyncEvent$ConnectivityChanged() when connectivityChanged != null:
return connectivityChanged(_that.results);case _SyncEvent$AuthChanged() when authChanged != null:
return authChanged(_that.status);case _SyncEvent$ConflictsShown() when conflictsShown != null:
return conflictsShown();case _:
  return null;

}
}

}

/// @nodoc


class _SyncEvent$Started implements SyncEvent {
  const _SyncEvent$Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SyncEvent$Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SyncEvent.started()';
}


}




/// @nodoc


class _SyncEvent$Requested implements SyncEvent {
  const _SyncEvent$Requested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SyncEvent$Requested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SyncEvent.requested()';
}


}




/// @nodoc


class _SyncEvent$LocalMutation implements SyncEvent {
  const _SyncEvent$LocalMutation();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SyncEvent$LocalMutation);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SyncEvent.localMutation()';
}


}




/// @nodoc


class _SyncEvent$ConnectivityChanged implements SyncEvent {
  const _SyncEvent$ConnectivityChanged({required final  List<ConnectivityResult> results}): _results = results;
  

 final  List<ConnectivityResult> _results;
 List<ConnectivityResult> get results {
  if (_results is EqualUnmodifiableListView) return _results;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_results);
}


/// Create a copy of SyncEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SyncEvent$ConnectivityChangedCopyWith<_SyncEvent$ConnectivityChanged> get copyWith => __$SyncEvent$ConnectivityChangedCopyWithImpl<_SyncEvent$ConnectivityChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SyncEvent$ConnectivityChanged&&const DeepCollectionEquality().equals(other._results, _results));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_results));

@override
String toString() {
  return 'SyncEvent.connectivityChanged(results: $results)';
}


}

/// @nodoc
abstract mixin class _$SyncEvent$ConnectivityChangedCopyWith<$Res> implements $SyncEventCopyWith<$Res> {
  factory _$SyncEvent$ConnectivityChangedCopyWith(_SyncEvent$ConnectivityChanged value, $Res Function(_SyncEvent$ConnectivityChanged) _then) = __$SyncEvent$ConnectivityChangedCopyWithImpl;
@useResult
$Res call({
 List<ConnectivityResult> results
});




}
/// @nodoc
class __$SyncEvent$ConnectivityChangedCopyWithImpl<$Res>
    implements _$SyncEvent$ConnectivityChangedCopyWith<$Res> {
  __$SyncEvent$ConnectivityChangedCopyWithImpl(this._self, this._then);

  final _SyncEvent$ConnectivityChanged _self;
  final $Res Function(_SyncEvent$ConnectivityChanged) _then;

/// Create a copy of SyncEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? results = null,}) {
  return _then(_SyncEvent$ConnectivityChanged(
results: null == results ? _self._results : results // ignore: cast_nullable_to_non_nullable
as List<ConnectivityResult>,
  ));
}


}

/// @nodoc


class _SyncEvent$AuthChanged implements SyncEvent {
  const _SyncEvent$AuthChanged(this.status);
  

 final  SyncAuthStatus status;

/// Create a copy of SyncEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SyncEvent$AuthChangedCopyWith<_SyncEvent$AuthChanged> get copyWith => __$SyncEvent$AuthChangedCopyWithImpl<_SyncEvent$AuthChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SyncEvent$AuthChanged&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,status);

@override
String toString() {
  return 'SyncEvent.authChanged(status: $status)';
}


}

/// @nodoc
abstract mixin class _$SyncEvent$AuthChangedCopyWith<$Res> implements $SyncEventCopyWith<$Res> {
  factory _$SyncEvent$AuthChangedCopyWith(_SyncEvent$AuthChanged value, $Res Function(_SyncEvent$AuthChanged) _then) = __$SyncEvent$AuthChangedCopyWithImpl;
@useResult
$Res call({
 SyncAuthStatus status
});




}
/// @nodoc
class __$SyncEvent$AuthChangedCopyWithImpl<$Res>
    implements _$SyncEvent$AuthChangedCopyWith<$Res> {
  __$SyncEvent$AuthChangedCopyWithImpl(this._self, this._then);

  final _SyncEvent$AuthChanged _self;
  final $Res Function(_SyncEvent$AuthChanged) _then;

/// Create a copy of SyncEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? status = null,}) {
  return _then(_SyncEvent$AuthChanged(
null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SyncAuthStatus,
  ));
}


}

/// @nodoc


class _SyncEvent$ConflictsShown implements SyncEvent {
  const _SyncEvent$ConflictsShown();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SyncEvent$ConflictsShown);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SyncEvent.conflictsShown()';
}


}




/// @nodoc
mixin _$SyncStatus {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SyncStatus);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SyncStatus()';
}


}

/// @nodoc
class $SyncStatusCopyWith<$Res>  {
$SyncStatusCopyWith(SyncStatus _, $Res Function(SyncStatus) __);
}


/// Adds pattern-matching-related methods to [SyncStatus].
extension SyncStatusPatterns on SyncStatus {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SyncStatus$Disabled value)?  disabled,TResult Function( SyncStatus$Synced value)?  synced,TResult Function( SyncStatus$Syncing value)?  syncing,TResult Function( SyncStatus$NotSynced value)?  notSynced,TResult Function( SyncStatus$Offline value)?  offline,TResult Function( SyncStatus$Expired value)?  expired,TResult Function( SyncStatus$Failed value)?  failed,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SyncStatus$Disabled() when disabled != null:
return disabled(_that);case SyncStatus$Synced() when synced != null:
return synced(_that);case SyncStatus$Syncing() when syncing != null:
return syncing(_that);case SyncStatus$NotSynced() when notSynced != null:
return notSynced(_that);case SyncStatus$Offline() when offline != null:
return offline(_that);case SyncStatus$Expired() when expired != null:
return expired(_that);case SyncStatus$Failed() when failed != null:
return failed(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SyncStatus$Disabled value)  disabled,required TResult Function( SyncStatus$Synced value)  synced,required TResult Function( SyncStatus$Syncing value)  syncing,required TResult Function( SyncStatus$NotSynced value)  notSynced,required TResult Function( SyncStatus$Offline value)  offline,required TResult Function( SyncStatus$Expired value)  expired,required TResult Function( SyncStatus$Failed value)  failed,}){
final _that = this;
switch (_that) {
case SyncStatus$Disabled():
return disabled(_that);case SyncStatus$Synced():
return synced(_that);case SyncStatus$Syncing():
return syncing(_that);case SyncStatus$NotSynced():
return notSynced(_that);case SyncStatus$Offline():
return offline(_that);case SyncStatus$Expired():
return expired(_that);case SyncStatus$Failed():
return failed(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SyncStatus$Disabled value)?  disabled,TResult? Function( SyncStatus$Synced value)?  synced,TResult? Function( SyncStatus$Syncing value)?  syncing,TResult? Function( SyncStatus$NotSynced value)?  notSynced,TResult? Function( SyncStatus$Offline value)?  offline,TResult? Function( SyncStatus$Expired value)?  expired,TResult? Function( SyncStatus$Failed value)?  failed,}){
final _that = this;
switch (_that) {
case SyncStatus$Disabled() when disabled != null:
return disabled(_that);case SyncStatus$Synced() when synced != null:
return synced(_that);case SyncStatus$Syncing() when syncing != null:
return syncing(_that);case SyncStatus$NotSynced() when notSynced != null:
return notSynced(_that);case SyncStatus$Offline() when offline != null:
return offline(_that);case SyncStatus$Expired() when expired != null:
return expired(_that);case SyncStatus$Failed() when failed != null:
return failed(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  disabled,TResult Function( DateTime? lastSyncedAt)?  synced,TResult Function( DateTime? lastSyncedAt,  SyncProgress? progress)?  syncing,TResult Function( int pending,  DateTime? lastSyncedAt)?  notSynced,TResult Function( int pending,  DateTime? lastSyncedAt)?  offline,TResult Function( DateTime? lastSyncedAt)?  expired,TResult Function( ApiException error,  int pending,  DateTime? lastSyncedAt)?  failed,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SyncStatus$Disabled() when disabled != null:
return disabled();case SyncStatus$Synced() when synced != null:
return synced(_that.lastSyncedAt);case SyncStatus$Syncing() when syncing != null:
return syncing(_that.lastSyncedAt,_that.progress);case SyncStatus$NotSynced() when notSynced != null:
return notSynced(_that.pending,_that.lastSyncedAt);case SyncStatus$Offline() when offline != null:
return offline(_that.pending,_that.lastSyncedAt);case SyncStatus$Expired() when expired != null:
return expired(_that.lastSyncedAt);case SyncStatus$Failed() when failed != null:
return failed(_that.error,_that.pending,_that.lastSyncedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  disabled,required TResult Function( DateTime? lastSyncedAt)  synced,required TResult Function( DateTime? lastSyncedAt,  SyncProgress? progress)  syncing,required TResult Function( int pending,  DateTime? lastSyncedAt)  notSynced,required TResult Function( int pending,  DateTime? lastSyncedAt)  offline,required TResult Function( DateTime? lastSyncedAt)  expired,required TResult Function( ApiException error,  int pending,  DateTime? lastSyncedAt)  failed,}) {final _that = this;
switch (_that) {
case SyncStatus$Disabled():
return disabled();case SyncStatus$Synced():
return synced(_that.lastSyncedAt);case SyncStatus$Syncing():
return syncing(_that.lastSyncedAt,_that.progress);case SyncStatus$NotSynced():
return notSynced(_that.pending,_that.lastSyncedAt);case SyncStatus$Offline():
return offline(_that.pending,_that.lastSyncedAt);case SyncStatus$Expired():
return expired(_that.lastSyncedAt);case SyncStatus$Failed():
return failed(_that.error,_that.pending,_that.lastSyncedAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  disabled,TResult? Function( DateTime? lastSyncedAt)?  synced,TResult? Function( DateTime? lastSyncedAt,  SyncProgress? progress)?  syncing,TResult? Function( int pending,  DateTime? lastSyncedAt)?  notSynced,TResult? Function( int pending,  DateTime? lastSyncedAt)?  offline,TResult? Function( DateTime? lastSyncedAt)?  expired,TResult? Function( ApiException error,  int pending,  DateTime? lastSyncedAt)?  failed,}) {final _that = this;
switch (_that) {
case SyncStatus$Disabled() when disabled != null:
return disabled();case SyncStatus$Synced() when synced != null:
return synced(_that.lastSyncedAt);case SyncStatus$Syncing() when syncing != null:
return syncing(_that.lastSyncedAt,_that.progress);case SyncStatus$NotSynced() when notSynced != null:
return notSynced(_that.pending,_that.lastSyncedAt);case SyncStatus$Offline() when offline != null:
return offline(_that.pending,_that.lastSyncedAt);case SyncStatus$Expired() when expired != null:
return expired(_that.lastSyncedAt);case SyncStatus$Failed() when failed != null:
return failed(_that.error,_that.pending,_that.lastSyncedAt);case _:
  return null;

}
}

}

/// @nodoc


class SyncStatus$Disabled implements SyncStatus {
  const SyncStatus$Disabled();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SyncStatus$Disabled);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SyncStatus.disabled()';
}


}




/// @nodoc


class SyncStatus$Synced implements SyncStatus {
  const SyncStatus$Synced({this.lastSyncedAt});
  

 final  DateTime? lastSyncedAt;

/// Create a copy of SyncStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SyncStatus$SyncedCopyWith<SyncStatus$Synced> get copyWith => _$SyncStatus$SyncedCopyWithImpl<SyncStatus$Synced>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SyncStatus$Synced&&(identical(other.lastSyncedAt, lastSyncedAt) || other.lastSyncedAt == lastSyncedAt));
}


@override
int get hashCode => Object.hash(runtimeType,lastSyncedAt);

@override
String toString() {
  return 'SyncStatus.synced(lastSyncedAt: $lastSyncedAt)';
}


}

/// @nodoc
abstract mixin class $SyncStatus$SyncedCopyWith<$Res> implements $SyncStatusCopyWith<$Res> {
  factory $SyncStatus$SyncedCopyWith(SyncStatus$Synced value, $Res Function(SyncStatus$Synced) _then) = _$SyncStatus$SyncedCopyWithImpl;
@useResult
$Res call({
 DateTime? lastSyncedAt
});




}
/// @nodoc
class _$SyncStatus$SyncedCopyWithImpl<$Res>
    implements $SyncStatus$SyncedCopyWith<$Res> {
  _$SyncStatus$SyncedCopyWithImpl(this._self, this._then);

  final SyncStatus$Synced _self;
  final $Res Function(SyncStatus$Synced) _then;

/// Create a copy of SyncStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? lastSyncedAt = freezed,}) {
  return _then(SyncStatus$Synced(
lastSyncedAt: freezed == lastSyncedAt ? _self.lastSyncedAt : lastSyncedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc


class SyncStatus$Syncing implements SyncStatus {
  const SyncStatus$Syncing({this.lastSyncedAt, this.progress});
  

 final  DateTime? lastSyncedAt;
 final  SyncProgress? progress;

/// Create a copy of SyncStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SyncStatus$SyncingCopyWith<SyncStatus$Syncing> get copyWith => _$SyncStatus$SyncingCopyWithImpl<SyncStatus$Syncing>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SyncStatus$Syncing&&(identical(other.lastSyncedAt, lastSyncedAt) || other.lastSyncedAt == lastSyncedAt)&&(identical(other.progress, progress) || other.progress == progress));
}


@override
int get hashCode => Object.hash(runtimeType,lastSyncedAt,progress);

@override
String toString() {
  return 'SyncStatus.syncing(lastSyncedAt: $lastSyncedAt, progress: $progress)';
}


}

/// @nodoc
abstract mixin class $SyncStatus$SyncingCopyWith<$Res> implements $SyncStatusCopyWith<$Res> {
  factory $SyncStatus$SyncingCopyWith(SyncStatus$Syncing value, $Res Function(SyncStatus$Syncing) _then) = _$SyncStatus$SyncingCopyWithImpl;
@useResult
$Res call({
 DateTime? lastSyncedAt, SyncProgress? progress
});




}
/// @nodoc
class _$SyncStatus$SyncingCopyWithImpl<$Res>
    implements $SyncStatus$SyncingCopyWith<$Res> {
  _$SyncStatus$SyncingCopyWithImpl(this._self, this._then);

  final SyncStatus$Syncing _self;
  final $Res Function(SyncStatus$Syncing) _then;

/// Create a copy of SyncStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? lastSyncedAt = freezed,Object? progress = freezed,}) {
  return _then(SyncStatus$Syncing(
lastSyncedAt: freezed == lastSyncedAt ? _self.lastSyncedAt : lastSyncedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,progress: freezed == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as SyncProgress?,
  ));
}


}

/// @nodoc


class SyncStatus$NotSynced implements SyncStatus {
  const SyncStatus$NotSynced({required this.pending, this.lastSyncedAt});
  

 final  int pending;
 final  DateTime? lastSyncedAt;

/// Create a copy of SyncStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SyncStatus$NotSyncedCopyWith<SyncStatus$NotSynced> get copyWith => _$SyncStatus$NotSyncedCopyWithImpl<SyncStatus$NotSynced>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SyncStatus$NotSynced&&(identical(other.pending, pending) || other.pending == pending)&&(identical(other.lastSyncedAt, lastSyncedAt) || other.lastSyncedAt == lastSyncedAt));
}


@override
int get hashCode => Object.hash(runtimeType,pending,lastSyncedAt);

@override
String toString() {
  return 'SyncStatus.notSynced(pending: $pending, lastSyncedAt: $lastSyncedAt)';
}


}

/// @nodoc
abstract mixin class $SyncStatus$NotSyncedCopyWith<$Res> implements $SyncStatusCopyWith<$Res> {
  factory $SyncStatus$NotSyncedCopyWith(SyncStatus$NotSynced value, $Res Function(SyncStatus$NotSynced) _then) = _$SyncStatus$NotSyncedCopyWithImpl;
@useResult
$Res call({
 int pending, DateTime? lastSyncedAt
});




}
/// @nodoc
class _$SyncStatus$NotSyncedCopyWithImpl<$Res>
    implements $SyncStatus$NotSyncedCopyWith<$Res> {
  _$SyncStatus$NotSyncedCopyWithImpl(this._self, this._then);

  final SyncStatus$NotSynced _self;
  final $Res Function(SyncStatus$NotSynced) _then;

/// Create a copy of SyncStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? pending = null,Object? lastSyncedAt = freezed,}) {
  return _then(SyncStatus$NotSynced(
pending: null == pending ? _self.pending : pending // ignore: cast_nullable_to_non_nullable
as int,lastSyncedAt: freezed == lastSyncedAt ? _self.lastSyncedAt : lastSyncedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc


class SyncStatus$Offline implements SyncStatus {
  const SyncStatus$Offline({this.pending = 0, this.lastSyncedAt});
  

@JsonKey() final  int pending;
 final  DateTime? lastSyncedAt;

/// Create a copy of SyncStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SyncStatus$OfflineCopyWith<SyncStatus$Offline> get copyWith => _$SyncStatus$OfflineCopyWithImpl<SyncStatus$Offline>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SyncStatus$Offline&&(identical(other.pending, pending) || other.pending == pending)&&(identical(other.lastSyncedAt, lastSyncedAt) || other.lastSyncedAt == lastSyncedAt));
}


@override
int get hashCode => Object.hash(runtimeType,pending,lastSyncedAt);

@override
String toString() {
  return 'SyncStatus.offline(pending: $pending, lastSyncedAt: $lastSyncedAt)';
}


}

/// @nodoc
abstract mixin class $SyncStatus$OfflineCopyWith<$Res> implements $SyncStatusCopyWith<$Res> {
  factory $SyncStatus$OfflineCopyWith(SyncStatus$Offline value, $Res Function(SyncStatus$Offline) _then) = _$SyncStatus$OfflineCopyWithImpl;
@useResult
$Res call({
 int pending, DateTime? lastSyncedAt
});




}
/// @nodoc
class _$SyncStatus$OfflineCopyWithImpl<$Res>
    implements $SyncStatus$OfflineCopyWith<$Res> {
  _$SyncStatus$OfflineCopyWithImpl(this._self, this._then);

  final SyncStatus$Offline _self;
  final $Res Function(SyncStatus$Offline) _then;

/// Create a copy of SyncStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? pending = null,Object? lastSyncedAt = freezed,}) {
  return _then(SyncStatus$Offline(
pending: null == pending ? _self.pending : pending // ignore: cast_nullable_to_non_nullable
as int,lastSyncedAt: freezed == lastSyncedAt ? _self.lastSyncedAt : lastSyncedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc


class SyncStatus$Expired implements SyncStatus {
  const SyncStatus$Expired({this.lastSyncedAt});
  

 final  DateTime? lastSyncedAt;

/// Create a copy of SyncStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SyncStatus$ExpiredCopyWith<SyncStatus$Expired> get copyWith => _$SyncStatus$ExpiredCopyWithImpl<SyncStatus$Expired>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SyncStatus$Expired&&(identical(other.lastSyncedAt, lastSyncedAt) || other.lastSyncedAt == lastSyncedAt));
}


@override
int get hashCode => Object.hash(runtimeType,lastSyncedAt);

@override
String toString() {
  return 'SyncStatus.expired(lastSyncedAt: $lastSyncedAt)';
}


}

/// @nodoc
abstract mixin class $SyncStatus$ExpiredCopyWith<$Res> implements $SyncStatusCopyWith<$Res> {
  factory $SyncStatus$ExpiredCopyWith(SyncStatus$Expired value, $Res Function(SyncStatus$Expired) _then) = _$SyncStatus$ExpiredCopyWithImpl;
@useResult
$Res call({
 DateTime? lastSyncedAt
});




}
/// @nodoc
class _$SyncStatus$ExpiredCopyWithImpl<$Res>
    implements $SyncStatus$ExpiredCopyWith<$Res> {
  _$SyncStatus$ExpiredCopyWithImpl(this._self, this._then);

  final SyncStatus$Expired _self;
  final $Res Function(SyncStatus$Expired) _then;

/// Create a copy of SyncStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? lastSyncedAt = freezed,}) {
  return _then(SyncStatus$Expired(
lastSyncedAt: freezed == lastSyncedAt ? _self.lastSyncedAt : lastSyncedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc


class SyncStatus$Failed implements SyncStatus {
  const SyncStatus$Failed({required this.error, this.pending = 0, this.lastSyncedAt});
  

 final  ApiException error;
@JsonKey() final  int pending;
 final  DateTime? lastSyncedAt;

/// Create a copy of SyncStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SyncStatus$FailedCopyWith<SyncStatus$Failed> get copyWith => _$SyncStatus$FailedCopyWithImpl<SyncStatus$Failed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SyncStatus$Failed&&(identical(other.error, error) || other.error == error)&&(identical(other.pending, pending) || other.pending == pending)&&(identical(other.lastSyncedAt, lastSyncedAt) || other.lastSyncedAt == lastSyncedAt));
}


@override
int get hashCode => Object.hash(runtimeType,error,pending,lastSyncedAt);

@override
String toString() {
  return 'SyncStatus.failed(error: $error, pending: $pending, lastSyncedAt: $lastSyncedAt)';
}


}

/// @nodoc
abstract mixin class $SyncStatus$FailedCopyWith<$Res> implements $SyncStatusCopyWith<$Res> {
  factory $SyncStatus$FailedCopyWith(SyncStatus$Failed value, $Res Function(SyncStatus$Failed) _then) = _$SyncStatus$FailedCopyWithImpl;
@useResult
$Res call({
 ApiException error, int pending, DateTime? lastSyncedAt
});




}
/// @nodoc
class _$SyncStatus$FailedCopyWithImpl<$Res>
    implements $SyncStatus$FailedCopyWith<$Res> {
  _$SyncStatus$FailedCopyWithImpl(this._self, this._then);

  final SyncStatus$Failed _self;
  final $Res Function(SyncStatus$Failed) _then;

/// Create a copy of SyncStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,Object? pending = null,Object? lastSyncedAt = freezed,}) {
  return _then(SyncStatus$Failed(
error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as ApiException,pending: null == pending ? _self.pending : pending // ignore: cast_nullable_to_non_nullable
as int,lastSyncedAt: freezed == lastSyncedAt ? _self.lastSyncedAt : lastSyncedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc
mixin _$SyncState {

 SyncStatus get status;/// Конфликты, о которых ещё не сказали пользователю.
 List<SyncConflictReport> get conflicts;/// Итог последнего прогона.
 SyncRunResult? get lastRun;/// Откуда взято время последней синхронизации. При `local` подпись
/// в диалоге мягче, а относительную не показываем вовсе.
 SyncTimeSource get lastSyncedSource;
/// Create a copy of SyncState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SyncStateCopyWith<SyncState> get copyWith => _$SyncStateCopyWithImpl<SyncState>(this as SyncState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SyncState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.conflicts, conflicts)&&(identical(other.lastRun, lastRun) || other.lastRun == lastRun)&&(identical(other.lastSyncedSource, lastSyncedSource) || other.lastSyncedSource == lastSyncedSource));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(conflicts),lastRun,lastSyncedSource);

@override
String toString() {
  return 'SyncState(status: $status, conflicts: $conflicts, lastRun: $lastRun, lastSyncedSource: $lastSyncedSource)';
}


}

/// @nodoc
abstract mixin class $SyncStateCopyWith<$Res>  {
  factory $SyncStateCopyWith(SyncState value, $Res Function(SyncState) _then) = _$SyncStateCopyWithImpl;
@useResult
$Res call({
 SyncStatus status, List<SyncConflictReport> conflicts, SyncRunResult? lastRun, SyncTimeSource lastSyncedSource
});


$SyncStatusCopyWith<$Res> get status;

}
/// @nodoc
class _$SyncStateCopyWithImpl<$Res>
    implements $SyncStateCopyWith<$Res> {
  _$SyncStateCopyWithImpl(this._self, this._then);

  final SyncState _self;
  final $Res Function(SyncState) _then;

/// Create a copy of SyncState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? conflicts = null,Object? lastRun = freezed,Object? lastSyncedSource = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SyncStatus,conflicts: null == conflicts ? _self.conflicts : conflicts // ignore: cast_nullable_to_non_nullable
as List<SyncConflictReport>,lastRun: freezed == lastRun ? _self.lastRun : lastRun // ignore: cast_nullable_to_non_nullable
as SyncRunResult?,lastSyncedSource: null == lastSyncedSource ? _self.lastSyncedSource : lastSyncedSource // ignore: cast_nullable_to_non_nullable
as SyncTimeSource,
  ));
}
/// Create a copy of SyncState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SyncStatusCopyWith<$Res> get status {
  
  return $SyncStatusCopyWith<$Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}
}


/// Adds pattern-matching-related methods to [SyncState].
extension SyncStatePatterns on SyncState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SyncState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SyncState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SyncState value)  $default,){
final _that = this;
switch (_that) {
case _SyncState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SyncState value)?  $default,){
final _that = this;
switch (_that) {
case _SyncState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SyncStatus status,  List<SyncConflictReport> conflicts,  SyncRunResult? lastRun,  SyncTimeSource lastSyncedSource)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SyncState() when $default != null:
return $default(_that.status,_that.conflicts,_that.lastRun,_that.lastSyncedSource);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SyncStatus status,  List<SyncConflictReport> conflicts,  SyncRunResult? lastRun,  SyncTimeSource lastSyncedSource)  $default,) {final _that = this;
switch (_that) {
case _SyncState():
return $default(_that.status,_that.conflicts,_that.lastRun,_that.lastSyncedSource);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SyncStatus status,  List<SyncConflictReport> conflicts,  SyncRunResult? lastRun,  SyncTimeSource lastSyncedSource)?  $default,) {final _that = this;
switch (_that) {
case _SyncState() when $default != null:
return $default(_that.status,_that.conflicts,_that.lastRun,_that.lastSyncedSource);case _:
  return null;

}
}

}

/// @nodoc


class _SyncState implements SyncState {
  const _SyncState({required this.status, final  List<SyncConflictReport> conflicts = const <SyncConflictReport>[], this.lastRun, this.lastSyncedSource = SyncTimeSource.server}): _conflicts = conflicts;
  

@override final  SyncStatus status;
/// Конфликты, о которых ещё не сказали пользователю.
 final  List<SyncConflictReport> _conflicts;
/// Конфликты, о которых ещё не сказали пользователю.
@override@JsonKey() List<SyncConflictReport> get conflicts {
  if (_conflicts is EqualUnmodifiableListView) return _conflicts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_conflicts);
}

/// Итог последнего прогона.
@override final  SyncRunResult? lastRun;
/// Откуда взято время последней синхронизации. При `local` подпись
/// в диалоге мягче, а относительную не показываем вовсе.
@override@JsonKey() final  SyncTimeSource lastSyncedSource;

/// Create a copy of SyncState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SyncStateCopyWith<_SyncState> get copyWith => __$SyncStateCopyWithImpl<_SyncState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SyncState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._conflicts, _conflicts)&&(identical(other.lastRun, lastRun) || other.lastRun == lastRun)&&(identical(other.lastSyncedSource, lastSyncedSource) || other.lastSyncedSource == lastSyncedSource));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_conflicts),lastRun,lastSyncedSource);

@override
String toString() {
  return 'SyncState(status: $status, conflicts: $conflicts, lastRun: $lastRun, lastSyncedSource: $lastSyncedSource)';
}


}

/// @nodoc
abstract mixin class _$SyncStateCopyWith<$Res> implements $SyncStateCopyWith<$Res> {
  factory _$SyncStateCopyWith(_SyncState value, $Res Function(_SyncState) _then) = __$SyncStateCopyWithImpl;
@override @useResult
$Res call({
 SyncStatus status, List<SyncConflictReport> conflicts, SyncRunResult? lastRun, SyncTimeSource lastSyncedSource
});


@override $SyncStatusCopyWith<$Res> get status;

}
/// @nodoc
class __$SyncStateCopyWithImpl<$Res>
    implements _$SyncStateCopyWith<$Res> {
  __$SyncStateCopyWithImpl(this._self, this._then);

  final _SyncState _self;
  final $Res Function(_SyncState) _then;

/// Create a copy of SyncState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? conflicts = null,Object? lastRun = freezed,Object? lastSyncedSource = null,}) {
  return _then(_SyncState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SyncStatus,conflicts: null == conflicts ? _self._conflicts : conflicts // ignore: cast_nullable_to_non_nullable
as List<SyncConflictReport>,lastRun: freezed == lastRun ? _self.lastRun : lastRun // ignore: cast_nullable_to_non_nullable
as SyncRunResult?,lastSyncedSource: null == lastSyncedSource ? _self.lastSyncedSource : lastSyncedSource // ignore: cast_nullable_to_non_nullable
as SyncTimeSource,
  ));
}

/// Create a copy of SyncState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SyncStatusCopyWith<$Res> get status {
  
  return $SyncStatusCopyWith<$Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}
}

// dart format on
