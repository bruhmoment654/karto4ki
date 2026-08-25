// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_summary_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ProfileSummaryEntity {
  /// Всего ответов: сумма верных и неверных по всем карточкам.
  int get answersTotal => throw _privateConstructorUsedError;

  /// Всего верных ответов.
  int get correctTotal => throw _privateConstructorUsedError;

  /// Точность в процентах (0..100), 0 если ответов не было.
  int get accuracyPercent => throw _privateConstructorUsedError;

  /// Всего карточек со статистикой.
  int get totalCards => throw _privateConstructorUsedError;

  /// Карточек со streak >= [kMasteredThreshold].
  int get masteredCount => throw _privateConstructorUsedError;

  /// Доля изученных карточек в процентах (0..100).
  int get masteredPercent => throw _privateConstructorUsedError;

  /// Карточек без единой ошибки (`totalIncorrect == 0 && totalShown > 0`).
  int get flawlessCount => throw _privateConstructorUsedError;

  /// Доля безошибочных карточек в процентах (0..100).
  int get flawlessPercent => throw _privateConstructorUsedError;

  /// Слабых карточек: streak < [kWeakThreshold].
  int get weakCardsCount => throw _privateConstructorUsedError;

  /// Текущая серия активных дней подряд.
  int get currentStreak => throw _privateConstructorUsedError;

  /// Лучшая (рекордная) серия активных дней подряд.
  int get bestStreak => throw _privateConstructorUsedError;

  /// Всего дней активности.
  int get activeDaysCount => throw _privateConstructorUsedError;

  /// Среднее число ответов в день активности (0 если дней нет).
  double get avgAnswersPerDay => throw _privateConstructorUsedError;

  /// Активность по дням текущей недели: 7 значений Пн..Вс.
  List<bool> get weekActivity => throw _privateConstructorUsedError;

  /// Количество групп — для карточки-идентичности.
  int get groupsCount => throw _privateConstructorUsedError;

  /// Количество тестов — для карточки-идентичности.
  int get testsCount => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ProfileSummaryEntityCopyWith<ProfileSummaryEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileSummaryEntityCopyWith<$Res> {
  factory $ProfileSummaryEntityCopyWith(ProfileSummaryEntity value,
          $Res Function(ProfileSummaryEntity) then) =
      _$ProfileSummaryEntityCopyWithImpl<$Res, ProfileSummaryEntity>;
  @useResult
  $Res call(
      {int answersTotal,
      int correctTotal,
      int accuracyPercent,
      int totalCards,
      int masteredCount,
      int masteredPercent,
      int flawlessCount,
      int flawlessPercent,
      int weakCardsCount,
      int currentStreak,
      int bestStreak,
      int activeDaysCount,
      double avgAnswersPerDay,
      List<bool> weekActivity,
      int groupsCount,
      int testsCount});
}

/// @nodoc
class _$ProfileSummaryEntityCopyWithImpl<$Res,
        $Val extends ProfileSummaryEntity>
    implements $ProfileSummaryEntityCopyWith<$Res> {
  _$ProfileSummaryEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? answersTotal = null,
    Object? correctTotal = null,
    Object? accuracyPercent = null,
    Object? totalCards = null,
    Object? masteredCount = null,
    Object? masteredPercent = null,
    Object? flawlessCount = null,
    Object? flawlessPercent = null,
    Object? weakCardsCount = null,
    Object? currentStreak = null,
    Object? bestStreak = null,
    Object? activeDaysCount = null,
    Object? avgAnswersPerDay = null,
    Object? weekActivity = null,
    Object? groupsCount = null,
    Object? testsCount = null,
  }) {
    return _then(_value.copyWith(
      answersTotal: null == answersTotal
          ? _value.answersTotal
          : answersTotal // ignore: cast_nullable_to_non_nullable
              as int,
      correctTotal: null == correctTotal
          ? _value.correctTotal
          : correctTotal // ignore: cast_nullable_to_non_nullable
              as int,
      accuracyPercent: null == accuracyPercent
          ? _value.accuracyPercent
          : accuracyPercent // ignore: cast_nullable_to_non_nullable
              as int,
      totalCards: null == totalCards
          ? _value.totalCards
          : totalCards // ignore: cast_nullable_to_non_nullable
              as int,
      masteredCount: null == masteredCount
          ? _value.masteredCount
          : masteredCount // ignore: cast_nullable_to_non_nullable
              as int,
      masteredPercent: null == masteredPercent
          ? _value.masteredPercent
          : masteredPercent // ignore: cast_nullable_to_non_nullable
              as int,
      flawlessCount: null == flawlessCount
          ? _value.flawlessCount
          : flawlessCount // ignore: cast_nullable_to_non_nullable
              as int,
      flawlessPercent: null == flawlessPercent
          ? _value.flawlessPercent
          : flawlessPercent // ignore: cast_nullable_to_non_nullable
              as int,
      weakCardsCount: null == weakCardsCount
          ? _value.weakCardsCount
          : weakCardsCount // ignore: cast_nullable_to_non_nullable
              as int,
      currentStreak: null == currentStreak
          ? _value.currentStreak
          : currentStreak // ignore: cast_nullable_to_non_nullable
              as int,
      bestStreak: null == bestStreak
          ? _value.bestStreak
          : bestStreak // ignore: cast_nullable_to_non_nullable
              as int,
      activeDaysCount: null == activeDaysCount
          ? _value.activeDaysCount
          : activeDaysCount // ignore: cast_nullable_to_non_nullable
              as int,
      avgAnswersPerDay: null == avgAnswersPerDay
          ? _value.avgAnswersPerDay
          : avgAnswersPerDay // ignore: cast_nullable_to_non_nullable
              as double,
      weekActivity: null == weekActivity
          ? _value.weekActivity
          : weekActivity // ignore: cast_nullable_to_non_nullable
              as List<bool>,
      groupsCount: null == groupsCount
          ? _value.groupsCount
          : groupsCount // ignore: cast_nullable_to_non_nullable
              as int,
      testsCount: null == testsCount
          ? _value.testsCount
          : testsCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProfileSummaryEntityImplCopyWith<$Res>
    implements $ProfileSummaryEntityCopyWith<$Res> {
  factory _$$ProfileSummaryEntityImplCopyWith(_$ProfileSummaryEntityImpl value,
          $Res Function(_$ProfileSummaryEntityImpl) then) =
      __$$ProfileSummaryEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int answersTotal,
      int correctTotal,
      int accuracyPercent,
      int totalCards,
      int masteredCount,
      int masteredPercent,
      int flawlessCount,
      int flawlessPercent,
      int weakCardsCount,
      int currentStreak,
      int bestStreak,
      int activeDaysCount,
      double avgAnswersPerDay,
      List<bool> weekActivity,
      int groupsCount,
      int testsCount});
}

/// @nodoc
class __$$ProfileSummaryEntityImplCopyWithImpl<$Res>
    extends _$ProfileSummaryEntityCopyWithImpl<$Res, _$ProfileSummaryEntityImpl>
    implements _$$ProfileSummaryEntityImplCopyWith<$Res> {
  __$$ProfileSummaryEntityImplCopyWithImpl(_$ProfileSummaryEntityImpl _value,
      $Res Function(_$ProfileSummaryEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? answersTotal = null,
    Object? correctTotal = null,
    Object? accuracyPercent = null,
    Object? totalCards = null,
    Object? masteredCount = null,
    Object? masteredPercent = null,
    Object? flawlessCount = null,
    Object? flawlessPercent = null,
    Object? weakCardsCount = null,
    Object? currentStreak = null,
    Object? bestStreak = null,
    Object? activeDaysCount = null,
    Object? avgAnswersPerDay = null,
    Object? weekActivity = null,
    Object? groupsCount = null,
    Object? testsCount = null,
  }) {
    return _then(_$ProfileSummaryEntityImpl(
      answersTotal: null == answersTotal
          ? _value.answersTotal
          : answersTotal // ignore: cast_nullable_to_non_nullable
              as int,
      correctTotal: null == correctTotal
          ? _value.correctTotal
          : correctTotal // ignore: cast_nullable_to_non_nullable
              as int,
      accuracyPercent: null == accuracyPercent
          ? _value.accuracyPercent
          : accuracyPercent // ignore: cast_nullable_to_non_nullable
              as int,
      totalCards: null == totalCards
          ? _value.totalCards
          : totalCards // ignore: cast_nullable_to_non_nullable
              as int,
      masteredCount: null == masteredCount
          ? _value.masteredCount
          : masteredCount // ignore: cast_nullable_to_non_nullable
              as int,
      masteredPercent: null == masteredPercent
          ? _value.masteredPercent
          : masteredPercent // ignore: cast_nullable_to_non_nullable
              as int,
      flawlessCount: null == flawlessCount
          ? _value.flawlessCount
          : flawlessCount // ignore: cast_nullable_to_non_nullable
              as int,
      flawlessPercent: null == flawlessPercent
          ? _value.flawlessPercent
          : flawlessPercent // ignore: cast_nullable_to_non_nullable
              as int,
      weakCardsCount: null == weakCardsCount
          ? _value.weakCardsCount
          : weakCardsCount // ignore: cast_nullable_to_non_nullable
              as int,
      currentStreak: null == currentStreak
          ? _value.currentStreak
          : currentStreak // ignore: cast_nullable_to_non_nullable
              as int,
      bestStreak: null == bestStreak
          ? _value.bestStreak
          : bestStreak // ignore: cast_nullable_to_non_nullable
              as int,
      activeDaysCount: null == activeDaysCount
          ? _value.activeDaysCount
          : activeDaysCount // ignore: cast_nullable_to_non_nullable
              as int,
      avgAnswersPerDay: null == avgAnswersPerDay
          ? _value.avgAnswersPerDay
          : avgAnswersPerDay // ignore: cast_nullable_to_non_nullable
              as double,
      weekActivity: null == weekActivity
          ? _value._weekActivity
          : weekActivity // ignore: cast_nullable_to_non_nullable
              as List<bool>,
      groupsCount: null == groupsCount
          ? _value.groupsCount
          : groupsCount // ignore: cast_nullable_to_non_nullable
              as int,
      testsCount: null == testsCount
          ? _value.testsCount
          : testsCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$ProfileSummaryEntityImpl implements _ProfileSummaryEntity {
  const _$ProfileSummaryEntityImpl(
      {required this.answersTotal,
      required this.correctTotal,
      required this.accuracyPercent,
      required this.totalCards,
      required this.masteredCount,
      required this.masteredPercent,
      required this.flawlessCount,
      required this.flawlessPercent,
      required this.weakCardsCount,
      required this.currentStreak,
      required this.bestStreak,
      required this.activeDaysCount,
      required this.avgAnswersPerDay,
      required final List<bool> weekActivity,
      required this.groupsCount,
      required this.testsCount})
      : _weekActivity = weekActivity;

  /// Всего ответов: сумма верных и неверных по всем карточкам.
  @override
  final int answersTotal;

  /// Всего верных ответов.
  @override
  final int correctTotal;

  /// Точность в процентах (0..100), 0 если ответов не было.
  @override
  final int accuracyPercent;

  /// Всего карточек со статистикой.
  @override
  final int totalCards;

  /// Карточек со streak >= [kMasteredThreshold].
  @override
  final int masteredCount;

  /// Доля изученных карточек в процентах (0..100).
  @override
  final int masteredPercent;

  /// Карточек без единой ошибки (`totalIncorrect == 0 && totalShown > 0`).
  @override
  final int flawlessCount;

  /// Доля безошибочных карточек в процентах (0..100).
  @override
  final int flawlessPercent;

  /// Слабых карточек: streak < [kWeakThreshold].
  @override
  final int weakCardsCount;

  /// Текущая серия активных дней подряд.
  @override
  final int currentStreak;

  /// Лучшая (рекордная) серия активных дней подряд.
  @override
  final int bestStreak;

  /// Всего дней активности.
  @override
  final int activeDaysCount;

  /// Среднее число ответов в день активности (0 если дней нет).
  @override
  final double avgAnswersPerDay;

  /// Активность по дням текущей недели: 7 значений Пн..Вс.
  final List<bool> _weekActivity;

  /// Активность по дням текущей недели: 7 значений Пн..Вс.
  @override
  List<bool> get weekActivity {
    if (_weekActivity is EqualUnmodifiableListView) return _weekActivity;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_weekActivity);
  }

  /// Количество групп — для карточки-идентичности.
  @override
  final int groupsCount;

  /// Количество тестов — для карточки-идентичности.
  @override
  final int testsCount;

  @override
  String toString() {
    return 'ProfileSummaryEntity(answersTotal: $answersTotal, correctTotal: $correctTotal, accuracyPercent: $accuracyPercent, totalCards: $totalCards, masteredCount: $masteredCount, masteredPercent: $masteredPercent, flawlessCount: $flawlessCount, flawlessPercent: $flawlessPercent, weakCardsCount: $weakCardsCount, currentStreak: $currentStreak, bestStreak: $bestStreak, activeDaysCount: $activeDaysCount, avgAnswersPerDay: $avgAnswersPerDay, weekActivity: $weekActivity, groupsCount: $groupsCount, testsCount: $testsCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileSummaryEntityImpl &&
            (identical(other.answersTotal, answersTotal) ||
                other.answersTotal == answersTotal) &&
            (identical(other.correctTotal, correctTotal) ||
                other.correctTotal == correctTotal) &&
            (identical(other.accuracyPercent, accuracyPercent) ||
                other.accuracyPercent == accuracyPercent) &&
            (identical(other.totalCards, totalCards) ||
                other.totalCards == totalCards) &&
            (identical(other.masteredCount, masteredCount) ||
                other.masteredCount == masteredCount) &&
            (identical(other.masteredPercent, masteredPercent) ||
                other.masteredPercent == masteredPercent) &&
            (identical(other.flawlessCount, flawlessCount) ||
                other.flawlessCount == flawlessCount) &&
            (identical(other.flawlessPercent, flawlessPercent) ||
                other.flawlessPercent == flawlessPercent) &&
            (identical(other.weakCardsCount, weakCardsCount) ||
                other.weakCardsCount == weakCardsCount) &&
            (identical(other.currentStreak, currentStreak) ||
                other.currentStreak == currentStreak) &&
            (identical(other.bestStreak, bestStreak) ||
                other.bestStreak == bestStreak) &&
            (identical(other.activeDaysCount, activeDaysCount) ||
                other.activeDaysCount == activeDaysCount) &&
            (identical(other.avgAnswersPerDay, avgAnswersPerDay) ||
                other.avgAnswersPerDay == avgAnswersPerDay) &&
            const DeepCollectionEquality()
                .equals(other._weekActivity, _weekActivity) &&
            (identical(other.groupsCount, groupsCount) ||
                other.groupsCount == groupsCount) &&
            (identical(other.testsCount, testsCount) ||
                other.testsCount == testsCount));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      answersTotal,
      correctTotal,
      accuracyPercent,
      totalCards,
      masteredCount,
      masteredPercent,
      flawlessCount,
      flawlessPercent,
      weakCardsCount,
      currentStreak,
      bestStreak,
      activeDaysCount,
      avgAnswersPerDay,
      const DeepCollectionEquality().hash(_weekActivity),
      groupsCount,
      testsCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileSummaryEntityImplCopyWith<_$ProfileSummaryEntityImpl>
      get copyWith =>
          __$$ProfileSummaryEntityImplCopyWithImpl<_$ProfileSummaryEntityImpl>(
              this, _$identity);
}

abstract class _ProfileSummaryEntity implements ProfileSummaryEntity {
  const factory _ProfileSummaryEntity(
      {required final int answersTotal,
      required final int correctTotal,
      required final int accuracyPercent,
      required final int totalCards,
      required final int masteredCount,
      required final int masteredPercent,
      required final int flawlessCount,
      required final int flawlessPercent,
      required final int weakCardsCount,
      required final int currentStreak,
      required final int bestStreak,
      required final int activeDaysCount,
      required final double avgAnswersPerDay,
      required final List<bool> weekActivity,
      required final int groupsCount,
      required final int testsCount}) = _$ProfileSummaryEntityImpl;

  @override

  /// Всего ответов: сумма верных и неверных по всем карточкам.
  int get answersTotal;
  @override

  /// Всего верных ответов.
  int get correctTotal;
  @override

  /// Точность в процентах (0..100), 0 если ответов не было.
  int get accuracyPercent;
  @override

  /// Всего карточек со статистикой.
  int get totalCards;
  @override

  /// Карточек со streak >= [kMasteredThreshold].
  int get masteredCount;
  @override

  /// Доля изученных карточек в процентах (0..100).
  int get masteredPercent;
  @override

  /// Карточек без единой ошибки (`totalIncorrect == 0 && totalShown > 0`).
  int get flawlessCount;
  @override

  /// Доля безошибочных карточек в процентах (0..100).
  int get flawlessPercent;
  @override

  /// Слабых карточек: streak < [kWeakThreshold].
  int get weakCardsCount;
  @override

  /// Текущая серия активных дней подряд.
  int get currentStreak;
  @override

  /// Лучшая (рекордная) серия активных дней подряд.
  int get bestStreak;
  @override

  /// Всего дней активности.
  int get activeDaysCount;
  @override

  /// Среднее число ответов в день активности (0 если дней нет).
  double get avgAnswersPerDay;
  @override

  /// Активность по дням текущей недели: 7 значений Пн..Вс.
  List<bool> get weekActivity;
  @override

  /// Количество групп — для карточки-идентичности.
  int get groupsCount;
  @override

  /// Количество тестов — для карточки-идентичности.
  int get testsCount;
  @override
  @JsonKey(ignore: true)
  _$$ProfileSummaryEntityImplCopyWith<_$ProfileSummaryEntityImpl>
      get copyWith => throw _privateConstructorUsedError;
}
