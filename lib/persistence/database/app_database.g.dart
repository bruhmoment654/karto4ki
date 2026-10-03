// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class TestAttempts extends Table
    with TableInfo<TestAttempts, TestAttemptDatabaseDto> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  TestAttempts(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL PRIMARY KEY',
  );
  static const VerificationMeta _testIdMeta = const VerificationMeta('testId');
  late final GeneratedColumn<String> testId = GeneratedColumn<String>(
    'test_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _totalMeta = const VerificationMeta('total');
  late final GeneratedColumn<int> total = GeneratedColumn<int>(
    'total',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _correctMeta = const VerificationMeta(
    'correct',
  );
  late final GeneratedColumn<int> correct = GeneratedColumn<int>(
    'correct',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _mixupMeta = const VerificationMeta('mixup');
  late final GeneratedColumn<bool> mixup = GeneratedColumn<bool>(
    'mixup',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _swapSidesMeta = const VerificationMeta(
    'swapSides',
  );
  late final GeneratedColumn<bool> swapSides = GeneratedColumn<bool>(
    'swap_sides',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    testId,
    startedAt,
    completedAt,
    total,
    correct,
    mixup,
    swapSides,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'test_attempts';
  @override
  VerificationContext validateIntegrity(
    Insertable<TestAttemptDatabaseDto> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('test_id')) {
      context.handle(
        _testIdMeta,
        testId.isAcceptableOrUnknown(data['test_id']!, _testIdMeta),
      );
    } else if (isInserting) {
      context.missing(_testIdMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_completedAtMeta);
    }
    if (data.containsKey('total')) {
      context.handle(
        _totalMeta,
        total.isAcceptableOrUnknown(data['total']!, _totalMeta),
      );
    } else if (isInserting) {
      context.missing(_totalMeta);
    }
    if (data.containsKey('correct')) {
      context.handle(
        _correctMeta,
        correct.isAcceptableOrUnknown(data['correct']!, _correctMeta),
      );
    } else if (isInserting) {
      context.missing(_correctMeta);
    }
    if (data.containsKey('mixup')) {
      context.handle(
        _mixupMeta,
        mixup.isAcceptableOrUnknown(data['mixup']!, _mixupMeta),
      );
    } else if (isInserting) {
      context.missing(_mixupMeta);
    }
    if (data.containsKey('swap_sides')) {
      context.handle(
        _swapSidesMeta,
        swapSides.isAcceptableOrUnknown(data['swap_sides']!, _swapSidesMeta),
      );
    } else if (isInserting) {
      context.missing(_swapSidesMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TestAttemptDatabaseDto map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TestAttemptDatabaseDto(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      testId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}test_id'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      )!,
      total: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total'],
      )!,
      correct: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}correct'],
      )!,
      mixup: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}mixup'],
      )!,
      swapSides: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}swap_sides'],
      )!,
    );
  }

  @override
  TestAttempts createAlias(String alias) {
    return TestAttempts(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class TestAttemptDatabaseDto extends DataClass
    implements Insertable<TestAttemptDatabaseDto> {
  final String id;
  final String testId;
  final DateTime startedAt;
  final DateTime completedAt;
  final int total;
  final int correct;
  final bool mixup;
  final bool swapSides;
  const TestAttemptDatabaseDto({
    required this.id,
    required this.testId,
    required this.startedAt,
    required this.completedAt,
    required this.total,
    required this.correct,
    required this.mixup,
    required this.swapSides,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['test_id'] = Variable<String>(testId);
    map['started_at'] = Variable<DateTime>(startedAt);
    map['completed_at'] = Variable<DateTime>(completedAt);
    map['total'] = Variable<int>(total);
    map['correct'] = Variable<int>(correct);
    map['mixup'] = Variable<bool>(mixup);
    map['swap_sides'] = Variable<bool>(swapSides);
    return map;
  }

  TestAttemptsCompanion toCompanion(bool nullToAbsent) {
    return TestAttemptsCompanion(
      id: Value(id),
      testId: Value(testId),
      startedAt: Value(startedAt),
      completedAt: Value(completedAt),
      total: Value(total),
      correct: Value(correct),
      mixup: Value(mixup),
      swapSides: Value(swapSides),
    );
  }

  factory TestAttemptDatabaseDto.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TestAttemptDatabaseDto(
      id: serializer.fromJson<String>(json['id']),
      testId: serializer.fromJson<String>(json['test_id']),
      startedAt: serializer.fromJson<DateTime>(json['started_at']),
      completedAt: serializer.fromJson<DateTime>(json['completed_at']),
      total: serializer.fromJson<int>(json['total']),
      correct: serializer.fromJson<int>(json['correct']),
      mixup: serializer.fromJson<bool>(json['mixup']),
      swapSides: serializer.fromJson<bool>(json['swap_sides']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'test_id': serializer.toJson<String>(testId),
      'started_at': serializer.toJson<DateTime>(startedAt),
      'completed_at': serializer.toJson<DateTime>(completedAt),
      'total': serializer.toJson<int>(total),
      'correct': serializer.toJson<int>(correct),
      'mixup': serializer.toJson<bool>(mixup),
      'swap_sides': serializer.toJson<bool>(swapSides),
    };
  }

  TestAttemptDatabaseDto copyWith({
    String? id,
    String? testId,
    DateTime? startedAt,
    DateTime? completedAt,
    int? total,
    int? correct,
    bool? mixup,
    bool? swapSides,
  }) => TestAttemptDatabaseDto(
    id: id ?? this.id,
    testId: testId ?? this.testId,
    startedAt: startedAt ?? this.startedAt,
    completedAt: completedAt ?? this.completedAt,
    total: total ?? this.total,
    correct: correct ?? this.correct,
    mixup: mixup ?? this.mixup,
    swapSides: swapSides ?? this.swapSides,
  );
  TestAttemptDatabaseDto copyWithCompanion(TestAttemptsCompanion data) {
    return TestAttemptDatabaseDto(
      id: data.id.present ? data.id.value : this.id,
      testId: data.testId.present ? data.testId.value : this.testId,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
      total: data.total.present ? data.total.value : this.total,
      correct: data.correct.present ? data.correct.value : this.correct,
      mixup: data.mixup.present ? data.mixup.value : this.mixup,
      swapSides: data.swapSides.present ? data.swapSides.value : this.swapSides,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TestAttemptDatabaseDto(')
          ..write('id: $id, ')
          ..write('testId: $testId, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('total: $total, ')
          ..write('correct: $correct, ')
          ..write('mixup: $mixup, ')
          ..write('swapSides: $swapSides')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    testId,
    startedAt,
    completedAt,
    total,
    correct,
    mixup,
    swapSides,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TestAttemptDatabaseDto &&
          other.id == this.id &&
          other.testId == this.testId &&
          other.startedAt == this.startedAt &&
          other.completedAt == this.completedAt &&
          other.total == this.total &&
          other.correct == this.correct &&
          other.mixup == this.mixup &&
          other.swapSides == this.swapSides);
}

class TestAttemptsCompanion extends UpdateCompanion<TestAttemptDatabaseDto> {
  final Value<String> id;
  final Value<String> testId;
  final Value<DateTime> startedAt;
  final Value<DateTime> completedAt;
  final Value<int> total;
  final Value<int> correct;
  final Value<bool> mixup;
  final Value<bool> swapSides;
  final Value<int> rowid;
  const TestAttemptsCompanion({
    this.id = const Value.absent(),
    this.testId = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.total = const Value.absent(),
    this.correct = const Value.absent(),
    this.mixup = const Value.absent(),
    this.swapSides = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TestAttemptsCompanion.insert({
    required String id,
    required String testId,
    required DateTime startedAt,
    required DateTime completedAt,
    required int total,
    required int correct,
    required bool mixup,
    required bool swapSides,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       testId = Value(testId),
       startedAt = Value(startedAt),
       completedAt = Value(completedAt),
       total = Value(total),
       correct = Value(correct),
       mixup = Value(mixup),
       swapSides = Value(swapSides);
  static Insertable<TestAttemptDatabaseDto> custom({
    Expression<String>? id,
    Expression<String>? testId,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? completedAt,
    Expression<int>? total,
    Expression<int>? correct,
    Expression<bool>? mixup,
    Expression<bool>? swapSides,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (testId != null) 'test_id': testId,
      if (startedAt != null) 'started_at': startedAt,
      if (completedAt != null) 'completed_at': completedAt,
      if (total != null) 'total': total,
      if (correct != null) 'correct': correct,
      if (mixup != null) 'mixup': mixup,
      if (swapSides != null) 'swap_sides': swapSides,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TestAttemptsCompanion copyWith({
    Value<String>? id,
    Value<String>? testId,
    Value<DateTime>? startedAt,
    Value<DateTime>? completedAt,
    Value<int>? total,
    Value<int>? correct,
    Value<bool>? mixup,
    Value<bool>? swapSides,
    Value<int>? rowid,
  }) {
    return TestAttemptsCompanion(
      id: id ?? this.id,
      testId: testId ?? this.testId,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
      total: total ?? this.total,
      correct: correct ?? this.correct,
      mixup: mixup ?? this.mixup,
      swapSides: swapSides ?? this.swapSides,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (testId.present) {
      map['test_id'] = Variable<String>(testId.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (total.present) {
      map['total'] = Variable<int>(total.value);
    }
    if (correct.present) {
      map['correct'] = Variable<int>(correct.value);
    }
    if (mixup.present) {
      map['mixup'] = Variable<bool>(mixup.value);
    }
    if (swapSides.present) {
      map['swap_sides'] = Variable<bool>(swapSides.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TestAttemptsCompanion(')
          ..write('id: $id, ')
          ..write('testId: $testId, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('total: $total, ')
          ..write('correct: $correct, ')
          ..write('mixup: $mixup, ')
          ..write('swapSides: $swapSides, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class TestAttemptAnswers extends Table
    with TableInfo<TestAttemptAnswers, TestAttemptAnswerDatabaseDto> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  TestAttemptAnswers(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT',
  );
  static const VerificationMeta _attemptIdMeta = const VerificationMeta(
    'attemptId',
  );
  late final GeneratedColumn<String> attemptId = GeneratedColumn<String>(
    'attempt_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _questionKeyMeta = const VerificationMeta(
    'questionKey',
  );
  late final GeneratedColumn<String> questionKey = GeneratedColumn<String>(
    'question_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _isCorrectMeta = const VerificationMeta(
    'isCorrect',
  );
  late final GeneratedColumn<bool> isCorrect = GeneratedColumn<bool>(
    'is_correct',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [id, attemptId, questionKey, isCorrect];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'test_attempt_answers';
  @override
  VerificationContext validateIntegrity(
    Insertable<TestAttemptAnswerDatabaseDto> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('attempt_id')) {
      context.handle(
        _attemptIdMeta,
        attemptId.isAcceptableOrUnknown(data['attempt_id']!, _attemptIdMeta),
      );
    } else if (isInserting) {
      context.missing(_attemptIdMeta);
    }
    if (data.containsKey('question_key')) {
      context.handle(
        _questionKeyMeta,
        questionKey.isAcceptableOrUnknown(
          data['question_key']!,
          _questionKeyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_questionKeyMeta);
    }
    if (data.containsKey('is_correct')) {
      context.handle(
        _isCorrectMeta,
        isCorrect.isAcceptableOrUnknown(data['is_correct']!, _isCorrectMeta),
      );
    } else if (isInserting) {
      context.missing(_isCorrectMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TestAttemptAnswerDatabaseDto map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TestAttemptAnswerDatabaseDto(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      attemptId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}attempt_id'],
      )!,
      questionKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}question_key'],
      )!,
      isCorrect: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_correct'],
      )!,
    );
  }

  @override
  TestAttemptAnswers createAlias(String alias) {
    return TestAttemptAnswers(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class TestAttemptAnswerDatabaseDto extends DataClass
    implements Insertable<TestAttemptAnswerDatabaseDto> {
  final int id;
  final String attemptId;
  final String questionKey;
  final bool isCorrect;
  const TestAttemptAnswerDatabaseDto({
    required this.id,
    required this.attemptId,
    required this.questionKey,
    required this.isCorrect,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['attempt_id'] = Variable<String>(attemptId);
    map['question_key'] = Variable<String>(questionKey);
    map['is_correct'] = Variable<bool>(isCorrect);
    return map;
  }

  TestAttemptAnswersCompanion toCompanion(bool nullToAbsent) {
    return TestAttemptAnswersCompanion(
      id: Value(id),
      attemptId: Value(attemptId),
      questionKey: Value(questionKey),
      isCorrect: Value(isCorrect),
    );
  }

  factory TestAttemptAnswerDatabaseDto.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TestAttemptAnswerDatabaseDto(
      id: serializer.fromJson<int>(json['id']),
      attemptId: serializer.fromJson<String>(json['attempt_id']),
      questionKey: serializer.fromJson<String>(json['question_key']),
      isCorrect: serializer.fromJson<bool>(json['is_correct']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'attempt_id': serializer.toJson<String>(attemptId),
      'question_key': serializer.toJson<String>(questionKey),
      'is_correct': serializer.toJson<bool>(isCorrect),
    };
  }

  TestAttemptAnswerDatabaseDto copyWith({
    int? id,
    String? attemptId,
    String? questionKey,
    bool? isCorrect,
  }) => TestAttemptAnswerDatabaseDto(
    id: id ?? this.id,
    attemptId: attemptId ?? this.attemptId,
    questionKey: questionKey ?? this.questionKey,
    isCorrect: isCorrect ?? this.isCorrect,
  );
  TestAttemptAnswerDatabaseDto copyWithCompanion(
    TestAttemptAnswersCompanion data,
  ) {
    return TestAttemptAnswerDatabaseDto(
      id: data.id.present ? data.id.value : this.id,
      attemptId: data.attemptId.present ? data.attemptId.value : this.attemptId,
      questionKey: data.questionKey.present
          ? data.questionKey.value
          : this.questionKey,
      isCorrect: data.isCorrect.present ? data.isCorrect.value : this.isCorrect,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TestAttemptAnswerDatabaseDto(')
          ..write('id: $id, ')
          ..write('attemptId: $attemptId, ')
          ..write('questionKey: $questionKey, ')
          ..write('isCorrect: $isCorrect')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, attemptId, questionKey, isCorrect);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TestAttemptAnswerDatabaseDto &&
          other.id == this.id &&
          other.attemptId == this.attemptId &&
          other.questionKey == this.questionKey &&
          other.isCorrect == this.isCorrect);
}

class TestAttemptAnswersCompanion
    extends UpdateCompanion<TestAttemptAnswerDatabaseDto> {
  final Value<int> id;
  final Value<String> attemptId;
  final Value<String> questionKey;
  final Value<bool> isCorrect;
  const TestAttemptAnswersCompanion({
    this.id = const Value.absent(),
    this.attemptId = const Value.absent(),
    this.questionKey = const Value.absent(),
    this.isCorrect = const Value.absent(),
  });
  TestAttemptAnswersCompanion.insert({
    this.id = const Value.absent(),
    required String attemptId,
    required String questionKey,
    required bool isCorrect,
  }) : attemptId = Value(attemptId),
       questionKey = Value(questionKey),
       isCorrect = Value(isCorrect);
  static Insertable<TestAttemptAnswerDatabaseDto> custom({
    Expression<int>? id,
    Expression<String>? attemptId,
    Expression<String>? questionKey,
    Expression<bool>? isCorrect,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (attemptId != null) 'attempt_id': attemptId,
      if (questionKey != null) 'question_key': questionKey,
      if (isCorrect != null) 'is_correct': isCorrect,
    });
  }

  TestAttemptAnswersCompanion copyWith({
    Value<int>? id,
    Value<String>? attemptId,
    Value<String>? questionKey,
    Value<bool>? isCorrect,
  }) {
    return TestAttemptAnswersCompanion(
      id: id ?? this.id,
      attemptId: attemptId ?? this.attemptId,
      questionKey: questionKey ?? this.questionKey,
      isCorrect: isCorrect ?? this.isCorrect,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (attemptId.present) {
      map['attempt_id'] = Variable<String>(attemptId.value);
    }
    if (questionKey.present) {
      map['question_key'] = Variable<String>(questionKey.value);
    }
    if (isCorrect.present) {
      map['is_correct'] = Variable<bool>(isCorrect.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TestAttemptAnswersCompanion(')
          ..write('id: $id, ')
          ..write('attemptId: $attemptId, ')
          ..write('questionKey: $questionKey, ')
          ..write('isCorrect: $isCorrect')
          ..write(')'))
        .toString();
  }
}

class SyncMeta extends Table with TableInfo<SyncMeta, SyncMetaDatabaseDto> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  SyncMeta(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _metaKeyMeta = const VerificationMeta(
    'metaKey',
  );
  late final GeneratedColumn<String> metaKey = GeneratedColumn<String>(
    'meta_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL PRIMARY KEY',
  );
  static const VerificationMeta _metaValueMeta = const VerificationMeta(
    'metaValue',
  );
  late final GeneratedColumn<String> metaValue = GeneratedColumn<String>(
    'meta_value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [metaKey, metaValue];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_meta';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncMetaDatabaseDto> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('meta_key')) {
      context.handle(
        _metaKeyMeta,
        metaKey.isAcceptableOrUnknown(data['meta_key']!, _metaKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_metaKeyMeta);
    }
    if (data.containsKey('meta_value')) {
      context.handle(
        _metaValueMeta,
        metaValue.isAcceptableOrUnknown(data['meta_value']!, _metaValueMeta),
      );
    } else if (isInserting) {
      context.missing(_metaValueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {metaKey};
  @override
  SyncMetaDatabaseDto map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncMetaDatabaseDto(
      metaKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}meta_key'],
      )!,
      metaValue: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}meta_value'],
      )!,
    );
  }

  @override
  SyncMeta createAlias(String alias) {
    return SyncMeta(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class SyncMetaDatabaseDto extends DataClass
    implements Insertable<SyncMetaDatabaseDto> {
  final String metaKey;
  final String metaValue;
  const SyncMetaDatabaseDto({required this.metaKey, required this.metaValue});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['meta_key'] = Variable<String>(metaKey);
    map['meta_value'] = Variable<String>(metaValue);
    return map;
  }

  SyncMetaCompanion toCompanion(bool nullToAbsent) {
    return SyncMetaCompanion(
      metaKey: Value(metaKey),
      metaValue: Value(metaValue),
    );
  }

  factory SyncMetaDatabaseDto.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncMetaDatabaseDto(
      metaKey: serializer.fromJson<String>(json['meta_key']),
      metaValue: serializer.fromJson<String>(json['meta_value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'meta_key': serializer.toJson<String>(metaKey),
      'meta_value': serializer.toJson<String>(metaValue),
    };
  }

  SyncMetaDatabaseDto copyWith({String? metaKey, String? metaValue}) =>
      SyncMetaDatabaseDto(
        metaKey: metaKey ?? this.metaKey,
        metaValue: metaValue ?? this.metaValue,
      );
  SyncMetaDatabaseDto copyWithCompanion(SyncMetaCompanion data) {
    return SyncMetaDatabaseDto(
      metaKey: data.metaKey.present ? data.metaKey.value : this.metaKey,
      metaValue: data.metaValue.present ? data.metaValue.value : this.metaValue,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncMetaDatabaseDto(')
          ..write('metaKey: $metaKey, ')
          ..write('metaValue: $metaValue')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(metaKey, metaValue);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncMetaDatabaseDto &&
          other.metaKey == this.metaKey &&
          other.metaValue == this.metaValue);
}

class SyncMetaCompanion extends UpdateCompanion<SyncMetaDatabaseDto> {
  final Value<String> metaKey;
  final Value<String> metaValue;
  final Value<int> rowid;
  const SyncMetaCompanion({
    this.metaKey = const Value.absent(),
    this.metaValue = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncMetaCompanion.insert({
    required String metaKey,
    required String metaValue,
    this.rowid = const Value.absent(),
  }) : metaKey = Value(metaKey),
       metaValue = Value(metaValue);
  static Insertable<SyncMetaDatabaseDto> custom({
    Expression<String>? metaKey,
    Expression<String>? metaValue,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (metaKey != null) 'meta_key': metaKey,
      if (metaValue != null) 'meta_value': metaValue,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncMetaCompanion copyWith({
    Value<String>? metaKey,
    Value<String>? metaValue,
    Value<int>? rowid,
  }) {
    return SyncMetaCompanion(
      metaKey: metaKey ?? this.metaKey,
      metaValue: metaValue ?? this.metaValue,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (metaKey.present) {
      map['meta_key'] = Variable<String>(metaKey.value);
    }
    if (metaValue.present) {
      map['meta_value'] = Variable<String>(metaValue.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncMetaCompanion(')
          ..write('metaKey: $metaKey, ')
          ..write('metaValue: $metaValue, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class AnswerEventsOutbox extends Table
    with TableInfo<AnswerEventsOutbox, AnswerEventOutboxDatabaseDto> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  AnswerEventsOutbox(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT',
  );
  static const VerificationMeta _cardIdMeta = const VerificationMeta('cardId');
  late final GeneratedColumn<String> cardId = GeneratedColumn<String>(
    'card_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _isCorrectMeta = const VerificationMeta(
    'isCorrect',
  );
  late final GeneratedColumn<bool> isCorrect = GeneratedColumn<bool>(
    'is_correct',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _answeredAtMeta = const VerificationMeta(
    'answeredAt',
  );
  late final GeneratedColumn<DateTime> answeredAt = GeneratedColumn<DateTime>(
    'answered_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _sentAtMeta = const VerificationMeta('sentAt');
  late final GeneratedColumn<DateTime> sentAt = GeneratedColumn<DateTime>(
    'sent_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    cardId,
    isCorrect,
    answeredAt,
    sentAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'answer_events_outbox';
  @override
  VerificationContext validateIntegrity(
    Insertable<AnswerEventOutboxDatabaseDto> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('card_id')) {
      context.handle(
        _cardIdMeta,
        cardId.isAcceptableOrUnknown(data['card_id']!, _cardIdMeta),
      );
    } else if (isInserting) {
      context.missing(_cardIdMeta);
    }
    if (data.containsKey('is_correct')) {
      context.handle(
        _isCorrectMeta,
        isCorrect.isAcceptableOrUnknown(data['is_correct']!, _isCorrectMeta),
      );
    } else if (isInserting) {
      context.missing(_isCorrectMeta);
    }
    if (data.containsKey('answered_at')) {
      context.handle(
        _answeredAtMeta,
        answeredAt.isAcceptableOrUnknown(data['answered_at']!, _answeredAtMeta),
      );
    } else if (isInserting) {
      context.missing(_answeredAtMeta);
    }
    if (data.containsKey('sent_at')) {
      context.handle(
        _sentAtMeta,
        sentAt.isAcceptableOrUnknown(data['sent_at']!, _sentAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {cardId, answeredAt},
  ];
  @override
  AnswerEventOutboxDatabaseDto map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AnswerEventOutboxDatabaseDto(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      cardId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}card_id'],
      )!,
      isCorrect: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_correct'],
      )!,
      answeredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}answered_at'],
      )!,
      sentAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}sent_at'],
      ),
    );
  }

  @override
  AnswerEventsOutbox createAlias(String alias) {
    return AnswerEventsOutbox(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const ['UNIQUE(card_id, answered_at)'];
  @override
  bool get dontWriteConstraints => true;
}

class AnswerEventOutboxDatabaseDto extends DataClass
    implements Insertable<AnswerEventOutboxDatabaseDto> {
  final int id;
  final String cardId;
  final bool isCorrect;
  final DateTime answeredAt;
  final DateTime? sentAt;
  const AnswerEventOutboxDatabaseDto({
    required this.id,
    required this.cardId,
    required this.isCorrect,
    required this.answeredAt,
    this.sentAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['card_id'] = Variable<String>(cardId);
    map['is_correct'] = Variable<bool>(isCorrect);
    map['answered_at'] = Variable<DateTime>(answeredAt);
    if (!nullToAbsent || sentAt != null) {
      map['sent_at'] = Variable<DateTime>(sentAt);
    }
    return map;
  }

  AnswerEventsOutboxCompanion toCompanion(bool nullToAbsent) {
    return AnswerEventsOutboxCompanion(
      id: Value(id),
      cardId: Value(cardId),
      isCorrect: Value(isCorrect),
      answeredAt: Value(answeredAt),
      sentAt: sentAt == null && nullToAbsent
          ? const Value.absent()
          : Value(sentAt),
    );
  }

  factory AnswerEventOutboxDatabaseDto.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AnswerEventOutboxDatabaseDto(
      id: serializer.fromJson<int>(json['id']),
      cardId: serializer.fromJson<String>(json['card_id']),
      isCorrect: serializer.fromJson<bool>(json['is_correct']),
      answeredAt: serializer.fromJson<DateTime>(json['answered_at']),
      sentAt: serializer.fromJson<DateTime?>(json['sent_at']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'card_id': serializer.toJson<String>(cardId),
      'is_correct': serializer.toJson<bool>(isCorrect),
      'answered_at': serializer.toJson<DateTime>(answeredAt),
      'sent_at': serializer.toJson<DateTime?>(sentAt),
    };
  }

  AnswerEventOutboxDatabaseDto copyWith({
    int? id,
    String? cardId,
    bool? isCorrect,
    DateTime? answeredAt,
    Value<DateTime?> sentAt = const Value.absent(),
  }) => AnswerEventOutboxDatabaseDto(
    id: id ?? this.id,
    cardId: cardId ?? this.cardId,
    isCorrect: isCorrect ?? this.isCorrect,
    answeredAt: answeredAt ?? this.answeredAt,
    sentAt: sentAt.present ? sentAt.value : this.sentAt,
  );
  AnswerEventOutboxDatabaseDto copyWithCompanion(
    AnswerEventsOutboxCompanion data,
  ) {
    return AnswerEventOutboxDatabaseDto(
      id: data.id.present ? data.id.value : this.id,
      cardId: data.cardId.present ? data.cardId.value : this.cardId,
      isCorrect: data.isCorrect.present ? data.isCorrect.value : this.isCorrect,
      answeredAt: data.answeredAt.present
          ? data.answeredAt.value
          : this.answeredAt,
      sentAt: data.sentAt.present ? data.sentAt.value : this.sentAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AnswerEventOutboxDatabaseDto(')
          ..write('id: $id, ')
          ..write('cardId: $cardId, ')
          ..write('isCorrect: $isCorrect, ')
          ..write('answeredAt: $answeredAt, ')
          ..write('sentAt: $sentAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, cardId, isCorrect, answeredAt, sentAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AnswerEventOutboxDatabaseDto &&
          other.id == this.id &&
          other.cardId == this.cardId &&
          other.isCorrect == this.isCorrect &&
          other.answeredAt == this.answeredAt &&
          other.sentAt == this.sentAt);
}

class AnswerEventsOutboxCompanion
    extends UpdateCompanion<AnswerEventOutboxDatabaseDto> {
  final Value<int> id;
  final Value<String> cardId;
  final Value<bool> isCorrect;
  final Value<DateTime> answeredAt;
  final Value<DateTime?> sentAt;
  const AnswerEventsOutboxCompanion({
    this.id = const Value.absent(),
    this.cardId = const Value.absent(),
    this.isCorrect = const Value.absent(),
    this.answeredAt = const Value.absent(),
    this.sentAt = const Value.absent(),
  });
  AnswerEventsOutboxCompanion.insert({
    this.id = const Value.absent(),
    required String cardId,
    required bool isCorrect,
    required DateTime answeredAt,
    this.sentAt = const Value.absent(),
  }) : cardId = Value(cardId),
       isCorrect = Value(isCorrect),
       answeredAt = Value(answeredAt);
  static Insertable<AnswerEventOutboxDatabaseDto> custom({
    Expression<int>? id,
    Expression<String>? cardId,
    Expression<bool>? isCorrect,
    Expression<DateTime>? answeredAt,
    Expression<DateTime>? sentAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (cardId != null) 'card_id': cardId,
      if (isCorrect != null) 'is_correct': isCorrect,
      if (answeredAt != null) 'answered_at': answeredAt,
      if (sentAt != null) 'sent_at': sentAt,
    });
  }

  AnswerEventsOutboxCompanion copyWith({
    Value<int>? id,
    Value<String>? cardId,
    Value<bool>? isCorrect,
    Value<DateTime>? answeredAt,
    Value<DateTime?>? sentAt,
  }) {
    return AnswerEventsOutboxCompanion(
      id: id ?? this.id,
      cardId: cardId ?? this.cardId,
      isCorrect: isCorrect ?? this.isCorrect,
      answeredAt: answeredAt ?? this.answeredAt,
      sentAt: sentAt ?? this.sentAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (cardId.present) {
      map['card_id'] = Variable<String>(cardId.value);
    }
    if (isCorrect.present) {
      map['is_correct'] = Variable<bool>(isCorrect.value);
    }
    if (answeredAt.present) {
      map['answered_at'] = Variable<DateTime>(answeredAt.value);
    }
    if (sentAt.present) {
      map['sent_at'] = Variable<DateTime>(sentAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AnswerEventsOutboxCompanion(')
          ..write('id: $id, ')
          ..write('cardId: $cardId, ')
          ..write('isCorrect: $isCorrect, ')
          ..write('answeredAt: $answeredAt, ')
          ..write('sentAt: $sentAt')
          ..write(')'))
        .toString();
  }
}

class ActiveSessions extends Table
    with TableInfo<ActiveSessions, ActiveSessionDatabaseDto> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  ActiveSessions(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL PRIMARY KEY',
  );
  static const VerificationMeta _dataMeta = const VerificationMeta('data');
  late final GeneratedColumn<String> data = GeneratedColumn<String>(
    'data',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [id, data];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'active_sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<ActiveSessionDatabaseDto> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('data')) {
      context.handle(
        _dataMeta,
        this.data.isAcceptableOrUnknown(data['data']!, _dataMeta),
      );
    } else if (isInserting) {
      context.missing(_dataMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ActiveSessionDatabaseDto map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ActiveSessionDatabaseDto(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      data: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}data'],
      )!,
    );
  }

  @override
  ActiveSessions createAlias(String alias) {
    return ActiveSessions(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class ActiveSessionDatabaseDto extends DataClass
    implements Insertable<ActiveSessionDatabaseDto> {
  final int id;
  final String data;
  const ActiveSessionDatabaseDto({required this.id, required this.data});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['data'] = Variable<String>(data);
    return map;
  }

  ActiveSessionsCompanion toCompanion(bool nullToAbsent) {
    return ActiveSessionsCompanion(id: Value(id), data: Value(data));
  }

  factory ActiveSessionDatabaseDto.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ActiveSessionDatabaseDto(
      id: serializer.fromJson<int>(json['id']),
      data: serializer.fromJson<String>(json['data']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'data': serializer.toJson<String>(data),
    };
  }

  ActiveSessionDatabaseDto copyWith({int? id, String? data}) =>
      ActiveSessionDatabaseDto(id: id ?? this.id, data: data ?? this.data);
  ActiveSessionDatabaseDto copyWithCompanion(ActiveSessionsCompanion data) {
    return ActiveSessionDatabaseDto(
      id: data.id.present ? data.id.value : this.id,
      data: data.data.present ? data.data.value : this.data,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ActiveSessionDatabaseDto(')
          ..write('id: $id, ')
          ..write('data: $data')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, data);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ActiveSessionDatabaseDto &&
          other.id == this.id &&
          other.data == this.data);
}

class ActiveSessionsCompanion
    extends UpdateCompanion<ActiveSessionDatabaseDto> {
  final Value<int> id;
  final Value<String> data;
  const ActiveSessionsCompanion({
    this.id = const Value.absent(),
    this.data = const Value.absent(),
  });
  ActiveSessionsCompanion.insert({
    this.id = const Value.absent(),
    required String data,
  }) : data = Value(data);
  static Insertable<ActiveSessionDatabaseDto> custom({
    Expression<int>? id,
    Expression<String>? data,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (data != null) 'data': data,
    });
  }

  ActiveSessionsCompanion copyWith({Value<int>? id, Value<String>? data}) {
    return ActiveSessionsCompanion(id: id ?? this.id, data: data ?? this.data);
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (data.present) {
      map['data'] = Variable<String>(data.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ActiveSessionsCompanion(')
          ..write('id: $id, ')
          ..write('data: $data')
          ..write(')'))
        .toString();
  }
}

class TestGroups extends Table
    with TableInfo<TestGroups, TestGroupDatabaseDto> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  TestGroups(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL PRIMARY KEY',
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _basePayloadMeta = const VerificationMeta(
    'basePayload',
  );
  late final GeneratedColumn<String> basePayload = GeneratedColumn<String>(
    'base_payload',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _serverUpdatedAtMeta = const VerificationMeta(
    'serverUpdatedAt',
  );
  late final GeneratedColumn<String> serverUpdatedAt = GeneratedColumn<String>(
    'server_updated_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _syncStateMeta = const VerificationMeta(
    'syncState',
  );
  late final GeneratedColumn<String> syncState = GeneratedColumn<String>(
    'sync_state',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT \'pending\'',
    defaultValue: const CustomExpression('\'pending\''),
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    createdAt,
    updatedAt,
    basePayload,
    serverUpdatedAt,
    syncState,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'test_groups';
  @override
  VerificationContext validateIntegrity(
    Insertable<TestGroupDatabaseDto> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('base_payload')) {
      context.handle(
        _basePayloadMeta,
        basePayload.isAcceptableOrUnknown(
          data['base_payload']!,
          _basePayloadMeta,
        ),
      );
    }
    if (data.containsKey('server_updated_at')) {
      context.handle(
        _serverUpdatedAtMeta,
        serverUpdatedAt.isAcceptableOrUnknown(
          data['server_updated_at']!,
          _serverUpdatedAtMeta,
        ),
      );
    }
    if (data.containsKey('sync_state')) {
      context.handle(
        _syncStateMeta,
        syncState.isAcceptableOrUnknown(data['sync_state']!, _syncStateMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TestGroupDatabaseDto map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TestGroupDatabaseDto(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      basePayload: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}base_payload'],
      ),
      serverUpdatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}server_updated_at'],
      ),
      syncState: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_state'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  TestGroups createAlias(String alias) {
    return TestGroups(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class TestGroupDatabaseDto extends DataClass
    implements Insertable<TestGroupDatabaseDto> {
  final String id;
  final String title;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? basePayload;

  /// server_updated_at — TEXT (ISO-8601 UTC с миллисекундами), а не DATETIME:
  /// drift хранит DATETIME как unix-секунды, а LWW на сервере сравнивает
  /// время с точностью до миллисекунд.
  final String? serverUpdatedAt;
  final String syncState;
  final DateTime? deletedAt;
  const TestGroupDatabaseDto({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
    this.basePayload,
    this.serverUpdatedAt,
    required this.syncState,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || basePayload != null) {
      map['base_payload'] = Variable<String>(basePayload);
    }
    if (!nullToAbsent || serverUpdatedAt != null) {
      map['server_updated_at'] = Variable<String>(serverUpdatedAt);
    }
    map['sync_state'] = Variable<String>(syncState);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  TestGroupsCompanion toCompanion(bool nullToAbsent) {
    return TestGroupsCompanion(
      id: Value(id),
      title: Value(title),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      basePayload: basePayload == null && nullToAbsent
          ? const Value.absent()
          : Value(basePayload),
      serverUpdatedAt: serverUpdatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(serverUpdatedAt),
      syncState: Value(syncState),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory TestGroupDatabaseDto.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TestGroupDatabaseDto(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      createdAt: serializer.fromJson<DateTime>(json['created_at']),
      updatedAt: serializer.fromJson<DateTime>(json['updated_at']),
      basePayload: serializer.fromJson<String?>(json['base_payload']),
      serverUpdatedAt: serializer.fromJson<String?>(json['server_updated_at']),
      syncState: serializer.fromJson<String>(json['sync_state']),
      deletedAt: serializer.fromJson<DateTime?>(json['deleted_at']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'created_at': serializer.toJson<DateTime>(createdAt),
      'updated_at': serializer.toJson<DateTime>(updatedAt),
      'base_payload': serializer.toJson<String?>(basePayload),
      'server_updated_at': serializer.toJson<String?>(serverUpdatedAt),
      'sync_state': serializer.toJson<String>(syncState),
      'deleted_at': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  TestGroupDatabaseDto copyWith({
    String? id,
    String? title,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<String?> basePayload = const Value.absent(),
    Value<String?> serverUpdatedAt = const Value.absent(),
    String? syncState,
    Value<DateTime?> deletedAt = const Value.absent(),
  }) => TestGroupDatabaseDto(
    id: id ?? this.id,
    title: title ?? this.title,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    basePayload: basePayload.present ? basePayload.value : this.basePayload,
    serverUpdatedAt: serverUpdatedAt.present
        ? serverUpdatedAt.value
        : this.serverUpdatedAt,
    syncState: syncState ?? this.syncState,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  TestGroupDatabaseDto copyWithCompanion(TestGroupsCompanion data) {
    return TestGroupDatabaseDto(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      basePayload: data.basePayload.present
          ? data.basePayload.value
          : this.basePayload,
      serverUpdatedAt: data.serverUpdatedAt.present
          ? data.serverUpdatedAt.value
          : this.serverUpdatedAt,
      syncState: data.syncState.present ? data.syncState.value : this.syncState,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TestGroupDatabaseDto(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('basePayload: $basePayload, ')
          ..write('serverUpdatedAt: $serverUpdatedAt, ')
          ..write('syncState: $syncState, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    createdAt,
    updatedAt,
    basePayload,
    serverUpdatedAt,
    syncState,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TestGroupDatabaseDto &&
          other.id == this.id &&
          other.title == this.title &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.basePayload == this.basePayload &&
          other.serverUpdatedAt == this.serverUpdatedAt &&
          other.syncState == this.syncState &&
          other.deletedAt == this.deletedAt);
}

class TestGroupsCompanion extends UpdateCompanion<TestGroupDatabaseDto> {
  final Value<String> id;
  final Value<String> title;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String?> basePayload;
  final Value<String?> serverUpdatedAt;
  final Value<String> syncState;
  final Value<DateTime?> deletedAt;
  final Value<int> rowid;
  const TestGroupsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.basePayload = const Value.absent(),
    this.serverUpdatedAt = const Value.absent(),
    this.syncState = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TestGroupsCompanion.insert({
    required String id,
    required String title,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.basePayload = const Value.absent(),
    this.serverUpdatedAt = const Value.absent(),
    this.syncState = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<TestGroupDatabaseDto> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? basePayload,
    Expression<String>? serverUpdatedAt,
    Expression<String>? syncState,
    Expression<DateTime>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (basePayload != null) 'base_payload': basePayload,
      if (serverUpdatedAt != null) 'server_updated_at': serverUpdatedAt,
      if (syncState != null) 'sync_state': syncState,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TestGroupsCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String?>? basePayload,
    Value<String?>? serverUpdatedAt,
    Value<String>? syncState,
    Value<DateTime?>? deletedAt,
    Value<int>? rowid,
  }) {
    return TestGroupsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      basePayload: basePayload ?? this.basePayload,
      serverUpdatedAt: serverUpdatedAt ?? this.serverUpdatedAt,
      syncState: syncState ?? this.syncState,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (basePayload.present) {
      map['base_payload'] = Variable<String>(basePayload.value);
    }
    if (serverUpdatedAt.present) {
      map['server_updated_at'] = Variable<String>(serverUpdatedAt.value);
    }
    if (syncState.present) {
      map['sync_state'] = Variable<String>(syncState.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TestGroupsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('basePayload: $basePayload, ')
          ..write('serverUpdatedAt: $serverUpdatedAt, ')
          ..write('syncState: $syncState, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class Tests extends Table with TableInfo<Tests, TestDatabaseDto> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Tests(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL PRIMARY KEY',
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _basePayloadMeta = const VerificationMeta(
    'basePayload',
  );
  late final GeneratedColumn<String> basePayload = GeneratedColumn<String>(
    'base_payload',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _serverUpdatedAtMeta = const VerificationMeta(
    'serverUpdatedAt',
  );
  late final GeneratedColumn<String> serverUpdatedAt = GeneratedColumn<String>(
    'server_updated_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _syncStateMeta = const VerificationMeta(
    'syncState',
  );
  late final GeneratedColumn<String> syncState = GeneratedColumn<String>(
    'sync_state',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT \'pending\'',
    defaultValue: const CustomExpression('\'pending\''),
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    description,
    type,
    createdAt,
    updatedAt,
    basePayload,
    serverUpdatedAt,
    syncState,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tests';
  @override
  VerificationContext validateIntegrity(
    Insertable<TestDatabaseDto> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('base_payload')) {
      context.handle(
        _basePayloadMeta,
        basePayload.isAcceptableOrUnknown(
          data['base_payload']!,
          _basePayloadMeta,
        ),
      );
    }
    if (data.containsKey('server_updated_at')) {
      context.handle(
        _serverUpdatedAtMeta,
        serverUpdatedAt.isAcceptableOrUnknown(
          data['server_updated_at']!,
          _serverUpdatedAtMeta,
        ),
      );
    }
    if (data.containsKey('sync_state')) {
      context.handle(
        _syncStateMeta,
        syncState.isAcceptableOrUnknown(data['sync_state']!, _syncStateMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TestDatabaseDto map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TestDatabaseDto(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      basePayload: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}base_payload'],
      ),
      serverUpdatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}server_updated_at'],
      ),
      syncState: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_state'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  Tests createAlias(String alias) {
    return Tests(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class TestDatabaseDto extends DataClass implements Insertable<TestDatabaseDto> {
  final String id;
  final String title;
  final String? description;
  final String type;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? basePayload;

  /// server_updated_at — TEXT (ISO-8601 UTC с миллисекундами), а не DATETIME:
  /// drift хранит DATETIME как unix-секунды, а LWW на сервере сравнивает
  /// время с точностью до миллисекунд.
  final String? serverUpdatedAt;
  final String syncState;
  final DateTime? deletedAt;
  const TestDatabaseDto({
    required this.id,
    required this.title,
    this.description,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
    this.basePayload,
    this.serverUpdatedAt,
    required this.syncState,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['type'] = Variable<String>(type);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || basePayload != null) {
      map['base_payload'] = Variable<String>(basePayload);
    }
    if (!nullToAbsent || serverUpdatedAt != null) {
      map['server_updated_at'] = Variable<String>(serverUpdatedAt);
    }
    map['sync_state'] = Variable<String>(syncState);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  TestsCompanion toCompanion(bool nullToAbsent) {
    return TestsCompanion(
      id: Value(id),
      title: Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      type: Value(type),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      basePayload: basePayload == null && nullToAbsent
          ? const Value.absent()
          : Value(basePayload),
      serverUpdatedAt: serverUpdatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(serverUpdatedAt),
      syncState: Value(syncState),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory TestDatabaseDto.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TestDatabaseDto(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      type: serializer.fromJson<String>(json['type']),
      createdAt: serializer.fromJson<DateTime>(json['created_at']),
      updatedAt: serializer.fromJson<DateTime>(json['updated_at']),
      basePayload: serializer.fromJson<String?>(json['base_payload']),
      serverUpdatedAt: serializer.fromJson<String?>(json['server_updated_at']),
      syncState: serializer.fromJson<String>(json['sync_state']),
      deletedAt: serializer.fromJson<DateTime?>(json['deleted_at']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'type': serializer.toJson<String>(type),
      'created_at': serializer.toJson<DateTime>(createdAt),
      'updated_at': serializer.toJson<DateTime>(updatedAt),
      'base_payload': serializer.toJson<String?>(basePayload),
      'server_updated_at': serializer.toJson<String?>(serverUpdatedAt),
      'sync_state': serializer.toJson<String>(syncState),
      'deleted_at': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  TestDatabaseDto copyWith({
    String? id,
    String? title,
    Value<String?> description = const Value.absent(),
    String? type,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<String?> basePayload = const Value.absent(),
    Value<String?> serverUpdatedAt = const Value.absent(),
    String? syncState,
    Value<DateTime?> deletedAt = const Value.absent(),
  }) => TestDatabaseDto(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description.present ? description.value : this.description,
    type: type ?? this.type,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    basePayload: basePayload.present ? basePayload.value : this.basePayload,
    serverUpdatedAt: serverUpdatedAt.present
        ? serverUpdatedAt.value
        : this.serverUpdatedAt,
    syncState: syncState ?? this.syncState,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  TestDatabaseDto copyWithCompanion(TestsCompanion data) {
    return TestDatabaseDto(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      type: data.type.present ? data.type.value : this.type,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      basePayload: data.basePayload.present
          ? data.basePayload.value
          : this.basePayload,
      serverUpdatedAt: data.serverUpdatedAt.present
          ? data.serverUpdatedAt.value
          : this.serverUpdatedAt,
      syncState: data.syncState.present ? data.syncState.value : this.syncState,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TestDatabaseDto(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('type: $type, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('basePayload: $basePayload, ')
          ..write('serverUpdatedAt: $serverUpdatedAt, ')
          ..write('syncState: $syncState, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    description,
    type,
    createdAt,
    updatedAt,
    basePayload,
    serverUpdatedAt,
    syncState,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TestDatabaseDto &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.type == this.type &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.basePayload == this.basePayload &&
          other.serverUpdatedAt == this.serverUpdatedAt &&
          other.syncState == this.syncState &&
          other.deletedAt == this.deletedAt);
}

class TestsCompanion extends UpdateCompanion<TestDatabaseDto> {
  final Value<String> id;
  final Value<String> title;
  final Value<String?> description;
  final Value<String> type;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String?> basePayload;
  final Value<String?> serverUpdatedAt;
  final Value<String> syncState;
  final Value<DateTime?> deletedAt;
  final Value<int> rowid;
  const TestsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.type = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.basePayload = const Value.absent(),
    this.serverUpdatedAt = const Value.absent(),
    this.syncState = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TestsCompanion.insert({
    required String id,
    required String title,
    this.description = const Value.absent(),
    required String type,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.basePayload = const Value.absent(),
    this.serverUpdatedAt = const Value.absent(),
    this.syncState = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       type = Value(type),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<TestDatabaseDto> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? type,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? basePayload,
    Expression<String>? serverUpdatedAt,
    Expression<String>? syncState,
    Expression<DateTime>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (type != null) 'type': type,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (basePayload != null) 'base_payload': basePayload,
      if (serverUpdatedAt != null) 'server_updated_at': serverUpdatedAt,
      if (syncState != null) 'sync_state': syncState,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TestsCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<String?>? description,
    Value<String>? type,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String?>? basePayload,
    Value<String?>? serverUpdatedAt,
    Value<String>? syncState,
    Value<DateTime?>? deletedAt,
    Value<int>? rowid,
  }) {
    return TestsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      basePayload: basePayload ?? this.basePayload,
      serverUpdatedAt: serverUpdatedAt ?? this.serverUpdatedAt,
      syncState: syncState ?? this.syncState,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (basePayload.present) {
      map['base_payload'] = Variable<String>(basePayload.value);
    }
    if (serverUpdatedAt.present) {
      map['server_updated_at'] = Variable<String>(serverUpdatedAt.value);
    }
    if (syncState.present) {
      map['sync_state'] = Variable<String>(syncState.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TestsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('type: $type, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('basePayload: $basePayload, ')
          ..write('serverUpdatedAt: $serverUpdatedAt, ')
          ..write('syncState: $syncState, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class TestGroupEntries extends Table
    with TableInfo<TestGroupEntries, TestGroupEntryDatabaseDto> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  TestGroupEntries(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL PRIMARY KEY',
  );
  static const VerificationMeta _groupIdMeta = const VerificationMeta(
    'groupId',
  );
  late final GeneratedColumn<String> groupId = GeneratedColumn<String>(
    'group_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES test_groups(id)ON DELETE CASCADE',
  );
  static const VerificationMeta _testIdMeta = const VerificationMeta('testId');
  late final GeneratedColumn<String> testId = GeneratedColumn<String>(
    'test_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES tests(id)ON DELETE CASCADE',
  );
  @override
  List<GeneratedColumn> get $columns => [id, groupId, testId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'test_group_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<TestGroupEntryDatabaseDto> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('group_id')) {
      context.handle(
        _groupIdMeta,
        groupId.isAcceptableOrUnknown(data['group_id']!, _groupIdMeta),
      );
    } else if (isInserting) {
      context.missing(_groupIdMeta);
    }
    if (data.containsKey('test_id')) {
      context.handle(
        _testIdMeta,
        testId.isAcceptableOrUnknown(data['test_id']!, _testIdMeta),
      );
    } else if (isInserting) {
      context.missing(_testIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {groupId, testId},
  ];
  @override
  TestGroupEntryDatabaseDto map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TestGroupEntryDatabaseDto(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      groupId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}group_id'],
      )!,
      testId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}test_id'],
      )!,
    );
  }

  @override
  TestGroupEntries createAlias(String alias) {
    return TestGroupEntries(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const ['UNIQUE(group_id, test_id)'];
  @override
  bool get dontWriteConstraints => true;
}

class TestGroupEntryDatabaseDto extends DataClass
    implements Insertable<TestGroupEntryDatabaseDto> {
  final String id;
  final String groupId;
  final String testId;
  const TestGroupEntryDatabaseDto({
    required this.id,
    required this.groupId,
    required this.testId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['group_id'] = Variable<String>(groupId);
    map['test_id'] = Variable<String>(testId);
    return map;
  }

  TestGroupEntriesCompanion toCompanion(bool nullToAbsent) {
    return TestGroupEntriesCompanion(
      id: Value(id),
      groupId: Value(groupId),
      testId: Value(testId),
    );
  }

  factory TestGroupEntryDatabaseDto.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TestGroupEntryDatabaseDto(
      id: serializer.fromJson<String>(json['id']),
      groupId: serializer.fromJson<String>(json['group_id']),
      testId: serializer.fromJson<String>(json['test_id']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'group_id': serializer.toJson<String>(groupId),
      'test_id': serializer.toJson<String>(testId),
    };
  }

  TestGroupEntryDatabaseDto copyWith({
    String? id,
    String? groupId,
    String? testId,
  }) => TestGroupEntryDatabaseDto(
    id: id ?? this.id,
    groupId: groupId ?? this.groupId,
    testId: testId ?? this.testId,
  );
  TestGroupEntryDatabaseDto copyWithCompanion(TestGroupEntriesCompanion data) {
    return TestGroupEntryDatabaseDto(
      id: data.id.present ? data.id.value : this.id,
      groupId: data.groupId.present ? data.groupId.value : this.groupId,
      testId: data.testId.present ? data.testId.value : this.testId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TestGroupEntryDatabaseDto(')
          ..write('id: $id, ')
          ..write('groupId: $groupId, ')
          ..write('testId: $testId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, groupId, testId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TestGroupEntryDatabaseDto &&
          other.id == this.id &&
          other.groupId == this.groupId &&
          other.testId == this.testId);
}

class TestGroupEntriesCompanion
    extends UpdateCompanion<TestGroupEntryDatabaseDto> {
  final Value<String> id;
  final Value<String> groupId;
  final Value<String> testId;
  final Value<int> rowid;
  const TestGroupEntriesCompanion({
    this.id = const Value.absent(),
    this.groupId = const Value.absent(),
    this.testId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TestGroupEntriesCompanion.insert({
    required String id,
    required String groupId,
    required String testId,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       groupId = Value(groupId),
       testId = Value(testId);
  static Insertable<TestGroupEntryDatabaseDto> custom({
    Expression<String>? id,
    Expression<String>? groupId,
    Expression<String>? testId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (groupId != null) 'group_id': groupId,
      if (testId != null) 'test_id': testId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TestGroupEntriesCompanion copyWith({
    Value<String>? id,
    Value<String>? groupId,
    Value<String>? testId,
    Value<int>? rowid,
  }) {
    return TestGroupEntriesCompanion(
      id: id ?? this.id,
      groupId: groupId ?? this.groupId,
      testId: testId ?? this.testId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (groupId.present) {
      map['group_id'] = Variable<String>(groupId.value);
    }
    if (testId.present) {
      map['test_id'] = Variable<String>(testId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TestGroupEntriesCompanion(')
          ..write('id: $id, ')
          ..write('groupId: $groupId, ')
          ..write('testId: $testId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class QuestionStats extends Table
    with TableInfo<QuestionStats, QuestionStatsDatabaseDto> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  QuestionStats(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT',
  );
  static const VerificationMeta _questionKeyMeta = const VerificationMeta(
    'questionKey',
  );
  late final GeneratedColumn<String> questionKey = GeneratedColumn<String>(
    'question_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL UNIQUE',
  );
  static const VerificationMeta _frontTextMeta = const VerificationMeta(
    'frontText',
  );
  late final GeneratedColumn<String> frontText = GeneratedColumn<String>(
    'front_text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _backTextMeta = const VerificationMeta(
    'backText',
  );
  late final GeneratedColumn<String> backText = GeneratedColumn<String>(
    'back_text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _streakMeta = const VerificationMeta('streak');
  late final GeneratedColumn<int> streak = GeneratedColumn<int>(
    'streak',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT 0',
    defaultValue: const CustomExpression('0'),
  );
  static const VerificationMeta _totalCorrectMeta = const VerificationMeta(
    'totalCorrect',
  );
  late final GeneratedColumn<int> totalCorrect = GeneratedColumn<int>(
    'total_correct',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT 0',
    defaultValue: const CustomExpression('0'),
  );
  static const VerificationMeta _totalIncorrectMeta = const VerificationMeta(
    'totalIncorrect',
  );
  late final GeneratedColumn<int> totalIncorrect = GeneratedColumn<int>(
    'total_incorrect',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT 0',
    defaultValue: const CustomExpression('0'),
  );
  static const VerificationMeta _totalShownMeta = const VerificationMeta(
    'totalShown',
  );
  late final GeneratedColumn<int> totalShown = GeneratedColumn<int>(
    'total_shown',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT 0',
    defaultValue: const CustomExpression('0'),
  );
  static const VerificationMeta _lastAnsweredAtMeta = const VerificationMeta(
    'lastAnsweredAt',
  );
  late final GeneratedColumn<DateTime> lastAnsweredAt =
      GeneratedColumn<DateTime>(
        'last_answered_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
        $customConstraints: '',
      );
  static const VerificationMeta _lastShownAtMeta = const VerificationMeta(
    'lastShownAt',
  );
  late final GeneratedColumn<DateTime> lastShownAt = GeneratedColumn<DateTime>(
    'last_shown_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _syncStateMeta = const VerificationMeta(
    'syncState',
  );
  late final GeneratedColumn<String> syncState = GeneratedColumn<String>(
    'sync_state',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT \'pending\'',
    defaultValue: const CustomExpression('\'pending\''),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    questionKey,
    frontText,
    backText,
    streak,
    totalCorrect,
    totalIncorrect,
    totalShown,
    lastAnsweredAt,
    lastShownAt,
    createdAt,
    updatedAt,
    syncState,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'question_stats';
  @override
  VerificationContext validateIntegrity(
    Insertable<QuestionStatsDatabaseDto> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('question_key')) {
      context.handle(
        _questionKeyMeta,
        questionKey.isAcceptableOrUnknown(
          data['question_key']!,
          _questionKeyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_questionKeyMeta);
    }
    if (data.containsKey('front_text')) {
      context.handle(
        _frontTextMeta,
        frontText.isAcceptableOrUnknown(data['front_text']!, _frontTextMeta),
      );
    } else if (isInserting) {
      context.missing(_frontTextMeta);
    }
    if (data.containsKey('back_text')) {
      context.handle(
        _backTextMeta,
        backText.isAcceptableOrUnknown(data['back_text']!, _backTextMeta),
      );
    } else if (isInserting) {
      context.missing(_backTextMeta);
    }
    if (data.containsKey('streak')) {
      context.handle(
        _streakMeta,
        streak.isAcceptableOrUnknown(data['streak']!, _streakMeta),
      );
    }
    if (data.containsKey('total_correct')) {
      context.handle(
        _totalCorrectMeta,
        totalCorrect.isAcceptableOrUnknown(
          data['total_correct']!,
          _totalCorrectMeta,
        ),
      );
    }
    if (data.containsKey('total_incorrect')) {
      context.handle(
        _totalIncorrectMeta,
        totalIncorrect.isAcceptableOrUnknown(
          data['total_incorrect']!,
          _totalIncorrectMeta,
        ),
      );
    }
    if (data.containsKey('total_shown')) {
      context.handle(
        _totalShownMeta,
        totalShown.isAcceptableOrUnknown(data['total_shown']!, _totalShownMeta),
      );
    }
    if (data.containsKey('last_answered_at')) {
      context.handle(
        _lastAnsweredAtMeta,
        lastAnsweredAt.isAcceptableOrUnknown(
          data['last_answered_at']!,
          _lastAnsweredAtMeta,
        ),
      );
    }
    if (data.containsKey('last_shown_at')) {
      context.handle(
        _lastShownAtMeta,
        lastShownAt.isAcceptableOrUnknown(
          data['last_shown_at']!,
          _lastShownAtMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('sync_state')) {
      context.handle(
        _syncStateMeta,
        syncState.isAcceptableOrUnknown(data['sync_state']!, _syncStateMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  QuestionStatsDatabaseDto map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return QuestionStatsDatabaseDto(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      questionKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}question_key'],
      )!,
      frontText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}front_text'],
      )!,
      backText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}back_text'],
      )!,
      streak: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}streak'],
      )!,
      totalCorrect: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_correct'],
      )!,
      totalIncorrect: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_incorrect'],
      )!,
      totalShown: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_shown'],
      )!,
      lastAnsweredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_answered_at'],
      ),
      lastShownAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_shown_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      syncState: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_state'],
      )!,
    );
  }

  @override
  QuestionStats createAlias(String alias) {
    return QuestionStats(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class QuestionStatsDatabaseDto extends DataClass
    implements Insertable<QuestionStatsDatabaseDto> {
  final int id;
  final String questionKey;
  final String frontText;
  final String backText;
  final int streak;
  final int totalCorrect;
  final int totalIncorrect;
  final int totalShown;
  final DateTime? lastAnsweredAt;
  final DateTime? lastShownAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  /// Счётчики уезжают на сервер: он агрегирует ответы всех устройств, но
  /// историю, накопленную до появления журнала ответов, кроме клиента
  /// отдать некому. Без своего sync_state такие строки не найти.
  final String syncState;
  const QuestionStatsDatabaseDto({
    required this.id,
    required this.questionKey,
    required this.frontText,
    required this.backText,
    required this.streak,
    required this.totalCorrect,
    required this.totalIncorrect,
    required this.totalShown,
    this.lastAnsweredAt,
    this.lastShownAt,
    required this.createdAt,
    required this.updatedAt,
    required this.syncState,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['question_key'] = Variable<String>(questionKey);
    map['front_text'] = Variable<String>(frontText);
    map['back_text'] = Variable<String>(backText);
    map['streak'] = Variable<int>(streak);
    map['total_correct'] = Variable<int>(totalCorrect);
    map['total_incorrect'] = Variable<int>(totalIncorrect);
    map['total_shown'] = Variable<int>(totalShown);
    if (!nullToAbsent || lastAnsweredAt != null) {
      map['last_answered_at'] = Variable<DateTime>(lastAnsweredAt);
    }
    if (!nullToAbsent || lastShownAt != null) {
      map['last_shown_at'] = Variable<DateTime>(lastShownAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['sync_state'] = Variable<String>(syncState);
    return map;
  }

  QuestionStatsCompanion toCompanion(bool nullToAbsent) {
    return QuestionStatsCompanion(
      id: Value(id),
      questionKey: Value(questionKey),
      frontText: Value(frontText),
      backText: Value(backText),
      streak: Value(streak),
      totalCorrect: Value(totalCorrect),
      totalIncorrect: Value(totalIncorrect),
      totalShown: Value(totalShown),
      lastAnsweredAt: lastAnsweredAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastAnsweredAt),
      lastShownAt: lastShownAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastShownAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      syncState: Value(syncState),
    );
  }

  factory QuestionStatsDatabaseDto.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return QuestionStatsDatabaseDto(
      id: serializer.fromJson<int>(json['id']),
      questionKey: serializer.fromJson<String>(json['question_key']),
      frontText: serializer.fromJson<String>(json['front_text']),
      backText: serializer.fromJson<String>(json['back_text']),
      streak: serializer.fromJson<int>(json['streak']),
      totalCorrect: serializer.fromJson<int>(json['total_correct']),
      totalIncorrect: serializer.fromJson<int>(json['total_incorrect']),
      totalShown: serializer.fromJson<int>(json['total_shown']),
      lastAnsweredAt: serializer.fromJson<DateTime?>(json['last_answered_at']),
      lastShownAt: serializer.fromJson<DateTime?>(json['last_shown_at']),
      createdAt: serializer.fromJson<DateTime>(json['created_at']),
      updatedAt: serializer.fromJson<DateTime>(json['updated_at']),
      syncState: serializer.fromJson<String>(json['sync_state']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'question_key': serializer.toJson<String>(questionKey),
      'front_text': serializer.toJson<String>(frontText),
      'back_text': serializer.toJson<String>(backText),
      'streak': serializer.toJson<int>(streak),
      'total_correct': serializer.toJson<int>(totalCorrect),
      'total_incorrect': serializer.toJson<int>(totalIncorrect),
      'total_shown': serializer.toJson<int>(totalShown),
      'last_answered_at': serializer.toJson<DateTime?>(lastAnsweredAt),
      'last_shown_at': serializer.toJson<DateTime?>(lastShownAt),
      'created_at': serializer.toJson<DateTime>(createdAt),
      'updated_at': serializer.toJson<DateTime>(updatedAt),
      'sync_state': serializer.toJson<String>(syncState),
    };
  }

  QuestionStatsDatabaseDto copyWith({
    int? id,
    String? questionKey,
    String? frontText,
    String? backText,
    int? streak,
    int? totalCorrect,
    int? totalIncorrect,
    int? totalShown,
    Value<DateTime?> lastAnsweredAt = const Value.absent(),
    Value<DateTime?> lastShownAt = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    String? syncState,
  }) => QuestionStatsDatabaseDto(
    id: id ?? this.id,
    questionKey: questionKey ?? this.questionKey,
    frontText: frontText ?? this.frontText,
    backText: backText ?? this.backText,
    streak: streak ?? this.streak,
    totalCorrect: totalCorrect ?? this.totalCorrect,
    totalIncorrect: totalIncorrect ?? this.totalIncorrect,
    totalShown: totalShown ?? this.totalShown,
    lastAnsweredAt: lastAnsweredAt.present
        ? lastAnsweredAt.value
        : this.lastAnsweredAt,
    lastShownAt: lastShownAt.present ? lastShownAt.value : this.lastShownAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    syncState: syncState ?? this.syncState,
  );
  QuestionStatsDatabaseDto copyWithCompanion(QuestionStatsCompanion data) {
    return QuestionStatsDatabaseDto(
      id: data.id.present ? data.id.value : this.id,
      questionKey: data.questionKey.present
          ? data.questionKey.value
          : this.questionKey,
      frontText: data.frontText.present ? data.frontText.value : this.frontText,
      backText: data.backText.present ? data.backText.value : this.backText,
      streak: data.streak.present ? data.streak.value : this.streak,
      totalCorrect: data.totalCorrect.present
          ? data.totalCorrect.value
          : this.totalCorrect,
      totalIncorrect: data.totalIncorrect.present
          ? data.totalIncorrect.value
          : this.totalIncorrect,
      totalShown: data.totalShown.present
          ? data.totalShown.value
          : this.totalShown,
      lastAnsweredAt: data.lastAnsweredAt.present
          ? data.lastAnsweredAt.value
          : this.lastAnsweredAt,
      lastShownAt: data.lastShownAt.present
          ? data.lastShownAt.value
          : this.lastShownAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncState: data.syncState.present ? data.syncState.value : this.syncState,
    );
  }

  @override
  String toString() {
    return (StringBuffer('QuestionStatsDatabaseDto(')
          ..write('id: $id, ')
          ..write('questionKey: $questionKey, ')
          ..write('frontText: $frontText, ')
          ..write('backText: $backText, ')
          ..write('streak: $streak, ')
          ..write('totalCorrect: $totalCorrect, ')
          ..write('totalIncorrect: $totalIncorrect, ')
          ..write('totalShown: $totalShown, ')
          ..write('lastAnsweredAt: $lastAnsweredAt, ')
          ..write('lastShownAt: $lastShownAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncState: $syncState')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    questionKey,
    frontText,
    backText,
    streak,
    totalCorrect,
    totalIncorrect,
    totalShown,
    lastAnsweredAt,
    lastShownAt,
    createdAt,
    updatedAt,
    syncState,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is QuestionStatsDatabaseDto &&
          other.id == this.id &&
          other.questionKey == this.questionKey &&
          other.frontText == this.frontText &&
          other.backText == this.backText &&
          other.streak == this.streak &&
          other.totalCorrect == this.totalCorrect &&
          other.totalIncorrect == this.totalIncorrect &&
          other.totalShown == this.totalShown &&
          other.lastAnsweredAt == this.lastAnsweredAt &&
          other.lastShownAt == this.lastShownAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.syncState == this.syncState);
}

class QuestionStatsCompanion extends UpdateCompanion<QuestionStatsDatabaseDto> {
  final Value<int> id;
  final Value<String> questionKey;
  final Value<String> frontText;
  final Value<String> backText;
  final Value<int> streak;
  final Value<int> totalCorrect;
  final Value<int> totalIncorrect;
  final Value<int> totalShown;
  final Value<DateTime?> lastAnsweredAt;
  final Value<DateTime?> lastShownAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> syncState;
  const QuestionStatsCompanion({
    this.id = const Value.absent(),
    this.questionKey = const Value.absent(),
    this.frontText = const Value.absent(),
    this.backText = const Value.absent(),
    this.streak = const Value.absent(),
    this.totalCorrect = const Value.absent(),
    this.totalIncorrect = const Value.absent(),
    this.totalShown = const Value.absent(),
    this.lastAnsweredAt = const Value.absent(),
    this.lastShownAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncState = const Value.absent(),
  });
  QuestionStatsCompanion.insert({
    this.id = const Value.absent(),
    required String questionKey,
    required String frontText,
    required String backText,
    this.streak = const Value.absent(),
    this.totalCorrect = const Value.absent(),
    this.totalIncorrect = const Value.absent(),
    this.totalShown = const Value.absent(),
    this.lastAnsweredAt = const Value.absent(),
    this.lastShownAt = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.syncState = const Value.absent(),
  }) : questionKey = Value(questionKey),
       frontText = Value(frontText),
       backText = Value(backText),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<QuestionStatsDatabaseDto> custom({
    Expression<int>? id,
    Expression<String>? questionKey,
    Expression<String>? frontText,
    Expression<String>? backText,
    Expression<int>? streak,
    Expression<int>? totalCorrect,
    Expression<int>? totalIncorrect,
    Expression<int>? totalShown,
    Expression<DateTime>? lastAnsweredAt,
    Expression<DateTime>? lastShownAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? syncState,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (questionKey != null) 'question_key': questionKey,
      if (frontText != null) 'front_text': frontText,
      if (backText != null) 'back_text': backText,
      if (streak != null) 'streak': streak,
      if (totalCorrect != null) 'total_correct': totalCorrect,
      if (totalIncorrect != null) 'total_incorrect': totalIncorrect,
      if (totalShown != null) 'total_shown': totalShown,
      if (lastAnsweredAt != null) 'last_answered_at': lastAnsweredAt,
      if (lastShownAt != null) 'last_shown_at': lastShownAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncState != null) 'sync_state': syncState,
    });
  }

  QuestionStatsCompanion copyWith({
    Value<int>? id,
    Value<String>? questionKey,
    Value<String>? frontText,
    Value<String>? backText,
    Value<int>? streak,
    Value<int>? totalCorrect,
    Value<int>? totalIncorrect,
    Value<int>? totalShown,
    Value<DateTime?>? lastAnsweredAt,
    Value<DateTime?>? lastShownAt,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? syncState,
  }) {
    return QuestionStatsCompanion(
      id: id ?? this.id,
      questionKey: questionKey ?? this.questionKey,
      frontText: frontText ?? this.frontText,
      backText: backText ?? this.backText,
      streak: streak ?? this.streak,
      totalCorrect: totalCorrect ?? this.totalCorrect,
      totalIncorrect: totalIncorrect ?? this.totalIncorrect,
      totalShown: totalShown ?? this.totalShown,
      lastAnsweredAt: lastAnsweredAt ?? this.lastAnsweredAt,
      lastShownAt: lastShownAt ?? this.lastShownAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncState: syncState ?? this.syncState,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (questionKey.present) {
      map['question_key'] = Variable<String>(questionKey.value);
    }
    if (frontText.present) {
      map['front_text'] = Variable<String>(frontText.value);
    }
    if (backText.present) {
      map['back_text'] = Variable<String>(backText.value);
    }
    if (streak.present) {
      map['streak'] = Variable<int>(streak.value);
    }
    if (totalCorrect.present) {
      map['total_correct'] = Variable<int>(totalCorrect.value);
    }
    if (totalIncorrect.present) {
      map['total_incorrect'] = Variable<int>(totalIncorrect.value);
    }
    if (totalShown.present) {
      map['total_shown'] = Variable<int>(totalShown.value);
    }
    if (lastAnsweredAt.present) {
      map['last_answered_at'] = Variable<DateTime>(lastAnsweredAt.value);
    }
    if (lastShownAt.present) {
      map['last_shown_at'] = Variable<DateTime>(lastShownAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (syncState.present) {
      map['sync_state'] = Variable<String>(syncState.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuestionStatsCompanion(')
          ..write('id: $id, ')
          ..write('questionKey: $questionKey, ')
          ..write('frontText: $frontText, ')
          ..write('backText: $backText, ')
          ..write('streak: $streak, ')
          ..write('totalCorrect: $totalCorrect, ')
          ..write('totalIncorrect: $totalIncorrect, ')
          ..write('totalShown: $totalShown, ')
          ..write('lastAnsweredAt: $lastAnsweredAt, ')
          ..write('lastShownAt: $lastShownAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncState: $syncState')
          ..write(')'))
        .toString();
  }
}

class Cards extends Table with TableInfo<Cards, CardDatabaseDto> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Cards(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL PRIMARY KEY',
  );
  static const VerificationMeta _testIdMeta = const VerificationMeta('testId');
  late final GeneratedColumn<String> testId = GeneratedColumn<String>(
    'test_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES tests(id)ON DELETE CASCADE',
  );
  static const VerificationMeta _frontMeta = const VerificationMeta('front');
  late final GeneratedColumn<String> front = GeneratedColumn<String>(
    'front',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _answersMeta = const VerificationMeta(
    'answers',
  );
  late final GeneratedColumn<String> answers = GeneratedColumn<String>(
    'answers',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _questionKeyMeta = const VerificationMeta(
    'questionKey',
  );
  late final GeneratedColumn<String> questionKey = GeneratedColumn<String>(
    'question_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _basePayloadMeta = const VerificationMeta(
    'basePayload',
  );
  late final GeneratedColumn<String> basePayload = GeneratedColumn<String>(
    'base_payload',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _serverUpdatedAtMeta = const VerificationMeta(
    'serverUpdatedAt',
  );
  late final GeneratedColumn<String> serverUpdatedAt = GeneratedColumn<String>(
    'server_updated_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _syncStateMeta = const VerificationMeta(
    'syncState',
  );
  late final GeneratedColumn<String> syncState = GeneratedColumn<String>(
    'sync_state',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT \'pending\'',
    defaultValue: const CustomExpression('\'pending\''),
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    testId,
    front,
    answers,
    questionKey,
    createdAt,
    updatedAt,
    basePayload,
    serverUpdatedAt,
    syncState,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cards';
  @override
  VerificationContext validateIntegrity(
    Insertable<CardDatabaseDto> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('test_id')) {
      context.handle(
        _testIdMeta,
        testId.isAcceptableOrUnknown(data['test_id']!, _testIdMeta),
      );
    } else if (isInserting) {
      context.missing(_testIdMeta);
    }
    if (data.containsKey('front')) {
      context.handle(
        _frontMeta,
        front.isAcceptableOrUnknown(data['front']!, _frontMeta),
      );
    } else if (isInserting) {
      context.missing(_frontMeta);
    }
    if (data.containsKey('answers')) {
      context.handle(
        _answersMeta,
        answers.isAcceptableOrUnknown(data['answers']!, _answersMeta),
      );
    } else if (isInserting) {
      context.missing(_answersMeta);
    }
    if (data.containsKey('question_key')) {
      context.handle(
        _questionKeyMeta,
        questionKey.isAcceptableOrUnknown(
          data['question_key']!,
          _questionKeyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_questionKeyMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('base_payload')) {
      context.handle(
        _basePayloadMeta,
        basePayload.isAcceptableOrUnknown(
          data['base_payload']!,
          _basePayloadMeta,
        ),
      );
    }
    if (data.containsKey('server_updated_at')) {
      context.handle(
        _serverUpdatedAtMeta,
        serverUpdatedAt.isAcceptableOrUnknown(
          data['server_updated_at']!,
          _serverUpdatedAtMeta,
        ),
      );
    }
    if (data.containsKey('sync_state')) {
      context.handle(
        _syncStateMeta,
        syncState.isAcceptableOrUnknown(data['sync_state']!, _syncStateMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CardDatabaseDto map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CardDatabaseDto(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      testId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}test_id'],
      )!,
      front: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}front'],
      )!,
      answers: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}answers'],
      )!,
      questionKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}question_key'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      basePayload: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}base_payload'],
      ),
      serverUpdatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}server_updated_at'],
      ),
      syncState: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_state'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  Cards createAlias(String alias) {
    return Cards(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class CardDatabaseDto extends DataClass implements Insertable<CardDatabaseDto> {
  final String id;
  final String testId;
  final String front;
  final String answers;
  final String questionKey;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? basePayload;

  /// server_updated_at — TEXT (ISO-8601 UTC с миллисекундами), а не DATETIME:
  /// drift хранит DATETIME как unix-секунды, а LWW на сервере сравнивает
  /// время с точностью до миллисекунд.
  final String? serverUpdatedAt;
  final String syncState;
  final DateTime? deletedAt;
  const CardDatabaseDto({
    required this.id,
    required this.testId,
    required this.front,
    required this.answers,
    required this.questionKey,
    required this.createdAt,
    required this.updatedAt,
    this.basePayload,
    this.serverUpdatedAt,
    required this.syncState,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['test_id'] = Variable<String>(testId);
    map['front'] = Variable<String>(front);
    map['answers'] = Variable<String>(answers);
    map['question_key'] = Variable<String>(questionKey);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || basePayload != null) {
      map['base_payload'] = Variable<String>(basePayload);
    }
    if (!nullToAbsent || serverUpdatedAt != null) {
      map['server_updated_at'] = Variable<String>(serverUpdatedAt);
    }
    map['sync_state'] = Variable<String>(syncState);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  CardsCompanion toCompanion(bool nullToAbsent) {
    return CardsCompanion(
      id: Value(id),
      testId: Value(testId),
      front: Value(front),
      answers: Value(answers),
      questionKey: Value(questionKey),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      basePayload: basePayload == null && nullToAbsent
          ? const Value.absent()
          : Value(basePayload),
      serverUpdatedAt: serverUpdatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(serverUpdatedAt),
      syncState: Value(syncState),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory CardDatabaseDto.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CardDatabaseDto(
      id: serializer.fromJson<String>(json['id']),
      testId: serializer.fromJson<String>(json['test_id']),
      front: serializer.fromJson<String>(json['front']),
      answers: serializer.fromJson<String>(json['answers']),
      questionKey: serializer.fromJson<String>(json['question_key']),
      createdAt: serializer.fromJson<DateTime>(json['created_at']),
      updatedAt: serializer.fromJson<DateTime>(json['updated_at']),
      basePayload: serializer.fromJson<String?>(json['base_payload']),
      serverUpdatedAt: serializer.fromJson<String?>(json['server_updated_at']),
      syncState: serializer.fromJson<String>(json['sync_state']),
      deletedAt: serializer.fromJson<DateTime?>(json['deleted_at']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'test_id': serializer.toJson<String>(testId),
      'front': serializer.toJson<String>(front),
      'answers': serializer.toJson<String>(answers),
      'question_key': serializer.toJson<String>(questionKey),
      'created_at': serializer.toJson<DateTime>(createdAt),
      'updated_at': serializer.toJson<DateTime>(updatedAt),
      'base_payload': serializer.toJson<String?>(basePayload),
      'server_updated_at': serializer.toJson<String?>(serverUpdatedAt),
      'sync_state': serializer.toJson<String>(syncState),
      'deleted_at': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  CardDatabaseDto copyWith({
    String? id,
    String? testId,
    String? front,
    String? answers,
    String? questionKey,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<String?> basePayload = const Value.absent(),
    Value<String?> serverUpdatedAt = const Value.absent(),
    String? syncState,
    Value<DateTime?> deletedAt = const Value.absent(),
  }) => CardDatabaseDto(
    id: id ?? this.id,
    testId: testId ?? this.testId,
    front: front ?? this.front,
    answers: answers ?? this.answers,
    questionKey: questionKey ?? this.questionKey,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    basePayload: basePayload.present ? basePayload.value : this.basePayload,
    serverUpdatedAt: serverUpdatedAt.present
        ? serverUpdatedAt.value
        : this.serverUpdatedAt,
    syncState: syncState ?? this.syncState,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  CardDatabaseDto copyWithCompanion(CardsCompanion data) {
    return CardDatabaseDto(
      id: data.id.present ? data.id.value : this.id,
      testId: data.testId.present ? data.testId.value : this.testId,
      front: data.front.present ? data.front.value : this.front,
      answers: data.answers.present ? data.answers.value : this.answers,
      questionKey: data.questionKey.present
          ? data.questionKey.value
          : this.questionKey,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      basePayload: data.basePayload.present
          ? data.basePayload.value
          : this.basePayload,
      serverUpdatedAt: data.serverUpdatedAt.present
          ? data.serverUpdatedAt.value
          : this.serverUpdatedAt,
      syncState: data.syncState.present ? data.syncState.value : this.syncState,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CardDatabaseDto(')
          ..write('id: $id, ')
          ..write('testId: $testId, ')
          ..write('front: $front, ')
          ..write('answers: $answers, ')
          ..write('questionKey: $questionKey, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('basePayload: $basePayload, ')
          ..write('serverUpdatedAt: $serverUpdatedAt, ')
          ..write('syncState: $syncState, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    testId,
    front,
    answers,
    questionKey,
    createdAt,
    updatedAt,
    basePayload,
    serverUpdatedAt,
    syncState,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CardDatabaseDto &&
          other.id == this.id &&
          other.testId == this.testId &&
          other.front == this.front &&
          other.answers == this.answers &&
          other.questionKey == this.questionKey &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.basePayload == this.basePayload &&
          other.serverUpdatedAt == this.serverUpdatedAt &&
          other.syncState == this.syncState &&
          other.deletedAt == this.deletedAt);
}

class CardsCompanion extends UpdateCompanion<CardDatabaseDto> {
  final Value<String> id;
  final Value<String> testId;
  final Value<String> front;
  final Value<String> answers;
  final Value<String> questionKey;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String?> basePayload;
  final Value<String?> serverUpdatedAt;
  final Value<String> syncState;
  final Value<DateTime?> deletedAt;
  final Value<int> rowid;
  const CardsCompanion({
    this.id = const Value.absent(),
    this.testId = const Value.absent(),
    this.front = const Value.absent(),
    this.answers = const Value.absent(),
    this.questionKey = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.basePayload = const Value.absent(),
    this.serverUpdatedAt = const Value.absent(),
    this.syncState = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CardsCompanion.insert({
    required String id,
    required String testId,
    required String front,
    required String answers,
    required String questionKey,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.basePayload = const Value.absent(),
    this.serverUpdatedAt = const Value.absent(),
    this.syncState = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       testId = Value(testId),
       front = Value(front),
       answers = Value(answers),
       questionKey = Value(questionKey),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<CardDatabaseDto> custom({
    Expression<String>? id,
    Expression<String>? testId,
    Expression<String>? front,
    Expression<String>? answers,
    Expression<String>? questionKey,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? basePayload,
    Expression<String>? serverUpdatedAt,
    Expression<String>? syncState,
    Expression<DateTime>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (testId != null) 'test_id': testId,
      if (front != null) 'front': front,
      if (answers != null) 'answers': answers,
      if (questionKey != null) 'question_key': questionKey,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (basePayload != null) 'base_payload': basePayload,
      if (serverUpdatedAt != null) 'server_updated_at': serverUpdatedAt,
      if (syncState != null) 'sync_state': syncState,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CardsCompanion copyWith({
    Value<String>? id,
    Value<String>? testId,
    Value<String>? front,
    Value<String>? answers,
    Value<String>? questionKey,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String?>? basePayload,
    Value<String?>? serverUpdatedAt,
    Value<String>? syncState,
    Value<DateTime?>? deletedAt,
    Value<int>? rowid,
  }) {
    return CardsCompanion(
      id: id ?? this.id,
      testId: testId ?? this.testId,
      front: front ?? this.front,
      answers: answers ?? this.answers,
      questionKey: questionKey ?? this.questionKey,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      basePayload: basePayload ?? this.basePayload,
      serverUpdatedAt: serverUpdatedAt ?? this.serverUpdatedAt,
      syncState: syncState ?? this.syncState,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (testId.present) {
      map['test_id'] = Variable<String>(testId.value);
    }
    if (front.present) {
      map['front'] = Variable<String>(front.value);
    }
    if (answers.present) {
      map['answers'] = Variable<String>(answers.value);
    }
    if (questionKey.present) {
      map['question_key'] = Variable<String>(questionKey.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (basePayload.present) {
      map['base_payload'] = Variable<String>(basePayload.value);
    }
    if (serverUpdatedAt.present) {
      map['server_updated_at'] = Variable<String>(serverUpdatedAt.value);
    }
    if (syncState.present) {
      map['sync_state'] = Variable<String>(syncState.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CardsCompanion(')
          ..write('id: $id, ')
          ..write('testId: $testId, ')
          ..write('front: $front, ')
          ..write('answers: $answers, ')
          ..write('questionKey: $questionKey, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('basePayload: $basePayload, ')
          ..write('serverUpdatedAt: $serverUpdatedAt, ')
          ..write('syncState: $syncState, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final TestAttempts testAttempts = TestAttempts(this);
  late final Index idxTestAttemptsTest = Index(
    'idx_test_attempts_test',
    'CREATE INDEX IF NOT EXISTS idx_test_attempts_test ON test_attempts (test_id, completed_at)',
  );
  late final TestAttemptAnswers testAttemptAnswers = TestAttemptAnswers(this);
  late final Index idxTestAttemptAnswersAttempt = Index(
    'idx_test_attempt_answers_attempt',
    'CREATE INDEX IF NOT EXISTS idx_test_attempt_answers_attempt ON test_attempt_answers (attempt_id)',
  );
  late final SyncMeta syncMeta = SyncMeta(this);
  late final AnswerEventsOutbox answerEventsOutbox = AnswerEventsOutbox(this);
  late final Index idxAnswerEventsOutboxSentAt = Index(
    'idx_answer_events_outbox_sent_at',
    'CREATE INDEX IF NOT EXISTS idx_answer_events_outbox_sent_at ON answer_events_outbox (sent_at)',
  );
  late final ActiveSessions activeSessions = ActiveSessions(this);
  late final TestGroups testGroups = TestGroups(this);
  late final Tests tests = Tests(this);
  late final TestGroupEntries testGroupEntries = TestGroupEntries(this);
  late final Index idxTestGroupsSyncState = Index(
    'idx_test_groups_sync_state',
    'CREATE INDEX IF NOT EXISTS idx_test_groups_sync_state ON test_groups (sync_state)',
  );
  late final QuestionStats questionStats = QuestionStats(this);
  late final Index idxQuestionStatsSyncState = Index(
    'idx_question_stats_sync_state',
    'CREATE INDEX IF NOT EXISTS idx_question_stats_sync_state ON question_stats (sync_state)',
  );
  late final Cards cards = Cards(this);
  late final Index idxCardsTestId = Index(
    'idx_cards_test_id',
    'CREATE INDEX IF NOT EXISTS idx_cards_test_id ON cards (test_id)',
  );
  late final Index idxCardsSyncState = Index(
    'idx_cards_sync_state',
    'CREATE INDEX IF NOT EXISTS idx_cards_sync_state ON cards (sync_state)',
  );
  late final Index idxTestsSyncState = Index(
    'idx_tests_sync_state',
    'CREATE INDEX IF NOT EXISTS idx_tests_sync_state ON tests (sync_state)',
  );
  late final TestsDatabase testsDatabase = TestsDatabase(this as AppDatabase);
  late final CardsDatabase cardsDatabase = CardsDatabase(this as AppDatabase);
  late final QuestionStatsDatabase questionStatsDatabase =
      QuestionStatsDatabase(this as AppDatabase);
  late final GroupsDatabase groupsDatabase = GroupsDatabase(
    this as AppDatabase,
  );
  late final ActiveSessionsDatabase activeSessionsDatabase =
      ActiveSessionsDatabase(this as AppDatabase);
  late final SyncDatabase syncDatabase = SyncDatabase(this as AppDatabase);
  late final TestAttemptsDatabase testAttemptsDatabase = TestAttemptsDatabase(
    this as AppDatabase,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    testAttempts,
    idxTestAttemptsTest,
    testAttemptAnswers,
    idxTestAttemptAnswersAttempt,
    syncMeta,
    answerEventsOutbox,
    idxAnswerEventsOutboxSentAt,
    activeSessions,
    testGroups,
    tests,
    testGroupEntries,
    idxTestGroupsSyncState,
    questionStats,
    idxQuestionStatsSyncState,
    cards,
    idxCardsTestId,
    idxCardsSyncState,
    idxTestsSyncState,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'test_groups',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('test_group_entries', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'tests',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('test_group_entries', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'tests',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('cards', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $TestAttemptsCreateCompanionBuilder =
    TestAttemptsCompanion Function({
      required String id,
      required String testId,
      required DateTime startedAt,
      required DateTime completedAt,
      required int total,
      required int correct,
      required bool mixup,
      required bool swapSides,
      Value<int> rowid,
    });
typedef $TestAttemptsUpdateCompanionBuilder =
    TestAttemptsCompanion Function({
      Value<String> id,
      Value<String> testId,
      Value<DateTime> startedAt,
      Value<DateTime> completedAt,
      Value<int> total,
      Value<int> correct,
      Value<bool> mixup,
      Value<bool> swapSides,
      Value<int> rowid,
    });

class $TestAttemptsFilterComposer
    extends Composer<_$AppDatabase, TestAttempts> {
  $TestAttemptsFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get testId => $composableBuilder(
    column: $table.testId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get correct => $composableBuilder(
    column: $table.correct,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get mixup => $composableBuilder(
    column: $table.mixup,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get swapSides => $composableBuilder(
    column: $table.swapSides,
    builder: (column) => ColumnFilters(column),
  );
}

class $TestAttemptsOrderingComposer
    extends Composer<_$AppDatabase, TestAttempts> {
  $TestAttemptsOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get testId => $composableBuilder(
    column: $table.testId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get correct => $composableBuilder(
    column: $table.correct,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get mixup => $composableBuilder(
    column: $table.mixup,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get swapSides => $composableBuilder(
    column: $table.swapSides,
    builder: (column) => ColumnOrderings(column),
  );
}

class $TestAttemptsAnnotationComposer
    extends Composer<_$AppDatabase, TestAttempts> {
  $TestAttemptsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get testId =>
      $composableBuilder(column: $table.testId, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get total =>
      $composableBuilder(column: $table.total, builder: (column) => column);

  GeneratedColumn<int> get correct =>
      $composableBuilder(column: $table.correct, builder: (column) => column);

  GeneratedColumn<bool> get mixup =>
      $composableBuilder(column: $table.mixup, builder: (column) => column);

  GeneratedColumn<bool> get swapSides =>
      $composableBuilder(column: $table.swapSides, builder: (column) => column);
}

class $TestAttemptsTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          TestAttempts,
          TestAttemptDatabaseDto,
          $TestAttemptsFilterComposer,
          $TestAttemptsOrderingComposer,
          $TestAttemptsAnnotationComposer,
          $TestAttemptsCreateCompanionBuilder,
          $TestAttemptsUpdateCompanionBuilder,
          (
            TestAttemptDatabaseDto,
            BaseReferences<_$AppDatabase, TestAttempts, TestAttemptDatabaseDto>,
          ),
          TestAttemptDatabaseDto,
          PrefetchHooks Function()
        > {
  $TestAttemptsTableManager(_$AppDatabase db, TestAttempts table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $TestAttemptsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $TestAttemptsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $TestAttemptsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> testId = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<DateTime> completedAt = const Value.absent(),
                Value<int> total = const Value.absent(),
                Value<int> correct = const Value.absent(),
                Value<bool> mixup = const Value.absent(),
                Value<bool> swapSides = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TestAttemptsCompanion(
                id: id,
                testId: testId,
                startedAt: startedAt,
                completedAt: completedAt,
                total: total,
                correct: correct,
                mixup: mixup,
                swapSides: swapSides,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String testId,
                required DateTime startedAt,
                required DateTime completedAt,
                required int total,
                required int correct,
                required bool mixup,
                required bool swapSides,
                Value<int> rowid = const Value.absent(),
              }) => TestAttemptsCompanion.insert(
                id: id,
                testId: testId,
                startedAt: startedAt,
                completedAt: completedAt,
                total: total,
                correct: correct,
                mixup: mixup,
                swapSides: swapSides,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $TestAttemptsProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      TestAttempts,
      TestAttemptDatabaseDto,
      $TestAttemptsFilterComposer,
      $TestAttemptsOrderingComposer,
      $TestAttemptsAnnotationComposer,
      $TestAttemptsCreateCompanionBuilder,
      $TestAttemptsUpdateCompanionBuilder,
      (
        TestAttemptDatabaseDto,
        BaseReferences<_$AppDatabase, TestAttempts, TestAttemptDatabaseDto>,
      ),
      TestAttemptDatabaseDto,
      PrefetchHooks Function()
    >;
typedef $TestAttemptAnswersCreateCompanionBuilder =
    TestAttemptAnswersCompanion Function({
      Value<int> id,
      required String attemptId,
      required String questionKey,
      required bool isCorrect,
    });
typedef $TestAttemptAnswersUpdateCompanionBuilder =
    TestAttemptAnswersCompanion Function({
      Value<int> id,
      Value<String> attemptId,
      Value<String> questionKey,
      Value<bool> isCorrect,
    });

class $TestAttemptAnswersFilterComposer
    extends Composer<_$AppDatabase, TestAttemptAnswers> {
  $TestAttemptAnswersFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get attemptId => $composableBuilder(
    column: $table.attemptId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get questionKey => $composableBuilder(
    column: $table.questionKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCorrect => $composableBuilder(
    column: $table.isCorrect,
    builder: (column) => ColumnFilters(column),
  );
}

class $TestAttemptAnswersOrderingComposer
    extends Composer<_$AppDatabase, TestAttemptAnswers> {
  $TestAttemptAnswersOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get attemptId => $composableBuilder(
    column: $table.attemptId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get questionKey => $composableBuilder(
    column: $table.questionKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCorrect => $composableBuilder(
    column: $table.isCorrect,
    builder: (column) => ColumnOrderings(column),
  );
}

class $TestAttemptAnswersAnnotationComposer
    extends Composer<_$AppDatabase, TestAttemptAnswers> {
  $TestAttemptAnswersAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get attemptId =>
      $composableBuilder(column: $table.attemptId, builder: (column) => column);

  GeneratedColumn<String> get questionKey => $composableBuilder(
    column: $table.questionKey,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isCorrect =>
      $composableBuilder(column: $table.isCorrect, builder: (column) => column);
}

class $TestAttemptAnswersTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          TestAttemptAnswers,
          TestAttemptAnswerDatabaseDto,
          $TestAttemptAnswersFilterComposer,
          $TestAttemptAnswersOrderingComposer,
          $TestAttemptAnswersAnnotationComposer,
          $TestAttemptAnswersCreateCompanionBuilder,
          $TestAttemptAnswersUpdateCompanionBuilder,
          (
            TestAttemptAnswerDatabaseDto,
            BaseReferences<
              _$AppDatabase,
              TestAttemptAnswers,
              TestAttemptAnswerDatabaseDto
            >,
          ),
          TestAttemptAnswerDatabaseDto,
          PrefetchHooks Function()
        > {
  $TestAttemptAnswersTableManager(_$AppDatabase db, TestAttemptAnswers table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $TestAttemptAnswersFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $TestAttemptAnswersOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $TestAttemptAnswersAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> attemptId = const Value.absent(),
                Value<String> questionKey = const Value.absent(),
                Value<bool> isCorrect = const Value.absent(),
              }) => TestAttemptAnswersCompanion(
                id: id,
                attemptId: attemptId,
                questionKey: questionKey,
                isCorrect: isCorrect,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String attemptId,
                required String questionKey,
                required bool isCorrect,
              }) => TestAttemptAnswersCompanion.insert(
                id: id,
                attemptId: attemptId,
                questionKey: questionKey,
                isCorrect: isCorrect,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $TestAttemptAnswersProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      TestAttemptAnswers,
      TestAttemptAnswerDatabaseDto,
      $TestAttemptAnswersFilterComposer,
      $TestAttemptAnswersOrderingComposer,
      $TestAttemptAnswersAnnotationComposer,
      $TestAttemptAnswersCreateCompanionBuilder,
      $TestAttemptAnswersUpdateCompanionBuilder,
      (
        TestAttemptAnswerDatabaseDto,
        BaseReferences<
          _$AppDatabase,
          TestAttemptAnswers,
          TestAttemptAnswerDatabaseDto
        >,
      ),
      TestAttemptAnswerDatabaseDto,
      PrefetchHooks Function()
    >;
typedef $SyncMetaCreateCompanionBuilder =
    SyncMetaCompanion Function({
      required String metaKey,
      required String metaValue,
      Value<int> rowid,
    });
typedef $SyncMetaUpdateCompanionBuilder =
    SyncMetaCompanion Function({
      Value<String> metaKey,
      Value<String> metaValue,
      Value<int> rowid,
    });

class $SyncMetaFilterComposer extends Composer<_$AppDatabase, SyncMeta> {
  $SyncMetaFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get metaKey => $composableBuilder(
    column: $table.metaKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get metaValue => $composableBuilder(
    column: $table.metaValue,
    builder: (column) => ColumnFilters(column),
  );
}

class $SyncMetaOrderingComposer extends Composer<_$AppDatabase, SyncMeta> {
  $SyncMetaOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get metaKey => $composableBuilder(
    column: $table.metaKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get metaValue => $composableBuilder(
    column: $table.metaValue,
    builder: (column) => ColumnOrderings(column),
  );
}

class $SyncMetaAnnotationComposer extends Composer<_$AppDatabase, SyncMeta> {
  $SyncMetaAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get metaKey =>
      $composableBuilder(column: $table.metaKey, builder: (column) => column);

  GeneratedColumn<String> get metaValue =>
      $composableBuilder(column: $table.metaValue, builder: (column) => column);
}

class $SyncMetaTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          SyncMeta,
          SyncMetaDatabaseDto,
          $SyncMetaFilterComposer,
          $SyncMetaOrderingComposer,
          $SyncMetaAnnotationComposer,
          $SyncMetaCreateCompanionBuilder,
          $SyncMetaUpdateCompanionBuilder,
          (
            SyncMetaDatabaseDto,
            BaseReferences<_$AppDatabase, SyncMeta, SyncMetaDatabaseDto>,
          ),
          SyncMetaDatabaseDto,
          PrefetchHooks Function()
        > {
  $SyncMetaTableManager(_$AppDatabase db, SyncMeta table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $SyncMetaFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $SyncMetaOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $SyncMetaAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> metaKey = const Value.absent(),
                Value<String> metaValue = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncMetaCompanion(
                metaKey: metaKey,
                metaValue: metaValue,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String metaKey,
                required String metaValue,
                Value<int> rowid = const Value.absent(),
              }) => SyncMetaCompanion.insert(
                metaKey: metaKey,
                metaValue: metaValue,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $SyncMetaProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      SyncMeta,
      SyncMetaDatabaseDto,
      $SyncMetaFilterComposer,
      $SyncMetaOrderingComposer,
      $SyncMetaAnnotationComposer,
      $SyncMetaCreateCompanionBuilder,
      $SyncMetaUpdateCompanionBuilder,
      (
        SyncMetaDatabaseDto,
        BaseReferences<_$AppDatabase, SyncMeta, SyncMetaDatabaseDto>,
      ),
      SyncMetaDatabaseDto,
      PrefetchHooks Function()
    >;
typedef $AnswerEventsOutboxCreateCompanionBuilder =
    AnswerEventsOutboxCompanion Function({
      Value<int> id,
      required String cardId,
      required bool isCorrect,
      required DateTime answeredAt,
      Value<DateTime?> sentAt,
    });
typedef $AnswerEventsOutboxUpdateCompanionBuilder =
    AnswerEventsOutboxCompanion Function({
      Value<int> id,
      Value<String> cardId,
      Value<bool> isCorrect,
      Value<DateTime> answeredAt,
      Value<DateTime?> sentAt,
    });

class $AnswerEventsOutboxFilterComposer
    extends Composer<_$AppDatabase, AnswerEventsOutbox> {
  $AnswerEventsOutboxFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cardId => $composableBuilder(
    column: $table.cardId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCorrect => $composableBuilder(
    column: $table.isCorrect,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get answeredAt => $composableBuilder(
    column: $table.answeredAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get sentAt => $composableBuilder(
    column: $table.sentAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $AnswerEventsOutboxOrderingComposer
    extends Composer<_$AppDatabase, AnswerEventsOutbox> {
  $AnswerEventsOutboxOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cardId => $composableBuilder(
    column: $table.cardId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCorrect => $composableBuilder(
    column: $table.isCorrect,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get answeredAt => $composableBuilder(
    column: $table.answeredAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get sentAt => $composableBuilder(
    column: $table.sentAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $AnswerEventsOutboxAnnotationComposer
    extends Composer<_$AppDatabase, AnswerEventsOutbox> {
  $AnswerEventsOutboxAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get cardId =>
      $composableBuilder(column: $table.cardId, builder: (column) => column);

  GeneratedColumn<bool> get isCorrect =>
      $composableBuilder(column: $table.isCorrect, builder: (column) => column);

  GeneratedColumn<DateTime> get answeredAt => $composableBuilder(
    column: $table.answeredAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get sentAt =>
      $composableBuilder(column: $table.sentAt, builder: (column) => column);
}

class $AnswerEventsOutboxTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          AnswerEventsOutbox,
          AnswerEventOutboxDatabaseDto,
          $AnswerEventsOutboxFilterComposer,
          $AnswerEventsOutboxOrderingComposer,
          $AnswerEventsOutboxAnnotationComposer,
          $AnswerEventsOutboxCreateCompanionBuilder,
          $AnswerEventsOutboxUpdateCompanionBuilder,
          (
            AnswerEventOutboxDatabaseDto,
            BaseReferences<
              _$AppDatabase,
              AnswerEventsOutbox,
              AnswerEventOutboxDatabaseDto
            >,
          ),
          AnswerEventOutboxDatabaseDto,
          PrefetchHooks Function()
        > {
  $AnswerEventsOutboxTableManager(_$AppDatabase db, AnswerEventsOutbox table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $AnswerEventsOutboxFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $AnswerEventsOutboxOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $AnswerEventsOutboxAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> cardId = const Value.absent(),
                Value<bool> isCorrect = const Value.absent(),
                Value<DateTime> answeredAt = const Value.absent(),
                Value<DateTime?> sentAt = const Value.absent(),
              }) => AnswerEventsOutboxCompanion(
                id: id,
                cardId: cardId,
                isCorrect: isCorrect,
                answeredAt: answeredAt,
                sentAt: sentAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String cardId,
                required bool isCorrect,
                required DateTime answeredAt,
                Value<DateTime?> sentAt = const Value.absent(),
              }) => AnswerEventsOutboxCompanion.insert(
                id: id,
                cardId: cardId,
                isCorrect: isCorrect,
                answeredAt: answeredAt,
                sentAt: sentAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $AnswerEventsOutboxProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      AnswerEventsOutbox,
      AnswerEventOutboxDatabaseDto,
      $AnswerEventsOutboxFilterComposer,
      $AnswerEventsOutboxOrderingComposer,
      $AnswerEventsOutboxAnnotationComposer,
      $AnswerEventsOutboxCreateCompanionBuilder,
      $AnswerEventsOutboxUpdateCompanionBuilder,
      (
        AnswerEventOutboxDatabaseDto,
        BaseReferences<
          _$AppDatabase,
          AnswerEventsOutbox,
          AnswerEventOutboxDatabaseDto
        >,
      ),
      AnswerEventOutboxDatabaseDto,
      PrefetchHooks Function()
    >;
typedef $ActiveSessionsCreateCompanionBuilder =
    ActiveSessionsCompanion Function({Value<int> id, required String data});
typedef $ActiveSessionsUpdateCompanionBuilder =
    ActiveSessionsCompanion Function({Value<int> id, Value<String> data});

class $ActiveSessionsFilterComposer
    extends Composer<_$AppDatabase, ActiveSessions> {
  $ActiveSessionsFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get data => $composableBuilder(
    column: $table.data,
    builder: (column) => ColumnFilters(column),
  );
}

class $ActiveSessionsOrderingComposer
    extends Composer<_$AppDatabase, ActiveSessions> {
  $ActiveSessionsOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get data => $composableBuilder(
    column: $table.data,
    builder: (column) => ColumnOrderings(column),
  );
}

class $ActiveSessionsAnnotationComposer
    extends Composer<_$AppDatabase, ActiveSessions> {
  $ActiveSessionsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get data =>
      $composableBuilder(column: $table.data, builder: (column) => column);
}

class $ActiveSessionsTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          ActiveSessions,
          ActiveSessionDatabaseDto,
          $ActiveSessionsFilterComposer,
          $ActiveSessionsOrderingComposer,
          $ActiveSessionsAnnotationComposer,
          $ActiveSessionsCreateCompanionBuilder,
          $ActiveSessionsUpdateCompanionBuilder,
          (
            ActiveSessionDatabaseDto,
            BaseReferences<
              _$AppDatabase,
              ActiveSessions,
              ActiveSessionDatabaseDto
            >,
          ),
          ActiveSessionDatabaseDto,
          PrefetchHooks Function()
        > {
  $ActiveSessionsTableManager(_$AppDatabase db, ActiveSessions table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $ActiveSessionsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $ActiveSessionsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $ActiveSessionsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> data = const Value.absent(),
              }) => ActiveSessionsCompanion(id: id, data: data),
          createCompanionCallback:
              ({Value<int> id = const Value.absent(), required String data}) =>
                  ActiveSessionsCompanion.insert(id: id, data: data),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $ActiveSessionsProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      ActiveSessions,
      ActiveSessionDatabaseDto,
      $ActiveSessionsFilterComposer,
      $ActiveSessionsOrderingComposer,
      $ActiveSessionsAnnotationComposer,
      $ActiveSessionsCreateCompanionBuilder,
      $ActiveSessionsUpdateCompanionBuilder,
      (
        ActiveSessionDatabaseDto,
        BaseReferences<_$AppDatabase, ActiveSessions, ActiveSessionDatabaseDto>,
      ),
      ActiveSessionDatabaseDto,
      PrefetchHooks Function()
    >;
typedef $TestGroupsCreateCompanionBuilder =
    TestGroupsCompanion Function({
      required String id,
      required String title,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<String?> basePayload,
      Value<String?> serverUpdatedAt,
      Value<String> syncState,
      Value<DateTime?> deletedAt,
      Value<int> rowid,
    });
typedef $TestGroupsUpdateCompanionBuilder =
    TestGroupsCompanion Function({
      Value<String> id,
      Value<String> title,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String?> basePayload,
      Value<String?> serverUpdatedAt,
      Value<String> syncState,
      Value<DateTime?> deletedAt,
      Value<int> rowid,
    });

final class $TestGroupsReferences
    extends BaseReferences<_$AppDatabase, TestGroups, TestGroupDatabaseDto> {
  $TestGroupsReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<TestGroupEntries, List<TestGroupEntryDatabaseDto>>
  _testGroupEntriesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.testGroupEntries,
    aliasName: $_aliasNameGenerator(
      db.testGroups.id,
      db.testGroupEntries.groupId,
    ),
  );

  $TestGroupEntriesProcessedTableManager get testGroupEntriesRefs {
    final manager = $TestGroupEntriesTableManager(
      $_db,
      $_db.testGroupEntries,
    ).filter((f) => f.groupId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _testGroupEntriesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $TestGroupsFilterComposer extends Composer<_$AppDatabase, TestGroups> {
  $TestGroupsFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get basePayload => $composableBuilder(
    column: $table.basePayload,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serverUpdatedAt => $composableBuilder(
    column: $table.serverUpdatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncState => $composableBuilder(
    column: $table.syncState,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> testGroupEntriesRefs(
    Expression<bool> Function($TestGroupEntriesFilterComposer f) f,
  ) {
    final $TestGroupEntriesFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.testGroupEntries,
      getReferencedColumn: (t) => t.groupId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $TestGroupEntriesFilterComposer(
            $db: $db,
            $table: $db.testGroupEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $TestGroupsOrderingComposer extends Composer<_$AppDatabase, TestGroups> {
  $TestGroupsOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get basePayload => $composableBuilder(
    column: $table.basePayload,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serverUpdatedAt => $composableBuilder(
    column: $table.serverUpdatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncState => $composableBuilder(
    column: $table.syncState,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $TestGroupsAnnotationComposer
    extends Composer<_$AppDatabase, TestGroups> {
  $TestGroupsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get basePayload => $composableBuilder(
    column: $table.basePayload,
    builder: (column) => column,
  );

  GeneratedColumn<String> get serverUpdatedAt => $composableBuilder(
    column: $table.serverUpdatedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get syncState =>
      $composableBuilder(column: $table.syncState, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  Expression<T> testGroupEntriesRefs<T extends Object>(
    Expression<T> Function($TestGroupEntriesAnnotationComposer a) f,
  ) {
    final $TestGroupEntriesAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.testGroupEntries,
      getReferencedColumn: (t) => t.groupId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $TestGroupEntriesAnnotationComposer(
            $db: $db,
            $table: $db.testGroupEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $TestGroupsTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          TestGroups,
          TestGroupDatabaseDto,
          $TestGroupsFilterComposer,
          $TestGroupsOrderingComposer,
          $TestGroupsAnnotationComposer,
          $TestGroupsCreateCompanionBuilder,
          $TestGroupsUpdateCompanionBuilder,
          (TestGroupDatabaseDto, $TestGroupsReferences),
          TestGroupDatabaseDto,
          PrefetchHooks Function({bool testGroupEntriesRefs})
        > {
  $TestGroupsTableManager(_$AppDatabase db, TestGroups table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $TestGroupsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $TestGroupsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $TestGroupsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String?> basePayload = const Value.absent(),
                Value<String?> serverUpdatedAt = const Value.absent(),
                Value<String> syncState = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TestGroupsCompanion(
                id: id,
                title: title,
                createdAt: createdAt,
                updatedAt: updatedAt,
                basePayload: basePayload,
                serverUpdatedAt: serverUpdatedAt,
                syncState: syncState,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<String?> basePayload = const Value.absent(),
                Value<String?> serverUpdatedAt = const Value.absent(),
                Value<String> syncState = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TestGroupsCompanion.insert(
                id: id,
                title: title,
                createdAt: createdAt,
                updatedAt: updatedAt,
                basePayload: basePayload,
                serverUpdatedAt: serverUpdatedAt,
                syncState: syncState,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $TestGroupsReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({testGroupEntriesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (testGroupEntriesRefs) db.testGroupEntries,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (testGroupEntriesRefs)
                    await $_getPrefetchedData<
                      TestGroupDatabaseDto,
                      TestGroups,
                      TestGroupEntryDatabaseDto
                    >(
                      currentTable: table,
                      referencedTable: $TestGroupsReferences
                          ._testGroupEntriesRefsTable(db),
                      managerFromTypedResult: (p0) => $TestGroupsReferences(
                        db,
                        table,
                        p0,
                      ).testGroupEntriesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.groupId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $TestGroupsProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      TestGroups,
      TestGroupDatabaseDto,
      $TestGroupsFilterComposer,
      $TestGroupsOrderingComposer,
      $TestGroupsAnnotationComposer,
      $TestGroupsCreateCompanionBuilder,
      $TestGroupsUpdateCompanionBuilder,
      (TestGroupDatabaseDto, $TestGroupsReferences),
      TestGroupDatabaseDto,
      PrefetchHooks Function({bool testGroupEntriesRefs})
    >;
typedef $TestsCreateCompanionBuilder =
    TestsCompanion Function({
      required String id,
      required String title,
      Value<String?> description,
      required String type,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<String?> basePayload,
      Value<String?> serverUpdatedAt,
      Value<String> syncState,
      Value<DateTime?> deletedAt,
      Value<int> rowid,
    });
typedef $TestsUpdateCompanionBuilder =
    TestsCompanion Function({
      Value<String> id,
      Value<String> title,
      Value<String?> description,
      Value<String> type,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String?> basePayload,
      Value<String?> serverUpdatedAt,
      Value<String> syncState,
      Value<DateTime?> deletedAt,
      Value<int> rowid,
    });

final class $TestsReferences
    extends BaseReferences<_$AppDatabase, Tests, TestDatabaseDto> {
  $TestsReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<TestGroupEntries, List<TestGroupEntryDatabaseDto>>
  _testGroupEntriesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.testGroupEntries,
    aliasName: $_aliasNameGenerator(db.tests.id, db.testGroupEntries.testId),
  );

  $TestGroupEntriesProcessedTableManager get testGroupEntriesRefs {
    final manager = $TestGroupEntriesTableManager(
      $_db,
      $_db.testGroupEntries,
    ).filter((f) => f.testId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _testGroupEntriesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<Cards, List<CardDatabaseDto>> _cardsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.cards,
    aliasName: $_aliasNameGenerator(db.tests.id, db.cards.testId),
  );

  $CardsProcessedTableManager get cardsRefs {
    final manager = $CardsTableManager(
      $_db,
      $_db.cards,
    ).filter((f) => f.testId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_cardsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $TestsFilterComposer extends Composer<_$AppDatabase, Tests> {
  $TestsFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get basePayload => $composableBuilder(
    column: $table.basePayload,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serverUpdatedAt => $composableBuilder(
    column: $table.serverUpdatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncState => $composableBuilder(
    column: $table.syncState,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> testGroupEntriesRefs(
    Expression<bool> Function($TestGroupEntriesFilterComposer f) f,
  ) {
    final $TestGroupEntriesFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.testGroupEntries,
      getReferencedColumn: (t) => t.testId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $TestGroupEntriesFilterComposer(
            $db: $db,
            $table: $db.testGroupEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> cardsRefs(
    Expression<bool> Function($CardsFilterComposer f) f,
  ) {
    final $CardsFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.cards,
      getReferencedColumn: (t) => t.testId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $CardsFilterComposer(
            $db: $db,
            $table: $db.cards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $TestsOrderingComposer extends Composer<_$AppDatabase, Tests> {
  $TestsOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get basePayload => $composableBuilder(
    column: $table.basePayload,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serverUpdatedAt => $composableBuilder(
    column: $table.serverUpdatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncState => $composableBuilder(
    column: $table.syncState,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $TestsAnnotationComposer extends Composer<_$AppDatabase, Tests> {
  $TestsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get basePayload => $composableBuilder(
    column: $table.basePayload,
    builder: (column) => column,
  );

  GeneratedColumn<String> get serverUpdatedAt => $composableBuilder(
    column: $table.serverUpdatedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get syncState =>
      $composableBuilder(column: $table.syncState, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  Expression<T> testGroupEntriesRefs<T extends Object>(
    Expression<T> Function($TestGroupEntriesAnnotationComposer a) f,
  ) {
    final $TestGroupEntriesAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.testGroupEntries,
      getReferencedColumn: (t) => t.testId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $TestGroupEntriesAnnotationComposer(
            $db: $db,
            $table: $db.testGroupEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> cardsRefs<T extends Object>(
    Expression<T> Function($CardsAnnotationComposer a) f,
  ) {
    final $CardsAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.cards,
      getReferencedColumn: (t) => t.testId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $CardsAnnotationComposer(
            $db: $db,
            $table: $db.cards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $TestsTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          Tests,
          TestDatabaseDto,
          $TestsFilterComposer,
          $TestsOrderingComposer,
          $TestsAnnotationComposer,
          $TestsCreateCompanionBuilder,
          $TestsUpdateCompanionBuilder,
          (TestDatabaseDto, $TestsReferences),
          TestDatabaseDto,
          PrefetchHooks Function({bool testGroupEntriesRefs, bool cardsRefs})
        > {
  $TestsTableManager(_$AppDatabase db, Tests table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $TestsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $TestsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $TestsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String?> basePayload = const Value.absent(),
                Value<String?> serverUpdatedAt = const Value.absent(),
                Value<String> syncState = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TestsCompanion(
                id: id,
                title: title,
                description: description,
                type: type,
                createdAt: createdAt,
                updatedAt: updatedAt,
                basePayload: basePayload,
                serverUpdatedAt: serverUpdatedAt,
                syncState: syncState,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                Value<String?> description = const Value.absent(),
                required String type,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<String?> basePayload = const Value.absent(),
                Value<String?> serverUpdatedAt = const Value.absent(),
                Value<String> syncState = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TestsCompanion.insert(
                id: id,
                title: title,
                description: description,
                type: type,
                createdAt: createdAt,
                updatedAt: updatedAt,
                basePayload: basePayload,
                serverUpdatedAt: serverUpdatedAt,
                syncState: syncState,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), $TestsReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback:
              ({testGroupEntriesRefs = false, cardsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (testGroupEntriesRefs) db.testGroupEntries,
                    if (cardsRefs) db.cards,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (testGroupEntriesRefs)
                        await $_getPrefetchedData<
                          TestDatabaseDto,
                          Tests,
                          TestGroupEntryDatabaseDto
                        >(
                          currentTable: table,
                          referencedTable: $TestsReferences
                              ._testGroupEntriesRefsTable(db),
                          managerFromTypedResult: (p0) => $TestsReferences(
                            db,
                            table,
                            p0,
                          ).testGroupEntriesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.testId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (cardsRefs)
                        await $_getPrefetchedData<
                          TestDatabaseDto,
                          Tests,
                          CardDatabaseDto
                        >(
                          currentTable: table,
                          referencedTable: $TestsReferences._cardsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $TestsReferences(db, table, p0).cardsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.testId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $TestsProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      Tests,
      TestDatabaseDto,
      $TestsFilterComposer,
      $TestsOrderingComposer,
      $TestsAnnotationComposer,
      $TestsCreateCompanionBuilder,
      $TestsUpdateCompanionBuilder,
      (TestDatabaseDto, $TestsReferences),
      TestDatabaseDto,
      PrefetchHooks Function({bool testGroupEntriesRefs, bool cardsRefs})
    >;
typedef $TestGroupEntriesCreateCompanionBuilder =
    TestGroupEntriesCompanion Function({
      required String id,
      required String groupId,
      required String testId,
      Value<int> rowid,
    });
typedef $TestGroupEntriesUpdateCompanionBuilder =
    TestGroupEntriesCompanion Function({
      Value<String> id,
      Value<String> groupId,
      Value<String> testId,
      Value<int> rowid,
    });

final class $TestGroupEntriesReferences
    extends
        BaseReferences<
          _$AppDatabase,
          TestGroupEntries,
          TestGroupEntryDatabaseDto
        > {
  $TestGroupEntriesReferences(super.$_db, super.$_table, super.$_typedResult);

  static TestGroups _groupIdTable(_$AppDatabase db) =>
      db.testGroups.createAlias(
        $_aliasNameGenerator(db.testGroupEntries.groupId, db.testGroups.id),
      );

  $TestGroupsProcessedTableManager get groupId {
    final $_column = $_itemColumn<String>('group_id')!;

    final manager = $TestGroupsTableManager(
      $_db,
      $_db.testGroups,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_groupIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static Tests _testIdTable(_$AppDatabase db) => db.tests.createAlias(
    $_aliasNameGenerator(db.testGroupEntries.testId, db.tests.id),
  );

  $TestsProcessedTableManager get testId {
    final $_column = $_itemColumn<String>('test_id')!;

    final manager = $TestsTableManager(
      $_db,
      $_db.tests,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_testIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $TestGroupEntriesFilterComposer
    extends Composer<_$AppDatabase, TestGroupEntries> {
  $TestGroupEntriesFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  $TestGroupsFilterComposer get groupId {
    final $TestGroupsFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.groupId,
      referencedTable: $db.testGroups,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $TestGroupsFilterComposer(
            $db: $db,
            $table: $db.testGroups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $TestsFilterComposer get testId {
    final $TestsFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.testId,
      referencedTable: $db.tests,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $TestsFilterComposer(
            $db: $db,
            $table: $db.tests,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $TestGroupEntriesOrderingComposer
    extends Composer<_$AppDatabase, TestGroupEntries> {
  $TestGroupEntriesOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  $TestGroupsOrderingComposer get groupId {
    final $TestGroupsOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.groupId,
      referencedTable: $db.testGroups,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $TestGroupsOrderingComposer(
            $db: $db,
            $table: $db.testGroups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $TestsOrderingComposer get testId {
    final $TestsOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.testId,
      referencedTable: $db.tests,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $TestsOrderingComposer(
            $db: $db,
            $table: $db.tests,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $TestGroupEntriesAnnotationComposer
    extends Composer<_$AppDatabase, TestGroupEntries> {
  $TestGroupEntriesAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  $TestGroupsAnnotationComposer get groupId {
    final $TestGroupsAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.groupId,
      referencedTable: $db.testGroups,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $TestGroupsAnnotationComposer(
            $db: $db,
            $table: $db.testGroups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $TestsAnnotationComposer get testId {
    final $TestsAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.testId,
      referencedTable: $db.tests,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $TestsAnnotationComposer(
            $db: $db,
            $table: $db.tests,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $TestGroupEntriesTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          TestGroupEntries,
          TestGroupEntryDatabaseDto,
          $TestGroupEntriesFilterComposer,
          $TestGroupEntriesOrderingComposer,
          $TestGroupEntriesAnnotationComposer,
          $TestGroupEntriesCreateCompanionBuilder,
          $TestGroupEntriesUpdateCompanionBuilder,
          (TestGroupEntryDatabaseDto, $TestGroupEntriesReferences),
          TestGroupEntryDatabaseDto,
          PrefetchHooks Function({bool groupId, bool testId})
        > {
  $TestGroupEntriesTableManager(_$AppDatabase db, TestGroupEntries table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $TestGroupEntriesFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $TestGroupEntriesOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $TestGroupEntriesAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> groupId = const Value.absent(),
                Value<String> testId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TestGroupEntriesCompanion(
                id: id,
                groupId: groupId,
                testId: testId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String groupId,
                required String testId,
                Value<int> rowid = const Value.absent(),
              }) => TestGroupEntriesCompanion.insert(
                id: id,
                groupId: groupId,
                testId: testId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $TestGroupEntriesReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({groupId = false, testId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (groupId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.groupId,
                                referencedTable: $TestGroupEntriesReferences
                                    ._groupIdTable(db),
                                referencedColumn: $TestGroupEntriesReferences
                                    ._groupIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (testId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.testId,
                                referencedTable: $TestGroupEntriesReferences
                                    ._testIdTable(db),
                                referencedColumn: $TestGroupEntriesReferences
                                    ._testIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $TestGroupEntriesProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      TestGroupEntries,
      TestGroupEntryDatabaseDto,
      $TestGroupEntriesFilterComposer,
      $TestGroupEntriesOrderingComposer,
      $TestGroupEntriesAnnotationComposer,
      $TestGroupEntriesCreateCompanionBuilder,
      $TestGroupEntriesUpdateCompanionBuilder,
      (TestGroupEntryDatabaseDto, $TestGroupEntriesReferences),
      TestGroupEntryDatabaseDto,
      PrefetchHooks Function({bool groupId, bool testId})
    >;
typedef $QuestionStatsCreateCompanionBuilder =
    QuestionStatsCompanion Function({
      Value<int> id,
      required String questionKey,
      required String frontText,
      required String backText,
      Value<int> streak,
      Value<int> totalCorrect,
      Value<int> totalIncorrect,
      Value<int> totalShown,
      Value<DateTime?> lastAnsweredAt,
      Value<DateTime?> lastShownAt,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<String> syncState,
    });
typedef $QuestionStatsUpdateCompanionBuilder =
    QuestionStatsCompanion Function({
      Value<int> id,
      Value<String> questionKey,
      Value<String> frontText,
      Value<String> backText,
      Value<int> streak,
      Value<int> totalCorrect,
      Value<int> totalIncorrect,
      Value<int> totalShown,
      Value<DateTime?> lastAnsweredAt,
      Value<DateTime?> lastShownAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> syncState,
    });

class $QuestionStatsFilterComposer
    extends Composer<_$AppDatabase, QuestionStats> {
  $QuestionStatsFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get questionKey => $composableBuilder(
    column: $table.questionKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get frontText => $composableBuilder(
    column: $table.frontText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get backText => $composableBuilder(
    column: $table.backText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get streak => $composableBuilder(
    column: $table.streak,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalCorrect => $composableBuilder(
    column: $table.totalCorrect,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalIncorrect => $composableBuilder(
    column: $table.totalIncorrect,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalShown => $composableBuilder(
    column: $table.totalShown,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastAnsweredAt => $composableBuilder(
    column: $table.lastAnsweredAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastShownAt => $composableBuilder(
    column: $table.lastShownAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncState => $composableBuilder(
    column: $table.syncState,
    builder: (column) => ColumnFilters(column),
  );
}

class $QuestionStatsOrderingComposer
    extends Composer<_$AppDatabase, QuestionStats> {
  $QuestionStatsOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get questionKey => $composableBuilder(
    column: $table.questionKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get frontText => $composableBuilder(
    column: $table.frontText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get backText => $composableBuilder(
    column: $table.backText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get streak => $composableBuilder(
    column: $table.streak,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalCorrect => $composableBuilder(
    column: $table.totalCorrect,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalIncorrect => $composableBuilder(
    column: $table.totalIncorrect,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalShown => $composableBuilder(
    column: $table.totalShown,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastAnsweredAt => $composableBuilder(
    column: $table.lastAnsweredAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastShownAt => $composableBuilder(
    column: $table.lastShownAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncState => $composableBuilder(
    column: $table.syncState,
    builder: (column) => ColumnOrderings(column),
  );
}

class $QuestionStatsAnnotationComposer
    extends Composer<_$AppDatabase, QuestionStats> {
  $QuestionStatsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get questionKey => $composableBuilder(
    column: $table.questionKey,
    builder: (column) => column,
  );

  GeneratedColumn<String> get frontText =>
      $composableBuilder(column: $table.frontText, builder: (column) => column);

  GeneratedColumn<String> get backText =>
      $composableBuilder(column: $table.backText, builder: (column) => column);

  GeneratedColumn<int> get streak =>
      $composableBuilder(column: $table.streak, builder: (column) => column);

  GeneratedColumn<int> get totalCorrect => $composableBuilder(
    column: $table.totalCorrect,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalIncorrect => $composableBuilder(
    column: $table.totalIncorrect,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalShown => $composableBuilder(
    column: $table.totalShown,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastAnsweredAt => $composableBuilder(
    column: $table.lastAnsweredAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastShownAt => $composableBuilder(
    column: $table.lastShownAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get syncState =>
      $composableBuilder(column: $table.syncState, builder: (column) => column);
}

class $QuestionStatsTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          QuestionStats,
          QuestionStatsDatabaseDto,
          $QuestionStatsFilterComposer,
          $QuestionStatsOrderingComposer,
          $QuestionStatsAnnotationComposer,
          $QuestionStatsCreateCompanionBuilder,
          $QuestionStatsUpdateCompanionBuilder,
          (
            QuestionStatsDatabaseDto,
            BaseReferences<
              _$AppDatabase,
              QuestionStats,
              QuestionStatsDatabaseDto
            >,
          ),
          QuestionStatsDatabaseDto,
          PrefetchHooks Function()
        > {
  $QuestionStatsTableManager(_$AppDatabase db, QuestionStats table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $QuestionStatsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $QuestionStatsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $QuestionStatsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> questionKey = const Value.absent(),
                Value<String> frontText = const Value.absent(),
                Value<String> backText = const Value.absent(),
                Value<int> streak = const Value.absent(),
                Value<int> totalCorrect = const Value.absent(),
                Value<int> totalIncorrect = const Value.absent(),
                Value<int> totalShown = const Value.absent(),
                Value<DateTime?> lastAnsweredAt = const Value.absent(),
                Value<DateTime?> lastShownAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> syncState = const Value.absent(),
              }) => QuestionStatsCompanion(
                id: id,
                questionKey: questionKey,
                frontText: frontText,
                backText: backText,
                streak: streak,
                totalCorrect: totalCorrect,
                totalIncorrect: totalIncorrect,
                totalShown: totalShown,
                lastAnsweredAt: lastAnsweredAt,
                lastShownAt: lastShownAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncState: syncState,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String questionKey,
                required String frontText,
                required String backText,
                Value<int> streak = const Value.absent(),
                Value<int> totalCorrect = const Value.absent(),
                Value<int> totalIncorrect = const Value.absent(),
                Value<int> totalShown = const Value.absent(),
                Value<DateTime?> lastAnsweredAt = const Value.absent(),
                Value<DateTime?> lastShownAt = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<String> syncState = const Value.absent(),
              }) => QuestionStatsCompanion.insert(
                id: id,
                questionKey: questionKey,
                frontText: frontText,
                backText: backText,
                streak: streak,
                totalCorrect: totalCorrect,
                totalIncorrect: totalIncorrect,
                totalShown: totalShown,
                lastAnsweredAt: lastAnsweredAt,
                lastShownAt: lastShownAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncState: syncState,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $QuestionStatsProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      QuestionStats,
      QuestionStatsDatabaseDto,
      $QuestionStatsFilterComposer,
      $QuestionStatsOrderingComposer,
      $QuestionStatsAnnotationComposer,
      $QuestionStatsCreateCompanionBuilder,
      $QuestionStatsUpdateCompanionBuilder,
      (
        QuestionStatsDatabaseDto,
        BaseReferences<_$AppDatabase, QuestionStats, QuestionStatsDatabaseDto>,
      ),
      QuestionStatsDatabaseDto,
      PrefetchHooks Function()
    >;
typedef $CardsCreateCompanionBuilder =
    CardsCompanion Function({
      required String id,
      required String testId,
      required String front,
      required String answers,
      required String questionKey,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<String?> basePayload,
      Value<String?> serverUpdatedAt,
      Value<String> syncState,
      Value<DateTime?> deletedAt,
      Value<int> rowid,
    });
typedef $CardsUpdateCompanionBuilder =
    CardsCompanion Function({
      Value<String> id,
      Value<String> testId,
      Value<String> front,
      Value<String> answers,
      Value<String> questionKey,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String?> basePayload,
      Value<String?> serverUpdatedAt,
      Value<String> syncState,
      Value<DateTime?> deletedAt,
      Value<int> rowid,
    });

final class $CardsReferences
    extends BaseReferences<_$AppDatabase, Cards, CardDatabaseDto> {
  $CardsReferences(super.$_db, super.$_table, super.$_typedResult);

  static Tests _testIdTable(_$AppDatabase db) =>
      db.tests.createAlias($_aliasNameGenerator(db.cards.testId, db.tests.id));

  $TestsProcessedTableManager get testId {
    final $_column = $_itemColumn<String>('test_id')!;

    final manager = $TestsTableManager(
      $_db,
      $_db.tests,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_testIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $CardsFilterComposer extends Composer<_$AppDatabase, Cards> {
  $CardsFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get front => $composableBuilder(
    column: $table.front,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get answers => $composableBuilder(
    column: $table.answers,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get questionKey => $composableBuilder(
    column: $table.questionKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get basePayload => $composableBuilder(
    column: $table.basePayload,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serverUpdatedAt => $composableBuilder(
    column: $table.serverUpdatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncState => $composableBuilder(
    column: $table.syncState,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  $TestsFilterComposer get testId {
    final $TestsFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.testId,
      referencedTable: $db.tests,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $TestsFilterComposer(
            $db: $db,
            $table: $db.tests,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $CardsOrderingComposer extends Composer<_$AppDatabase, Cards> {
  $CardsOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get front => $composableBuilder(
    column: $table.front,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get answers => $composableBuilder(
    column: $table.answers,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get questionKey => $composableBuilder(
    column: $table.questionKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get basePayload => $composableBuilder(
    column: $table.basePayload,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serverUpdatedAt => $composableBuilder(
    column: $table.serverUpdatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncState => $composableBuilder(
    column: $table.syncState,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $TestsOrderingComposer get testId {
    final $TestsOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.testId,
      referencedTable: $db.tests,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $TestsOrderingComposer(
            $db: $db,
            $table: $db.tests,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $CardsAnnotationComposer extends Composer<_$AppDatabase, Cards> {
  $CardsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get front =>
      $composableBuilder(column: $table.front, builder: (column) => column);

  GeneratedColumn<String> get answers =>
      $composableBuilder(column: $table.answers, builder: (column) => column);

  GeneratedColumn<String> get questionKey => $composableBuilder(
    column: $table.questionKey,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get basePayload => $composableBuilder(
    column: $table.basePayload,
    builder: (column) => column,
  );

  GeneratedColumn<String> get serverUpdatedAt => $composableBuilder(
    column: $table.serverUpdatedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get syncState =>
      $composableBuilder(column: $table.syncState, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  $TestsAnnotationComposer get testId {
    final $TestsAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.testId,
      referencedTable: $db.tests,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $TestsAnnotationComposer(
            $db: $db,
            $table: $db.tests,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $CardsTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          Cards,
          CardDatabaseDto,
          $CardsFilterComposer,
          $CardsOrderingComposer,
          $CardsAnnotationComposer,
          $CardsCreateCompanionBuilder,
          $CardsUpdateCompanionBuilder,
          (CardDatabaseDto, $CardsReferences),
          CardDatabaseDto,
          PrefetchHooks Function({bool testId})
        > {
  $CardsTableManager(_$AppDatabase db, Cards table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $CardsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $CardsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $CardsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> testId = const Value.absent(),
                Value<String> front = const Value.absent(),
                Value<String> answers = const Value.absent(),
                Value<String> questionKey = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String?> basePayload = const Value.absent(),
                Value<String?> serverUpdatedAt = const Value.absent(),
                Value<String> syncState = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CardsCompanion(
                id: id,
                testId: testId,
                front: front,
                answers: answers,
                questionKey: questionKey,
                createdAt: createdAt,
                updatedAt: updatedAt,
                basePayload: basePayload,
                serverUpdatedAt: serverUpdatedAt,
                syncState: syncState,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String testId,
                required String front,
                required String answers,
                required String questionKey,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<String?> basePayload = const Value.absent(),
                Value<String?> serverUpdatedAt = const Value.absent(),
                Value<String> syncState = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CardsCompanion.insert(
                id: id,
                testId: testId,
                front: front,
                answers: answers,
                questionKey: questionKey,
                createdAt: createdAt,
                updatedAt: updatedAt,
                basePayload: basePayload,
                serverUpdatedAt: serverUpdatedAt,
                syncState: syncState,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), $CardsReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({testId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (testId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.testId,
                                referencedTable: $CardsReferences._testIdTable(
                                  db,
                                ),
                                referencedColumn: $CardsReferences
                                    ._testIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $CardsProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      Cards,
      CardDatabaseDto,
      $CardsFilterComposer,
      $CardsOrderingComposer,
      $CardsAnnotationComposer,
      $CardsCreateCompanionBuilder,
      $CardsUpdateCompanionBuilder,
      (CardDatabaseDto, $CardsReferences),
      CardDatabaseDto,
      PrefetchHooks Function({bool testId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $TestAttemptsTableManager get testAttempts =>
      $TestAttemptsTableManager(_db, _db.testAttempts);
  $TestAttemptAnswersTableManager get testAttemptAnswers =>
      $TestAttemptAnswersTableManager(_db, _db.testAttemptAnswers);
  $SyncMetaTableManager get syncMeta =>
      $SyncMetaTableManager(_db, _db.syncMeta);
  $AnswerEventsOutboxTableManager get answerEventsOutbox =>
      $AnswerEventsOutboxTableManager(_db, _db.answerEventsOutbox);
  $ActiveSessionsTableManager get activeSessions =>
      $ActiveSessionsTableManager(_db, _db.activeSessions);
  $TestGroupsTableManager get testGroups =>
      $TestGroupsTableManager(_db, _db.testGroups);
  $TestsTableManager get tests => $TestsTableManager(_db, _db.tests);
  $TestGroupEntriesTableManager get testGroupEntries =>
      $TestGroupEntriesTableManager(_db, _db.testGroupEntries);
  $QuestionStatsTableManager get questionStats =>
      $QuestionStatsTableManager(_db, _db.questionStats);
  $CardsTableManager get cards => $CardsTableManager(_db, _db.cards);
}
