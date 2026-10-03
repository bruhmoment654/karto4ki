// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SettingsEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SettingsEvent()';
}


}

/// @nodoc
class $SettingsEventCopyWith<$Res>  {
$SettingsEventCopyWith(SettingsEvent _, $Res Function(SettingsEvent) __);
}


/// Adds pattern-matching-related methods to [SettingsEvent].
extension SettingsEventPatterns on SettingsEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _SettingsEvent$Started value)?  started,TResult Function( _SettingsEvent$ThemeModeChanged value)?  themeModeChanged,TResult Function( _SettingsEvent$ColorStyleChanged value)?  colorStyleChanged,TResult Function( _SettingsEvent$AnimationDurationChanged value)?  animationDurationChanged,TResult Function( _SettingsEvent$CardFontSizeChanged value)?  cardFontSizeChanged,TResult Function( _SettingsEvent$AccentColorHueChanged value)?  accentColorHueChanged,TResult Function( _SettingsEvent$AccentColorHueCommitted value)?  accentColorHueCommitted,TResult Function( _SettingsEvent$StatsExportRequested value)?  statsExportRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SettingsEvent$Started() when started != null:
return started(_that);case _SettingsEvent$ThemeModeChanged() when themeModeChanged != null:
return themeModeChanged(_that);case _SettingsEvent$ColorStyleChanged() when colorStyleChanged != null:
return colorStyleChanged(_that);case _SettingsEvent$AnimationDurationChanged() when animationDurationChanged != null:
return animationDurationChanged(_that);case _SettingsEvent$CardFontSizeChanged() when cardFontSizeChanged != null:
return cardFontSizeChanged(_that);case _SettingsEvent$AccentColorHueChanged() when accentColorHueChanged != null:
return accentColorHueChanged(_that);case _SettingsEvent$AccentColorHueCommitted() when accentColorHueCommitted != null:
return accentColorHueCommitted(_that);case _SettingsEvent$StatsExportRequested() when statsExportRequested != null:
return statsExportRequested(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _SettingsEvent$Started value)  started,required TResult Function( _SettingsEvent$ThemeModeChanged value)  themeModeChanged,required TResult Function( _SettingsEvent$ColorStyleChanged value)  colorStyleChanged,required TResult Function( _SettingsEvent$AnimationDurationChanged value)  animationDurationChanged,required TResult Function( _SettingsEvent$CardFontSizeChanged value)  cardFontSizeChanged,required TResult Function( _SettingsEvent$AccentColorHueChanged value)  accentColorHueChanged,required TResult Function( _SettingsEvent$AccentColorHueCommitted value)  accentColorHueCommitted,required TResult Function( _SettingsEvent$StatsExportRequested value)  statsExportRequested,}){
final _that = this;
switch (_that) {
case _SettingsEvent$Started():
return started(_that);case _SettingsEvent$ThemeModeChanged():
return themeModeChanged(_that);case _SettingsEvent$ColorStyleChanged():
return colorStyleChanged(_that);case _SettingsEvent$AnimationDurationChanged():
return animationDurationChanged(_that);case _SettingsEvent$CardFontSizeChanged():
return cardFontSizeChanged(_that);case _SettingsEvent$AccentColorHueChanged():
return accentColorHueChanged(_that);case _SettingsEvent$AccentColorHueCommitted():
return accentColorHueCommitted(_that);case _SettingsEvent$StatsExportRequested():
return statsExportRequested(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _SettingsEvent$Started value)?  started,TResult? Function( _SettingsEvent$ThemeModeChanged value)?  themeModeChanged,TResult? Function( _SettingsEvent$ColorStyleChanged value)?  colorStyleChanged,TResult? Function( _SettingsEvent$AnimationDurationChanged value)?  animationDurationChanged,TResult? Function( _SettingsEvent$CardFontSizeChanged value)?  cardFontSizeChanged,TResult? Function( _SettingsEvent$AccentColorHueChanged value)?  accentColorHueChanged,TResult? Function( _SettingsEvent$AccentColorHueCommitted value)?  accentColorHueCommitted,TResult? Function( _SettingsEvent$StatsExportRequested value)?  statsExportRequested,}){
final _that = this;
switch (_that) {
case _SettingsEvent$Started() when started != null:
return started(_that);case _SettingsEvent$ThemeModeChanged() when themeModeChanged != null:
return themeModeChanged(_that);case _SettingsEvent$ColorStyleChanged() when colorStyleChanged != null:
return colorStyleChanged(_that);case _SettingsEvent$AnimationDurationChanged() when animationDurationChanged != null:
return animationDurationChanged(_that);case _SettingsEvent$CardFontSizeChanged() when cardFontSizeChanged != null:
return cardFontSizeChanged(_that);case _SettingsEvent$AccentColorHueChanged() when accentColorHueChanged != null:
return accentColorHueChanged(_that);case _SettingsEvent$AccentColorHueCommitted() when accentColorHueCommitted != null:
return accentColorHueCommitted(_that);case _SettingsEvent$StatsExportRequested() when statsExportRequested != null:
return statsExportRequested(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( AppThemeMode mode)?  themeModeChanged,TResult Function( AppColorStyle style)?  colorStyleChanged,TResult Function( double value)?  animationDurationChanged,TResult Function( double value)?  cardFontSizeChanged,TResult Function( double value)?  accentColorHueChanged,TResult Function( double value)?  accentColorHueCommitted,TResult Function()?  statsExportRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SettingsEvent$Started() when started != null:
return started();case _SettingsEvent$ThemeModeChanged() when themeModeChanged != null:
return themeModeChanged(_that.mode);case _SettingsEvent$ColorStyleChanged() when colorStyleChanged != null:
return colorStyleChanged(_that.style);case _SettingsEvent$AnimationDurationChanged() when animationDurationChanged != null:
return animationDurationChanged(_that.value);case _SettingsEvent$CardFontSizeChanged() when cardFontSizeChanged != null:
return cardFontSizeChanged(_that.value);case _SettingsEvent$AccentColorHueChanged() when accentColorHueChanged != null:
return accentColorHueChanged(_that.value);case _SettingsEvent$AccentColorHueCommitted() when accentColorHueCommitted != null:
return accentColorHueCommitted(_that.value);case _SettingsEvent$StatsExportRequested() when statsExportRequested != null:
return statsExportRequested();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( AppThemeMode mode)  themeModeChanged,required TResult Function( AppColorStyle style)  colorStyleChanged,required TResult Function( double value)  animationDurationChanged,required TResult Function( double value)  cardFontSizeChanged,required TResult Function( double value)  accentColorHueChanged,required TResult Function( double value)  accentColorHueCommitted,required TResult Function()  statsExportRequested,}) {final _that = this;
switch (_that) {
case _SettingsEvent$Started():
return started();case _SettingsEvent$ThemeModeChanged():
return themeModeChanged(_that.mode);case _SettingsEvent$ColorStyleChanged():
return colorStyleChanged(_that.style);case _SettingsEvent$AnimationDurationChanged():
return animationDurationChanged(_that.value);case _SettingsEvent$CardFontSizeChanged():
return cardFontSizeChanged(_that.value);case _SettingsEvent$AccentColorHueChanged():
return accentColorHueChanged(_that.value);case _SettingsEvent$AccentColorHueCommitted():
return accentColorHueCommitted(_that.value);case _SettingsEvent$StatsExportRequested():
return statsExportRequested();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( AppThemeMode mode)?  themeModeChanged,TResult? Function( AppColorStyle style)?  colorStyleChanged,TResult? Function( double value)?  animationDurationChanged,TResult? Function( double value)?  cardFontSizeChanged,TResult? Function( double value)?  accentColorHueChanged,TResult? Function( double value)?  accentColorHueCommitted,TResult? Function()?  statsExportRequested,}) {final _that = this;
switch (_that) {
case _SettingsEvent$Started() when started != null:
return started();case _SettingsEvent$ThemeModeChanged() when themeModeChanged != null:
return themeModeChanged(_that.mode);case _SettingsEvent$ColorStyleChanged() when colorStyleChanged != null:
return colorStyleChanged(_that.style);case _SettingsEvent$AnimationDurationChanged() when animationDurationChanged != null:
return animationDurationChanged(_that.value);case _SettingsEvent$CardFontSizeChanged() when cardFontSizeChanged != null:
return cardFontSizeChanged(_that.value);case _SettingsEvent$AccentColorHueChanged() when accentColorHueChanged != null:
return accentColorHueChanged(_that.value);case _SettingsEvent$AccentColorHueCommitted() when accentColorHueCommitted != null:
return accentColorHueCommitted(_that.value);case _SettingsEvent$StatsExportRequested() when statsExportRequested != null:
return statsExportRequested();case _:
  return null;

}
}

}

/// @nodoc


class _SettingsEvent$Started implements SettingsEvent {
  const _SettingsEvent$Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SettingsEvent$Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SettingsEvent.started()';
}


}




/// @nodoc


class _SettingsEvent$ThemeModeChanged implements SettingsEvent {
  const _SettingsEvent$ThemeModeChanged({required this.mode});
  

 final  AppThemeMode mode;

/// Create a copy of SettingsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SettingsEvent$ThemeModeChangedCopyWith<_SettingsEvent$ThemeModeChanged> get copyWith => __$SettingsEvent$ThemeModeChangedCopyWithImpl<_SettingsEvent$ThemeModeChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SettingsEvent$ThemeModeChanged&&(identical(other.mode, mode) || other.mode == mode));
}


@override
int get hashCode => Object.hash(runtimeType,mode);

@override
String toString() {
  return 'SettingsEvent.themeModeChanged(mode: $mode)';
}


}

/// @nodoc
abstract mixin class _$SettingsEvent$ThemeModeChangedCopyWith<$Res> implements $SettingsEventCopyWith<$Res> {
  factory _$SettingsEvent$ThemeModeChangedCopyWith(_SettingsEvent$ThemeModeChanged value, $Res Function(_SettingsEvent$ThemeModeChanged) _then) = __$SettingsEvent$ThemeModeChangedCopyWithImpl;
@useResult
$Res call({
 AppThemeMode mode
});




}
/// @nodoc
class __$SettingsEvent$ThemeModeChangedCopyWithImpl<$Res>
    implements _$SettingsEvent$ThemeModeChangedCopyWith<$Res> {
  __$SettingsEvent$ThemeModeChangedCopyWithImpl(this._self, this._then);

  final _SettingsEvent$ThemeModeChanged _self;
  final $Res Function(_SettingsEvent$ThemeModeChanged) _then;

/// Create a copy of SettingsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? mode = null,}) {
  return _then(_SettingsEvent$ThemeModeChanged(
mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as AppThemeMode,
  ));
}


}

/// @nodoc


class _SettingsEvent$ColorStyleChanged implements SettingsEvent {
  const _SettingsEvent$ColorStyleChanged({required this.style});
  

 final  AppColorStyle style;

/// Create a copy of SettingsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SettingsEvent$ColorStyleChangedCopyWith<_SettingsEvent$ColorStyleChanged> get copyWith => __$SettingsEvent$ColorStyleChangedCopyWithImpl<_SettingsEvent$ColorStyleChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SettingsEvent$ColorStyleChanged&&(identical(other.style, style) || other.style == style));
}


@override
int get hashCode => Object.hash(runtimeType,style);

@override
String toString() {
  return 'SettingsEvent.colorStyleChanged(style: $style)';
}


}

/// @nodoc
abstract mixin class _$SettingsEvent$ColorStyleChangedCopyWith<$Res> implements $SettingsEventCopyWith<$Res> {
  factory _$SettingsEvent$ColorStyleChangedCopyWith(_SettingsEvent$ColorStyleChanged value, $Res Function(_SettingsEvent$ColorStyleChanged) _then) = __$SettingsEvent$ColorStyleChangedCopyWithImpl;
@useResult
$Res call({
 AppColorStyle style
});




}
/// @nodoc
class __$SettingsEvent$ColorStyleChangedCopyWithImpl<$Res>
    implements _$SettingsEvent$ColorStyleChangedCopyWith<$Res> {
  __$SettingsEvent$ColorStyleChangedCopyWithImpl(this._self, this._then);

  final _SettingsEvent$ColorStyleChanged _self;
  final $Res Function(_SettingsEvent$ColorStyleChanged) _then;

/// Create a copy of SettingsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? style = null,}) {
  return _then(_SettingsEvent$ColorStyleChanged(
style: null == style ? _self.style : style // ignore: cast_nullable_to_non_nullable
as AppColorStyle,
  ));
}


}

/// @nodoc


class _SettingsEvent$AnimationDurationChanged implements SettingsEvent {
  const _SettingsEvent$AnimationDurationChanged({required this.value});
  

 final  double value;

/// Create a copy of SettingsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SettingsEvent$AnimationDurationChangedCopyWith<_SettingsEvent$AnimationDurationChanged> get copyWith => __$SettingsEvent$AnimationDurationChangedCopyWithImpl<_SettingsEvent$AnimationDurationChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SettingsEvent$AnimationDurationChanged&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'SettingsEvent.animationDurationChanged(value: $value)';
}


}

/// @nodoc
abstract mixin class _$SettingsEvent$AnimationDurationChangedCopyWith<$Res> implements $SettingsEventCopyWith<$Res> {
  factory _$SettingsEvent$AnimationDurationChangedCopyWith(_SettingsEvent$AnimationDurationChanged value, $Res Function(_SettingsEvent$AnimationDurationChanged) _then) = __$SettingsEvent$AnimationDurationChangedCopyWithImpl;
@useResult
$Res call({
 double value
});




}
/// @nodoc
class __$SettingsEvent$AnimationDurationChangedCopyWithImpl<$Res>
    implements _$SettingsEvent$AnimationDurationChangedCopyWith<$Res> {
  __$SettingsEvent$AnimationDurationChangedCopyWithImpl(this._self, this._then);

  final _SettingsEvent$AnimationDurationChanged _self;
  final $Res Function(_SettingsEvent$AnimationDurationChanged) _then;

/// Create a copy of SettingsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(_SettingsEvent$AnimationDurationChanged(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc


class _SettingsEvent$CardFontSizeChanged implements SettingsEvent {
  const _SettingsEvent$CardFontSizeChanged({required this.value});
  

 final  double value;

/// Create a copy of SettingsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SettingsEvent$CardFontSizeChangedCopyWith<_SettingsEvent$CardFontSizeChanged> get copyWith => __$SettingsEvent$CardFontSizeChangedCopyWithImpl<_SettingsEvent$CardFontSizeChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SettingsEvent$CardFontSizeChanged&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'SettingsEvent.cardFontSizeChanged(value: $value)';
}


}

/// @nodoc
abstract mixin class _$SettingsEvent$CardFontSizeChangedCopyWith<$Res> implements $SettingsEventCopyWith<$Res> {
  factory _$SettingsEvent$CardFontSizeChangedCopyWith(_SettingsEvent$CardFontSizeChanged value, $Res Function(_SettingsEvent$CardFontSizeChanged) _then) = __$SettingsEvent$CardFontSizeChangedCopyWithImpl;
@useResult
$Res call({
 double value
});




}
/// @nodoc
class __$SettingsEvent$CardFontSizeChangedCopyWithImpl<$Res>
    implements _$SettingsEvent$CardFontSizeChangedCopyWith<$Res> {
  __$SettingsEvent$CardFontSizeChangedCopyWithImpl(this._self, this._then);

  final _SettingsEvent$CardFontSizeChanged _self;
  final $Res Function(_SettingsEvent$CardFontSizeChanged) _then;

/// Create a copy of SettingsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(_SettingsEvent$CardFontSizeChanged(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc


class _SettingsEvent$AccentColorHueChanged implements SettingsEvent {
  const _SettingsEvent$AccentColorHueChanged({required this.value});
  

 final  double value;

/// Create a copy of SettingsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SettingsEvent$AccentColorHueChangedCopyWith<_SettingsEvent$AccentColorHueChanged> get copyWith => __$SettingsEvent$AccentColorHueChangedCopyWithImpl<_SettingsEvent$AccentColorHueChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SettingsEvent$AccentColorHueChanged&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'SettingsEvent.accentColorHueChanged(value: $value)';
}


}

/// @nodoc
abstract mixin class _$SettingsEvent$AccentColorHueChangedCopyWith<$Res> implements $SettingsEventCopyWith<$Res> {
  factory _$SettingsEvent$AccentColorHueChangedCopyWith(_SettingsEvent$AccentColorHueChanged value, $Res Function(_SettingsEvent$AccentColorHueChanged) _then) = __$SettingsEvent$AccentColorHueChangedCopyWithImpl;
@useResult
$Res call({
 double value
});




}
/// @nodoc
class __$SettingsEvent$AccentColorHueChangedCopyWithImpl<$Res>
    implements _$SettingsEvent$AccentColorHueChangedCopyWith<$Res> {
  __$SettingsEvent$AccentColorHueChangedCopyWithImpl(this._self, this._then);

  final _SettingsEvent$AccentColorHueChanged _self;
  final $Res Function(_SettingsEvent$AccentColorHueChanged) _then;

/// Create a copy of SettingsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(_SettingsEvent$AccentColorHueChanged(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc


class _SettingsEvent$AccentColorHueCommitted implements SettingsEvent {
  const _SettingsEvent$AccentColorHueCommitted({required this.value});
  

 final  double value;

/// Create a copy of SettingsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SettingsEvent$AccentColorHueCommittedCopyWith<_SettingsEvent$AccentColorHueCommitted> get copyWith => __$SettingsEvent$AccentColorHueCommittedCopyWithImpl<_SettingsEvent$AccentColorHueCommitted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SettingsEvent$AccentColorHueCommitted&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'SettingsEvent.accentColorHueCommitted(value: $value)';
}


}

/// @nodoc
abstract mixin class _$SettingsEvent$AccentColorHueCommittedCopyWith<$Res> implements $SettingsEventCopyWith<$Res> {
  factory _$SettingsEvent$AccentColorHueCommittedCopyWith(_SettingsEvent$AccentColorHueCommitted value, $Res Function(_SettingsEvent$AccentColorHueCommitted) _then) = __$SettingsEvent$AccentColorHueCommittedCopyWithImpl;
@useResult
$Res call({
 double value
});




}
/// @nodoc
class __$SettingsEvent$AccentColorHueCommittedCopyWithImpl<$Res>
    implements _$SettingsEvent$AccentColorHueCommittedCopyWith<$Res> {
  __$SettingsEvent$AccentColorHueCommittedCopyWithImpl(this._self, this._then);

  final _SettingsEvent$AccentColorHueCommitted _self;
  final $Res Function(_SettingsEvent$AccentColorHueCommitted) _then;

/// Create a copy of SettingsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(_SettingsEvent$AccentColorHueCommitted(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc


class _SettingsEvent$StatsExportRequested implements SettingsEvent {
  const _SettingsEvent$StatsExportRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SettingsEvent$StatsExportRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SettingsEvent.statsExportRequested()';
}


}




/// @nodoc
mixin _$SettingsState {

/// Сохранённые настройки.
 SettingsDto get settings;/// Версия приложения — пусто, пока не прочитан `PackageInfo`.
 String get appVersion;/// Оттенок, который тянут прямо сейчас: показывается до записи.
 double? get pendingHue;/// Идёт выгрузка статистики.
 bool get isExporting;/// Одноразовый результат выгрузки — показывается снеком.
 SideEffectValue<StatsExportResult>? get exportResult;
/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SettingsStateCopyWith<SettingsState> get copyWith => _$SettingsStateCopyWithImpl<SettingsState>(this as SettingsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingsState&&(identical(other.settings, settings) || other.settings == settings)&&(identical(other.appVersion, appVersion) || other.appVersion == appVersion)&&(identical(other.pendingHue, pendingHue) || other.pendingHue == pendingHue)&&(identical(other.isExporting, isExporting) || other.isExporting == isExporting)&&(identical(other.exportResult, exportResult) || other.exportResult == exportResult));
}


@override
int get hashCode => Object.hash(runtimeType,settings,appVersion,pendingHue,isExporting,exportResult);

@override
String toString() {
  return 'SettingsState(settings: $settings, appVersion: $appVersion, pendingHue: $pendingHue, isExporting: $isExporting, exportResult: $exportResult)';
}


}

/// @nodoc
abstract mixin class $SettingsStateCopyWith<$Res>  {
  factory $SettingsStateCopyWith(SettingsState value, $Res Function(SettingsState) _then) = _$SettingsStateCopyWithImpl;
@useResult
$Res call({
 SettingsDto settings, String appVersion, double? pendingHue, bool isExporting, SideEffectValue<StatsExportResult>? exportResult
});




}
/// @nodoc
class _$SettingsStateCopyWithImpl<$Res>
    implements $SettingsStateCopyWith<$Res> {
  _$SettingsStateCopyWithImpl(this._self, this._then);

  final SettingsState _self;
  final $Res Function(SettingsState) _then;

/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? settings = null,Object? appVersion = null,Object? pendingHue = freezed,Object? isExporting = null,Object? exportResult = freezed,}) {
  return _then(_self.copyWith(
settings: null == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as SettingsDto,appVersion: null == appVersion ? _self.appVersion : appVersion // ignore: cast_nullable_to_non_nullable
as String,pendingHue: freezed == pendingHue ? _self.pendingHue : pendingHue // ignore: cast_nullable_to_non_nullable
as double?,isExporting: null == isExporting ? _self.isExporting : isExporting // ignore: cast_nullable_to_non_nullable
as bool,exportResult: freezed == exportResult ? _self.exportResult : exportResult // ignore: cast_nullable_to_non_nullable
as SideEffectValue<StatsExportResult>?,
  ));
}

}


/// Adds pattern-matching-related methods to [SettingsState].
extension SettingsStatePatterns on SettingsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SettingsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SettingsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SettingsState value)  $default,){
final _that = this;
switch (_that) {
case _SettingsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SettingsState value)?  $default,){
final _that = this;
switch (_that) {
case _SettingsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SettingsDto settings,  String appVersion,  double? pendingHue,  bool isExporting,  SideEffectValue<StatsExportResult>? exportResult)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SettingsState() when $default != null:
return $default(_that.settings,_that.appVersion,_that.pendingHue,_that.isExporting,_that.exportResult);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SettingsDto settings,  String appVersion,  double? pendingHue,  bool isExporting,  SideEffectValue<StatsExportResult>? exportResult)  $default,) {final _that = this;
switch (_that) {
case _SettingsState():
return $default(_that.settings,_that.appVersion,_that.pendingHue,_that.isExporting,_that.exportResult);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SettingsDto settings,  String appVersion,  double? pendingHue,  bool isExporting,  SideEffectValue<StatsExportResult>? exportResult)?  $default,) {final _that = this;
switch (_that) {
case _SettingsState() when $default != null:
return $default(_that.settings,_that.appVersion,_that.pendingHue,_that.isExporting,_that.exportResult);case _:
  return null;

}
}

}

/// @nodoc


class _SettingsState extends SettingsState {
  const _SettingsState({required this.settings, this.appVersion = '', this.pendingHue, this.isExporting = false, this.exportResult}): super._();
  

/// Сохранённые настройки.
@override final  SettingsDto settings;
/// Версия приложения — пусто, пока не прочитан `PackageInfo`.
@override@JsonKey() final  String appVersion;
/// Оттенок, который тянут прямо сейчас: показывается до записи.
@override final  double? pendingHue;
/// Идёт выгрузка статистики.
@override@JsonKey() final  bool isExporting;
/// Одноразовый результат выгрузки — показывается снеком.
@override final  SideEffectValue<StatsExportResult>? exportResult;

/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SettingsStateCopyWith<_SettingsState> get copyWith => __$SettingsStateCopyWithImpl<_SettingsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SettingsState&&(identical(other.settings, settings) || other.settings == settings)&&(identical(other.appVersion, appVersion) || other.appVersion == appVersion)&&(identical(other.pendingHue, pendingHue) || other.pendingHue == pendingHue)&&(identical(other.isExporting, isExporting) || other.isExporting == isExporting)&&(identical(other.exportResult, exportResult) || other.exportResult == exportResult));
}


@override
int get hashCode => Object.hash(runtimeType,settings,appVersion,pendingHue,isExporting,exportResult);

@override
String toString() {
  return 'SettingsState(settings: $settings, appVersion: $appVersion, pendingHue: $pendingHue, isExporting: $isExporting, exportResult: $exportResult)';
}


}

/// @nodoc
abstract mixin class _$SettingsStateCopyWith<$Res> implements $SettingsStateCopyWith<$Res> {
  factory _$SettingsStateCopyWith(_SettingsState value, $Res Function(_SettingsState) _then) = __$SettingsStateCopyWithImpl;
@override @useResult
$Res call({
 SettingsDto settings, String appVersion, double? pendingHue, bool isExporting, SideEffectValue<StatsExportResult>? exportResult
});




}
/// @nodoc
class __$SettingsStateCopyWithImpl<$Res>
    implements _$SettingsStateCopyWith<$Res> {
  __$SettingsStateCopyWithImpl(this._self, this._then);

  final _SettingsState _self;
  final $Res Function(_SettingsState) _then;

/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? settings = null,Object? appVersion = null,Object? pendingHue = freezed,Object? isExporting = null,Object? exportResult = freezed,}) {
  return _then(_SettingsState(
settings: null == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as SettingsDto,appVersion: null == appVersion ? _self.appVersion : appVersion // ignore: cast_nullable_to_non_nullable
as String,pendingHue: freezed == pendingHue ? _self.pendingHue : pendingHue // ignore: cast_nullable_to_non_nullable
as double?,isExporting: null == isExporting ? _self.isExporting : isExporting // ignore: cast_nullable_to_non_nullable
as bool,exportResult: freezed == exportResult ? _self.exportResult : exportResult // ignore: cast_nullable_to_non_nullable
as SideEffectValue<StatsExportResult>?,
  ));
}


}

// dart format on
