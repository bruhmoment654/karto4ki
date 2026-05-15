// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'active_test_session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ActiveTestSession {
  /// Прогресс прохождения и карточки.
  TestSession get session => throw _privateConstructorUsedError;

  /// Параметры, с которыми тест был запущен.
  ActiveSessionLaunchParams get params => throw _privateConstructorUsedError;

  /// Название теста — для отображения в карточке «Продолжить».
  String get testTitle => throw _privateConstructorUsedError;

  /// Момент последнего сохранения.
  DateTime get updatedAt => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ActiveTestSessionCopyWith<ActiveTestSession> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActiveTestSessionCopyWith<$Res> {
  factory $ActiveTestSessionCopyWith(
          ActiveTestSession value, $Res Function(ActiveTestSession) then) =
      _$ActiveTestSessionCopyWithImpl<$Res, ActiveTestSession>;
  @useResult
  $Res call(
      {TestSession session,
      ActiveSessionLaunchParams params,
      String testTitle,
      DateTime updatedAt});

  $TestSessionCopyWith<$Res> get session;
  $ActiveSessionLaunchParamsCopyWith<$Res> get params;
}

/// @nodoc
class _$ActiveTestSessionCopyWithImpl<$Res, $Val extends ActiveTestSession>
    implements $ActiveTestSessionCopyWith<$Res> {
  _$ActiveTestSessionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? session = null,
    Object? params = null,
    Object? testTitle = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      session: null == session
          ? _value.session
          : session // ignore: cast_nullable_to_non_nullable
              as TestSession,
      params: null == params
          ? _value.params
          : params // ignore: cast_nullable_to_non_nullable
              as ActiveSessionLaunchParams,
      testTitle: null == testTitle
          ? _value.testTitle
          : testTitle // ignore: cast_nullable_to_non_nullable
              as String,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $TestSessionCopyWith<$Res> get session {
    return $TestSessionCopyWith<$Res>(_value.session, (value) {
      return _then(_value.copyWith(session: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ActiveSessionLaunchParamsCopyWith<$Res> get params {
    return $ActiveSessionLaunchParamsCopyWith<$Res>(_value.params, (value) {
      return _then(_value.copyWith(params: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ActiveTestSessionImplCopyWith<$Res>
    implements $ActiveTestSessionCopyWith<$Res> {
  factory _$$ActiveTestSessionImplCopyWith(_$ActiveTestSessionImpl value,
          $Res Function(_$ActiveTestSessionImpl) then) =
      __$$ActiveTestSessionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {TestSession session,
      ActiveSessionLaunchParams params,
      String testTitle,
      DateTime updatedAt});

  @override
  $TestSessionCopyWith<$Res> get session;
  @override
  $ActiveSessionLaunchParamsCopyWith<$Res> get params;
}

/// @nodoc
class __$$ActiveTestSessionImplCopyWithImpl<$Res>
    extends _$ActiveTestSessionCopyWithImpl<$Res, _$ActiveTestSessionImpl>
    implements _$$ActiveTestSessionImplCopyWith<$Res> {
  __$$ActiveTestSessionImplCopyWithImpl(_$ActiveTestSessionImpl _value,
      $Res Function(_$ActiveTestSessionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? session = null,
    Object? params = null,
    Object? testTitle = null,
    Object? updatedAt = null,
  }) {
    return _then(_$ActiveTestSessionImpl(
      session: null == session
          ? _value.session
          : session // ignore: cast_nullable_to_non_nullable
              as TestSession,
      params: null == params
          ? _value.params
          : params // ignore: cast_nullable_to_non_nullable
              as ActiveSessionLaunchParams,
      testTitle: null == testTitle
          ? _value.testTitle
          : testTitle // ignore: cast_nullable_to_non_nullable
              as String,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$ActiveTestSessionImpl implements _ActiveTestSession {
  const _$ActiveTestSessionImpl(
      {required this.session,
      required this.params,
      required this.testTitle,
      required this.updatedAt});

  /// Прогресс прохождения и карточки.
  @override
  final TestSession session;

  /// Параметры, с которыми тест был запущен.
  @override
  final ActiveSessionLaunchParams params;

  /// Название теста — для отображения в карточке «Продолжить».
  @override
  final String testTitle;

  /// Момент последнего сохранения.
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'ActiveTestSession(session: $session, params: $params, testTitle: $testTitle, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActiveTestSessionImpl &&
            (identical(other.session, session) || other.session == session) &&
            (identical(other.params, params) || other.params == params) &&
            (identical(other.testTitle, testTitle) ||
                other.testTitle == testTitle) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, session, params, testTitle, updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ActiveTestSessionImplCopyWith<_$ActiveTestSessionImpl> get copyWith =>
      __$$ActiveTestSessionImplCopyWithImpl<_$ActiveTestSessionImpl>(
          this, _$identity);
}

abstract class _ActiveTestSession implements ActiveTestSession {
  const factory _ActiveTestSession(
      {required final TestSession session,
      required final ActiveSessionLaunchParams params,
      required final String testTitle,
      required final DateTime updatedAt}) = _$ActiveTestSessionImpl;

  @override

  /// Прогресс прохождения и карточки.
  TestSession get session;
  @override

  /// Параметры, с которыми тест был запущен.
  ActiveSessionLaunchParams get params;
  @override

  /// Название теста — для отображения в карточке «Продолжить».
  String get testTitle;
  @override

  /// Момент последнего сохранения.
  DateTime get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$ActiveTestSessionImplCopyWith<_$ActiveTestSessionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
