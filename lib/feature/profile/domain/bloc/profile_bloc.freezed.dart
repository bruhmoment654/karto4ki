// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProfileEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProfileEvent()';
}


}

/// @nodoc
class $ProfileEventCopyWith<$Res>  {
$ProfileEventCopyWith(ProfileEvent _, $Res Function(ProfileEvent) __);
}


/// Adds pattern-matching-related methods to [ProfileEvent].
extension ProfileEventPatterns on ProfileEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _ProfileEvent$Started value)?  started,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfileEvent$Started() when started != null:
return started(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _ProfileEvent$Started value)  started,}){
final _that = this;
switch (_that) {
case _ProfileEvent$Started():
return started(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _ProfileEvent$Started value)?  started,}){
final _that = this;
switch (_that) {
case _ProfileEvent$Started() when started != null:
return started(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileEvent$Started() when started != null:
return started();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,}) {final _that = this;
switch (_that) {
case _ProfileEvent$Started():
return started();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,}) {final _that = this;
switch (_that) {
case _ProfileEvent$Started() when started != null:
return started();case _:
  return null;

}
}

}

/// @nodoc


class _ProfileEvent$Started implements ProfileEvent {
  const _ProfileEvent$Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileEvent$Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProfileEvent.started()';
}


}




/// @nodoc
mixin _$ProfileState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProfileState()';
}


}

/// @nodoc
class $ProfileStateCopyWith<$Res>  {
$ProfileStateCopyWith(ProfileState _, $Res Function(ProfileState) __);
}


/// Adds pattern-matching-related methods to [ProfileState].
extension ProfileStatePatterns on ProfileState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ProfileState$Loading value)?  loading,TResult Function( ProfileState$Loaded value)?  loaded,TResult Function( ProfileState$Error value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ProfileState$Loading() when loading != null:
return loading(_that);case ProfileState$Loaded() when loaded != null:
return loaded(_that);case ProfileState$Error() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ProfileState$Loading value)  loading,required TResult Function( ProfileState$Loaded value)  loaded,required TResult Function( ProfileState$Error value)  error,}){
final _that = this;
switch (_that) {
case ProfileState$Loading():
return loading(_that);case ProfileState$Loaded():
return loaded(_that);case ProfileState$Error():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ProfileState$Loading value)?  loading,TResult? Function( ProfileState$Loaded value)?  loaded,TResult? Function( ProfileState$Error value)?  error,}){
final _that = this;
switch (_that) {
case ProfileState$Loading() when loading != null:
return loading(_that);case ProfileState$Loaded() when loaded != null:
return loaded(_that);case ProfileState$Error() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function( ProfileSummaryEntity summary)?  loaded,TResult Function( Failure failure)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ProfileState$Loading() when loading != null:
return loading();case ProfileState$Loaded() when loaded != null:
return loaded(_that.summary);case ProfileState$Error() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function( ProfileSummaryEntity summary)  loaded,required TResult Function( Failure failure)  error,}) {final _that = this;
switch (_that) {
case ProfileState$Loading():
return loading();case ProfileState$Loaded():
return loaded(_that.summary);case ProfileState$Error():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function( ProfileSummaryEntity summary)?  loaded,TResult? Function( Failure failure)?  error,}) {final _that = this;
switch (_that) {
case ProfileState$Loading() when loading != null:
return loading();case ProfileState$Loaded() when loaded != null:
return loaded(_that.summary);case ProfileState$Error() when error != null:
return error(_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class ProfileState$Loading extends ProfileState {
  const ProfileState$Loading(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileState$Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProfileState.loading()';
}


}




/// @nodoc


class ProfileState$Loaded extends ProfileState {
  const ProfileState$Loaded({required this.summary}): super._();
  

 final  ProfileSummaryEntity summary;

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileState$LoadedCopyWith<ProfileState$Loaded> get copyWith => _$ProfileState$LoadedCopyWithImpl<ProfileState$Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileState$Loaded&&(identical(other.summary, summary) || other.summary == summary));
}


@override
int get hashCode => Object.hash(runtimeType,summary);

@override
String toString() {
  return 'ProfileState.loaded(summary: $summary)';
}


}

/// @nodoc
abstract mixin class $ProfileState$LoadedCopyWith<$Res> implements $ProfileStateCopyWith<$Res> {
  factory $ProfileState$LoadedCopyWith(ProfileState$Loaded value, $Res Function(ProfileState$Loaded) _then) = _$ProfileState$LoadedCopyWithImpl;
@useResult
$Res call({
 ProfileSummaryEntity summary
});


$ProfileSummaryEntityCopyWith<$Res> get summary;

}
/// @nodoc
class _$ProfileState$LoadedCopyWithImpl<$Res>
    implements $ProfileState$LoadedCopyWith<$Res> {
  _$ProfileState$LoadedCopyWithImpl(this._self, this._then);

  final ProfileState$Loaded _self;
  final $Res Function(ProfileState$Loaded) _then;

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? summary = null,}) {
  return _then(ProfileState$Loaded(
summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as ProfileSummaryEntity,
  ));
}

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProfileSummaryEntityCopyWith<$Res> get summary {
  
  return $ProfileSummaryEntityCopyWith<$Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}
}

/// @nodoc


class ProfileState$Error extends ProfileState {
  const ProfileState$Error({required this.failure}): super._();
  

 final  Failure failure;

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileState$ErrorCopyWith<ProfileState$Error> get copyWith => _$ProfileState$ErrorCopyWithImpl<ProfileState$Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileState$Error&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,failure);

@override
String toString() {
  return 'ProfileState.error(failure: $failure)';
}


}

/// @nodoc
abstract mixin class $ProfileState$ErrorCopyWith<$Res> implements $ProfileStateCopyWith<$Res> {
  factory $ProfileState$ErrorCopyWith(ProfileState$Error value, $Res Function(ProfileState$Error) _then) = _$ProfileState$ErrorCopyWithImpl;
@useResult
$Res call({
 Failure failure
});




}
/// @nodoc
class _$ProfileState$ErrorCopyWithImpl<$Res>
    implements $ProfileState$ErrorCopyWith<$Res> {
  _$ProfileState$ErrorCopyWithImpl(this._self, this._then);

  final ProfileState$Error _self;
  final $Res Function(ProfileState$Error) _then;

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(ProfileState$Error(
failure: null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}


}

// dart format on
