// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class TestGroups extends Table
    with TableInfo<TestGroups, TestGroupDatabaseDto> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  TestGroups(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  @override
  List<GeneratedColumn> get $columns => [id, title, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'test_groups';
  @override
  VerificationContext validateIntegrity(
      Insertable<TestGroupDatabaseDto> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TestGroupDatabaseDto map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TestGroupDatabaseDto(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
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
  final int id;
  final String title;
  final DateTime createdAt;
  final DateTime updatedAt;
  const TestGroupDatabaseDto(
      {required this.id,
      required this.title,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  TestGroupsCompanion toCompanion(bool nullToAbsent) {
    return TestGroupsCompanion(
      id: Value(id),
      title: Value(title),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory TestGroupDatabaseDto.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TestGroupDatabaseDto(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      createdAt: serializer.fromJson<DateTime>(json['created_at']),
      updatedAt: serializer.fromJson<DateTime>(json['updated_at']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'created_at': serializer.toJson<DateTime>(createdAt),
      'updated_at': serializer.toJson<DateTime>(updatedAt),
    };
  }

  TestGroupDatabaseDto copyWith(
          {int? id, String? title, DateTime? createdAt, DateTime? updatedAt}) =>
      TestGroupDatabaseDto(
        id: id ?? this.id,
        title: title ?? this.title,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  TestGroupDatabaseDto copyWithCompanion(TestGroupsCompanion data) {
    return TestGroupDatabaseDto(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TestGroupDatabaseDto(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TestGroupDatabaseDto &&
          other.id == this.id &&
          other.title == this.title &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class TestGroupsCompanion extends UpdateCompanion<TestGroupDatabaseDto> {
  final Value<int> id;
  final Value<String> title;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const TestGroupsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  TestGroupsCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required DateTime createdAt,
    required DateTime updatedAt,
  })  : title = Value(title),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<TestGroupDatabaseDto> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  TestGroupsCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return TestGroupsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
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
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TestGroupsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
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
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, description, type, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tests';
  @override
  VerificationContext validateIntegrity(Insertable<TestDatabaseDto> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TestDatabaseDto map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TestDatabaseDto(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
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
  final int id;
  final String title;
  final String? description;
  final String type;
  final DateTime createdAt;
  final DateTime updatedAt;
  const TestDatabaseDto(
      {required this.id,
      required this.title,
      this.description,
      required this.type,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['type'] = Variable<String>(type);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
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
    );
  }

  factory TestDatabaseDto.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TestDatabaseDto(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      type: serializer.fromJson<String>(json['type']),
      createdAt: serializer.fromJson<DateTime>(json['created_at']),
      updatedAt: serializer.fromJson<DateTime>(json['updated_at']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'type': serializer.toJson<String>(type),
      'created_at': serializer.toJson<DateTime>(createdAt),
      'updated_at': serializer.toJson<DateTime>(updatedAt),
    };
  }

  TestDatabaseDto copyWith(
          {int? id,
          String? title,
          Value<String?> description = const Value.absent(),
          String? type,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      TestDatabaseDto(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description.present ? description.value : this.description,
        type: type ?? this.type,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  TestDatabaseDto copyWithCompanion(TestsCompanion data) {
    return TestDatabaseDto(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description:
          data.description.present ? data.description.value : this.description,
      type: data.type.present ? data.type.value : this.type,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
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
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, description, type, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TestDatabaseDto &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.type == this.type &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class TestsCompanion extends UpdateCompanion<TestDatabaseDto> {
  final Value<int> id;
  final Value<String> title;
  final Value<String?> description;
  final Value<String> type;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const TestsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.type = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  TestsCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.description = const Value.absent(),
    required String type,
    required DateTime createdAt,
    required DateTime updatedAt,
  })  : title = Value(title),
        type = Value(type),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<TestDatabaseDto> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? type,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (type != null) 'type': type,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  TestsCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String?>? description,
      Value<String>? type,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return TestsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
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
          ..write('updatedAt: $updatedAt')
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
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  static const VerificationMeta _groupIdMeta =
      const VerificationMeta('groupId');
  late final GeneratedColumn<int> groupId = GeneratedColumn<int>(
      'group_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints:
          'NOT NULL REFERENCES test_groups(id)ON DELETE CASCADE');
  static const VerificationMeta _testIdMeta = const VerificationMeta('testId');
  late final GeneratedColumn<int> testId = GeneratedColumn<int>(
      'test_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL REFERENCES tests(id)ON DELETE CASCADE');
  @override
  List<GeneratedColumn> get $columns => [id, groupId, testId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'test_group_entries';
  @override
  VerificationContext validateIntegrity(
      Insertable<TestGroupEntryDatabaseDto> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('group_id')) {
      context.handle(_groupIdMeta,
          groupId.isAcceptableOrUnknown(data['group_id']!, _groupIdMeta));
    } else if (isInserting) {
      context.missing(_groupIdMeta);
    }
    if (data.containsKey('test_id')) {
      context.handle(_testIdMeta,
          testId.isAcceptableOrUnknown(data['test_id']!, _testIdMeta));
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
  TestGroupEntryDatabaseDto map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TestGroupEntryDatabaseDto(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      groupId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}group_id'])!,
      testId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}test_id'])!,
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
  final int id;
  final int groupId;
  final int testId;
  const TestGroupEntryDatabaseDto(
      {required this.id, required this.groupId, required this.testId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['group_id'] = Variable<int>(groupId);
    map['test_id'] = Variable<int>(testId);
    return map;
  }

  TestGroupEntriesCompanion toCompanion(bool nullToAbsent) {
    return TestGroupEntriesCompanion(
      id: Value(id),
      groupId: Value(groupId),
      testId: Value(testId),
    );
  }

  factory TestGroupEntryDatabaseDto.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TestGroupEntryDatabaseDto(
      id: serializer.fromJson<int>(json['id']),
      groupId: serializer.fromJson<int>(json['group_id']),
      testId: serializer.fromJson<int>(json['test_id']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'group_id': serializer.toJson<int>(groupId),
      'test_id': serializer.toJson<int>(testId),
    };
  }

  TestGroupEntryDatabaseDto copyWith({int? id, int? groupId, int? testId}) =>
      TestGroupEntryDatabaseDto(
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
  final Value<int> id;
  final Value<int> groupId;
  final Value<int> testId;
  const TestGroupEntriesCompanion({
    this.id = const Value.absent(),
    this.groupId = const Value.absent(),
    this.testId = const Value.absent(),
  });
  TestGroupEntriesCompanion.insert({
    this.id = const Value.absent(),
    required int groupId,
    required int testId,
  })  : groupId = Value(groupId),
        testId = Value(testId);
  static Insertable<TestGroupEntryDatabaseDto> custom({
    Expression<int>? id,
    Expression<int>? groupId,
    Expression<int>? testId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (groupId != null) 'group_id': groupId,
      if (testId != null) 'test_id': testId,
    });
  }

  TestGroupEntriesCompanion copyWith(
      {Value<int>? id, Value<int>? groupId, Value<int>? testId}) {
    return TestGroupEntriesCompanion(
      id: id ?? this.id,
      groupId: groupId ?? this.groupId,
      testId: testId ?? this.testId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (groupId.present) {
      map['group_id'] = Variable<int>(groupId.value);
    }
    if (testId.present) {
      map['test_id'] = Variable<int>(testId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TestGroupEntriesCompanion(')
          ..write('id: $id, ')
          ..write('groupId: $groupId, ')
          ..write('testId: $testId')
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
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  static const VerificationMeta _questionKeyMeta =
      const VerificationMeta('questionKey');
  late final GeneratedColumn<String> questionKey = GeneratedColumn<String>(
      'question_key', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL UNIQUE');
  static const VerificationMeta _frontTextMeta =
      const VerificationMeta('frontText');
  late final GeneratedColumn<String> frontText = GeneratedColumn<String>(
      'front_text', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _backTextMeta =
      const VerificationMeta('backText');
  late final GeneratedColumn<String> backText = GeneratedColumn<String>(
      'back_text', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _streakMeta = const VerificationMeta('streak');
  late final GeneratedColumn<int> streak = GeneratedColumn<int>(
      'streak', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL DEFAULT 0',
      defaultValue: const CustomExpression('0'));
  static const VerificationMeta _totalCorrectMeta =
      const VerificationMeta('totalCorrect');
  late final GeneratedColumn<int> totalCorrect = GeneratedColumn<int>(
      'total_correct', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL DEFAULT 0',
      defaultValue: const CustomExpression('0'));
  static const VerificationMeta _totalIncorrectMeta =
      const VerificationMeta('totalIncorrect');
  late final GeneratedColumn<int> totalIncorrect = GeneratedColumn<int>(
      'total_incorrect', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL DEFAULT 0',
      defaultValue: const CustomExpression('0'));
  static const VerificationMeta _totalShownMeta =
      const VerificationMeta('totalShown');
  late final GeneratedColumn<int> totalShown = GeneratedColumn<int>(
      'total_shown', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL DEFAULT 0',
      defaultValue: const CustomExpression('0'));
  static const VerificationMeta _lastAnsweredAtMeta =
      const VerificationMeta('lastAnsweredAt');
  late final GeneratedColumn<DateTime> lastAnsweredAt =
      GeneratedColumn<DateTime>('last_answered_at', aliasedName, true,
          type: DriftSqlType.dateTime,
          requiredDuringInsert: false,
          $customConstraints: '');
  static const VerificationMeta _lastShownAtMeta =
      const VerificationMeta('lastShownAt');
  late final GeneratedColumn<DateTime> lastShownAt = GeneratedColumn<DateTime>(
      'last_shown_at', aliasedName, true,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
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
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'question_stats';
  @override
  VerificationContext validateIntegrity(
      Insertable<QuestionStatsDatabaseDto> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('question_key')) {
      context.handle(
          _questionKeyMeta,
          questionKey.isAcceptableOrUnknown(
              data['question_key']!, _questionKeyMeta));
    } else if (isInserting) {
      context.missing(_questionKeyMeta);
    }
    if (data.containsKey('front_text')) {
      context.handle(_frontTextMeta,
          frontText.isAcceptableOrUnknown(data['front_text']!, _frontTextMeta));
    } else if (isInserting) {
      context.missing(_frontTextMeta);
    }
    if (data.containsKey('back_text')) {
      context.handle(_backTextMeta,
          backText.isAcceptableOrUnknown(data['back_text']!, _backTextMeta));
    } else if (isInserting) {
      context.missing(_backTextMeta);
    }
    if (data.containsKey('streak')) {
      context.handle(_streakMeta,
          streak.isAcceptableOrUnknown(data['streak']!, _streakMeta));
    }
    if (data.containsKey('total_correct')) {
      context.handle(
          _totalCorrectMeta,
          totalCorrect.isAcceptableOrUnknown(
              data['total_correct']!, _totalCorrectMeta));
    }
    if (data.containsKey('total_incorrect')) {
      context.handle(
          _totalIncorrectMeta,
          totalIncorrect.isAcceptableOrUnknown(
              data['total_incorrect']!, _totalIncorrectMeta));
    }
    if (data.containsKey('total_shown')) {
      context.handle(
          _totalShownMeta,
          totalShown.isAcceptableOrUnknown(
              data['total_shown']!, _totalShownMeta));
    }
    if (data.containsKey('last_answered_at')) {
      context.handle(
          _lastAnsweredAtMeta,
          lastAnsweredAt.isAcceptableOrUnknown(
              data['last_answered_at']!, _lastAnsweredAtMeta));
    }
    if (data.containsKey('last_shown_at')) {
      context.handle(
          _lastShownAtMeta,
          lastShownAt.isAcceptableOrUnknown(
              data['last_shown_at']!, _lastShownAtMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  QuestionStatsDatabaseDto map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return QuestionStatsDatabaseDto(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      questionKey: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}question_key'])!,
      frontText: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}front_text'])!,
      backText: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}back_text'])!,
      streak: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}streak'])!,
      totalCorrect: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total_correct'])!,
      totalIncorrect: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total_incorrect'])!,
      totalShown: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total_shown'])!,
      lastAnsweredAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_answered_at']),
      lastShownAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_shown_at']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
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
  const QuestionStatsDatabaseDto(
      {required this.id,
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
      required this.updatedAt});
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
    );
  }

  factory QuestionStatsDatabaseDto.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
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
    };
  }

  QuestionStatsDatabaseDto copyWith(
          {int? id,
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
          DateTime? updatedAt}) =>
      QuestionStatsDatabaseDto(
        id: id ?? this.id,
        questionKey: questionKey ?? this.questionKey,
        frontText: frontText ?? this.frontText,
        backText: backText ?? this.backText,
        streak: streak ?? this.streak,
        totalCorrect: totalCorrect ?? this.totalCorrect,
        totalIncorrect: totalIncorrect ?? this.totalIncorrect,
        totalShown: totalShown ?? this.totalShown,
        lastAnsweredAt:
            lastAnsweredAt.present ? lastAnsweredAt.value : this.lastAnsweredAt,
        lastShownAt: lastShownAt.present ? lastShownAt.value : this.lastShownAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  QuestionStatsDatabaseDto copyWithCompanion(QuestionStatsCompanion data) {
    return QuestionStatsDatabaseDto(
      id: data.id.present ? data.id.value : this.id,
      questionKey:
          data.questionKey.present ? data.questionKey.value : this.questionKey,
      frontText: data.frontText.present ? data.frontText.value : this.frontText,
      backText: data.backText.present ? data.backText.value : this.backText,
      streak: data.streak.present ? data.streak.value : this.streak,
      totalCorrect: data.totalCorrect.present
          ? data.totalCorrect.value
          : this.totalCorrect,
      totalIncorrect: data.totalIncorrect.present
          ? data.totalIncorrect.value
          : this.totalIncorrect,
      totalShown:
          data.totalShown.present ? data.totalShown.value : this.totalShown,
      lastAnsweredAt: data.lastAnsweredAt.present
          ? data.lastAnsweredAt.value
          : this.lastAnsweredAt,
      lastShownAt:
          data.lastShownAt.present ? data.lastShownAt.value : this.lastShownAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
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
          ..write('updatedAt: $updatedAt')
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
      updatedAt);
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
          other.updatedAt == this.updatedAt);
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
  })  : questionKey = Value(questionKey),
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
    });
  }

  QuestionStatsCompanion copyWith(
      {Value<int>? id,
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
      Value<DateTime>? updatedAt}) {
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
          ..write('updatedAt: $updatedAt')
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
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  static const VerificationMeta _testIdMeta = const VerificationMeta('testId');
  late final GeneratedColumn<int> testId = GeneratedColumn<int>(
      'test_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL REFERENCES tests(id)ON DELETE CASCADE');
  static const VerificationMeta _questionMeta =
      const VerificationMeta('question');
  late final GeneratedColumn<String> question = GeneratedColumn<String>(
      'question', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _answerMeta = const VerificationMeta('answer');
  late final GeneratedColumn<String> answer = GeneratedColumn<String>(
      'answer', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  @override
  List<GeneratedColumn> get $columns =>
      [id, testId, question, answer, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cards';
  @override
  VerificationContext validateIntegrity(Insertable<CardDatabaseDto> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('test_id')) {
      context.handle(_testIdMeta,
          testId.isAcceptableOrUnknown(data['test_id']!, _testIdMeta));
    } else if (isInserting) {
      context.missing(_testIdMeta);
    }
    if (data.containsKey('question')) {
      context.handle(_questionMeta,
          question.isAcceptableOrUnknown(data['question']!, _questionMeta));
    } else if (isInserting) {
      context.missing(_questionMeta);
    }
    if (data.containsKey('answer')) {
      context.handle(_answerMeta,
          answer.isAcceptableOrUnknown(data['answer']!, _answerMeta));
    } else if (isInserting) {
      context.missing(_answerMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CardDatabaseDto map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CardDatabaseDto(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      testId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}test_id'])!,
      question: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}question'])!,
      answer: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}answer'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
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
  final int id;
  final int testId;
  final String question;
  final String answer;
  final DateTime createdAt;
  final DateTime updatedAt;
  const CardDatabaseDto(
      {required this.id,
      required this.testId,
      required this.question,
      required this.answer,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['test_id'] = Variable<int>(testId);
    map['question'] = Variable<String>(question);
    map['answer'] = Variable<String>(answer);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CardsCompanion toCompanion(bool nullToAbsent) {
    return CardsCompanion(
      id: Value(id),
      testId: Value(testId),
      question: Value(question),
      answer: Value(answer),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory CardDatabaseDto.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CardDatabaseDto(
      id: serializer.fromJson<int>(json['id']),
      testId: serializer.fromJson<int>(json['test_id']),
      question: serializer.fromJson<String>(json['question']),
      answer: serializer.fromJson<String>(json['answer']),
      createdAt: serializer.fromJson<DateTime>(json['created_at']),
      updatedAt: serializer.fromJson<DateTime>(json['updated_at']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'test_id': serializer.toJson<int>(testId),
      'question': serializer.toJson<String>(question),
      'answer': serializer.toJson<String>(answer),
      'created_at': serializer.toJson<DateTime>(createdAt),
      'updated_at': serializer.toJson<DateTime>(updatedAt),
    };
  }

  CardDatabaseDto copyWith(
          {int? id,
          int? testId,
          String? question,
          String? answer,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      CardDatabaseDto(
        id: id ?? this.id,
        testId: testId ?? this.testId,
        question: question ?? this.question,
        answer: answer ?? this.answer,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  CardDatabaseDto copyWithCompanion(CardsCompanion data) {
    return CardDatabaseDto(
      id: data.id.present ? data.id.value : this.id,
      testId: data.testId.present ? data.testId.value : this.testId,
      question: data.question.present ? data.question.value : this.question,
      answer: data.answer.present ? data.answer.value : this.answer,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CardDatabaseDto(')
          ..write('id: $id, ')
          ..write('testId: $testId, ')
          ..write('question: $question, ')
          ..write('answer: $answer, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, testId, question, answer, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CardDatabaseDto &&
          other.id == this.id &&
          other.testId == this.testId &&
          other.question == this.question &&
          other.answer == this.answer &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CardsCompanion extends UpdateCompanion<CardDatabaseDto> {
  final Value<int> id;
  final Value<int> testId;
  final Value<String> question;
  final Value<String> answer;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const CardsCompanion({
    this.id = const Value.absent(),
    this.testId = const Value.absent(),
    this.question = const Value.absent(),
    this.answer = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  CardsCompanion.insert({
    this.id = const Value.absent(),
    required int testId,
    required String question,
    required String answer,
    required DateTime createdAt,
    required DateTime updatedAt,
  })  : testId = Value(testId),
        question = Value(question),
        answer = Value(answer),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<CardDatabaseDto> custom({
    Expression<int>? id,
    Expression<int>? testId,
    Expression<String>? question,
    Expression<String>? answer,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (testId != null) 'test_id': testId,
      if (question != null) 'question': question,
      if (answer != null) 'answer': answer,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  CardsCompanion copyWith(
      {Value<int>? id,
      Value<int>? testId,
      Value<String>? question,
      Value<String>? answer,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return CardsCompanion(
      id: id ?? this.id,
      testId: testId ?? this.testId,
      question: question ?? this.question,
      answer: answer ?? this.answer,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (testId.present) {
      map['test_id'] = Variable<int>(testId.value);
    }
    if (question.present) {
      map['question'] = Variable<String>(question.value);
    }
    if (answer.present) {
      map['answer'] = Variable<String>(answer.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CardsCompanion(')
          ..write('id: $id, ')
          ..write('testId: $testId, ')
          ..write('question: $question, ')
          ..write('answer: $answer, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final TestGroups testGroups = TestGroups(this);
  late final Tests tests = Tests(this);
  late final TestGroupEntries testGroupEntries = TestGroupEntries(this);
  late final QuestionStats questionStats = QuestionStats(this);
  late final Cards cards = Cards(this);
  late final TestsDatabase testsDatabase = TestsDatabase(this as AppDatabase);
  late final CardsDatabase cardsDatabase = CardsDatabase(this as AppDatabase);
  late final QuestionStatsDatabase questionStatsDatabase =
      QuestionStatsDatabase(this as AppDatabase);
  late final GroupsDatabase groupsDatabase =
      GroupsDatabase(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [testGroups, tests, testGroupEntries, questionStats, cards];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('test_groups',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('test_group_entries', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('tests',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('test_group_entries', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('tests',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('cards', kind: UpdateKind.delete),
            ],
          ),
        ],
      );
}

typedef $TestGroupsCreateCompanionBuilder = TestGroupsCompanion Function({
  Value<int> id,
  required String title,
  required DateTime createdAt,
  required DateTime updatedAt,
});
typedef $TestGroupsUpdateCompanionBuilder = TestGroupsCompanion Function({
  Value<int> id,
  Value<String> title,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $TestGroupsReferences
    extends BaseReferences<_$AppDatabase, TestGroups, TestGroupDatabaseDto> {
  $TestGroupsReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<TestGroupEntries, List<TestGroupEntryDatabaseDto>>
      _testGroupEntriesRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.testGroupEntries,
              aliasName: $_aliasNameGenerator(
                  db.testGroups.id, db.testGroupEntries.groupId));

  $TestGroupEntriesProcessedTableManager get testGroupEntriesRefs {
    final manager = $TestGroupEntriesTableManager($_db, $_db.testGroupEntries)
        .filter((f) => f.groupId.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_testGroupEntriesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
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
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  Expression<bool> testGroupEntriesRefs(
      Expression<bool> Function($TestGroupEntriesFilterComposer f) f) {
    final $TestGroupEntriesFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.testGroupEntries,
        getReferencedColumn: (t) => t.groupId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $TestGroupEntriesFilterComposer(
              $db: $db,
              $table: $db.testGroupEntries,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
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
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
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
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> testGroupEntriesRefs<T extends Object>(
      Expression<T> Function($TestGroupEntriesAnnotationComposer a) f) {
    final $TestGroupEntriesAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.testGroupEntries,
        getReferencedColumn: (t) => t.groupId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $TestGroupEntriesAnnotationComposer(
              $db: $db,
              $table: $db.testGroupEntries,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $TestGroupsTableManager extends RootTableManager<
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
    PrefetchHooks Function({bool testGroupEntriesRefs})> {
  $TestGroupsTableManager(_$AppDatabase db, TestGroups table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $TestGroupsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $TestGroupsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $TestGroupsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              TestGroupsCompanion(
            id: id,
            title: title,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String title,
            required DateTime createdAt,
            required DateTime updatedAt,
          }) =>
              TestGroupsCompanion.insert(
            id: id,
            title: title,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $TestGroupsReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({testGroupEntriesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (testGroupEntriesRefs) db.testGroupEntries
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (testGroupEntriesRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $TestGroupsReferences
                            ._testGroupEntriesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $TestGroupsReferences(db, table, p0)
                                .testGroupEntriesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.groupId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $TestGroupsProcessedTableManager = ProcessedTableManager<
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
    PrefetchHooks Function({bool testGroupEntriesRefs})>;
typedef $TestsCreateCompanionBuilder = TestsCompanion Function({
  Value<int> id,
  required String title,
  Value<String?> description,
  required String type,
  required DateTime createdAt,
  required DateTime updatedAt,
});
typedef $TestsUpdateCompanionBuilder = TestsCompanion Function({
  Value<int> id,
  Value<String> title,
  Value<String?> description,
  Value<String> type,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $TestsReferences
    extends BaseReferences<_$AppDatabase, Tests, TestDatabaseDto> {
  $TestsReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<TestGroupEntries, List<TestGroupEntryDatabaseDto>>
      _testGroupEntriesRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.testGroupEntries,
              aliasName: $_aliasNameGenerator(
                  db.tests.id, db.testGroupEntries.testId));

  $TestGroupEntriesProcessedTableManager get testGroupEntriesRefs {
    final manager = $TestGroupEntriesTableManager($_db, $_db.testGroupEntries)
        .filter((f) => f.testId.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_testGroupEntriesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<Cards, List<CardDatabaseDto>> _cardsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.cards,
          aliasName: $_aliasNameGenerator(db.tests.id, db.cards.testId));

  $CardsProcessedTableManager get cardsRefs {
    final manager = $CardsTableManager($_db, $_db.cards)
        .filter((f) => f.testId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_cardsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
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
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  Expression<bool> testGroupEntriesRefs(
      Expression<bool> Function($TestGroupEntriesFilterComposer f) f) {
    final $TestGroupEntriesFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.testGroupEntries,
        getReferencedColumn: (t) => t.testId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $TestGroupEntriesFilterComposer(
              $db: $db,
              $table: $db.testGroupEntries,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> cardsRefs(
      Expression<bool> Function($CardsFilterComposer f) f) {
    final $CardsFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.cards,
        getReferencedColumn: (t) => t.testId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $CardsFilterComposer(
              $db: $db,
              $table: $db.cards,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
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
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $TestsAnnotationComposer extends Composer<_$AppDatabase, Tests> {
  $TestsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> testGroupEntriesRefs<T extends Object>(
      Expression<T> Function($TestGroupEntriesAnnotationComposer a) f) {
    final $TestGroupEntriesAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.testGroupEntries,
        getReferencedColumn: (t) => t.testId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $TestGroupEntriesAnnotationComposer(
              $db: $db,
              $table: $db.testGroupEntries,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> cardsRefs<T extends Object>(
      Expression<T> Function($CardsAnnotationComposer a) f) {
    final $CardsAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.cards,
        getReferencedColumn: (t) => t.testId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $CardsAnnotationComposer(
              $db: $db,
              $table: $db.cards,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $TestsTableManager extends RootTableManager<
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
    PrefetchHooks Function({bool testGroupEntriesRefs, bool cardsRefs})> {
  $TestsTableManager(_$AppDatabase db, Tests table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $TestsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $TestsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $TestsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              TestsCompanion(
            id: id,
            title: title,
            description: description,
            type: type,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String title,
            Value<String?> description = const Value.absent(),
            required String type,
            required DateTime createdAt,
            required DateTime updatedAt,
          }) =>
              TestsCompanion.insert(
            id: id,
            title: title,
            description: description,
            type: type,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), $TestsReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {testGroupEntriesRefs = false, cardsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (testGroupEntriesRefs) db.testGroupEntries,
                if (cardsRefs) db.cards
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (testGroupEntriesRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $TestsReferences._testGroupEntriesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $TestsReferences(db, table, p0)
                                .testGroupEntriesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.testId == item.id),
                        typedResults: items),
                  if (cardsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $TestsReferences._cardsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $TestsReferences(db, table, p0).cardsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.testId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $TestsProcessedTableManager = ProcessedTableManager<
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
    PrefetchHooks Function({bool testGroupEntriesRefs, bool cardsRefs})>;
typedef $TestGroupEntriesCreateCompanionBuilder = TestGroupEntriesCompanion
    Function({
  Value<int> id,
  required int groupId,
  required int testId,
});
typedef $TestGroupEntriesUpdateCompanionBuilder = TestGroupEntriesCompanion
    Function({
  Value<int> id,
  Value<int> groupId,
  Value<int> testId,
});

final class $TestGroupEntriesReferences extends BaseReferences<_$AppDatabase,
    TestGroupEntries, TestGroupEntryDatabaseDto> {
  $TestGroupEntriesReferences(super.$_db, super.$_table, super.$_typedResult);

  static TestGroups _groupIdTable(_$AppDatabase db) =>
      db.testGroups.createAlias(
          $_aliasNameGenerator(db.testGroupEntries.groupId, db.testGroups.id));

  $TestGroupsProcessedTableManager get groupId {
    final manager = $TestGroupsTableManager($_db, $_db.testGroups)
        .filter((f) => f.id($_item.groupId!));
    final item = $_typedResult.readTableOrNull(_groupIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static Tests _testIdTable(_$AppDatabase db) => db.tests.createAlias(
      $_aliasNameGenerator(db.testGroupEntries.testId, db.tests.id));

  $TestsProcessedTableManager get testId {
    final manager = $TestsTableManager($_db, $_db.tests)
        .filter((f) => f.id($_item.testId!));
    final item = $_typedResult.readTableOrNull(_testIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
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
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  $TestGroupsFilterComposer get groupId {
    final $TestGroupsFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.groupId,
        referencedTable: $db.testGroups,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $TestGroupsFilterComposer(
              $db: $db,
              $table: $db.testGroups,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $TestsFilterComposer get testId {
    final $TestsFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.testId,
        referencedTable: $db.tests,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $TestsFilterComposer(
              $db: $db,
              $table: $db.tests,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
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
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  $TestGroupsOrderingComposer get groupId {
    final $TestGroupsOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.groupId,
        referencedTable: $db.testGroups,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $TestGroupsOrderingComposer(
              $db: $db,
              $table: $db.testGroups,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $TestsOrderingComposer get testId {
    final $TestsOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.testId,
        referencedTable: $db.tests,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $TestsOrderingComposer(
              $db: $db,
              $table: $db.tests,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
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
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  $TestGroupsAnnotationComposer get groupId {
    final $TestGroupsAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.groupId,
        referencedTable: $db.testGroups,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $TestGroupsAnnotationComposer(
              $db: $db,
              $table: $db.testGroups,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $TestsAnnotationComposer get testId {
    final $TestsAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.testId,
        referencedTable: $db.tests,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $TestsAnnotationComposer(
              $db: $db,
              $table: $db.tests,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $TestGroupEntriesTableManager extends RootTableManager<
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
    PrefetchHooks Function({bool groupId, bool testId})> {
  $TestGroupEntriesTableManager(_$AppDatabase db, TestGroupEntries table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $TestGroupEntriesFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $TestGroupEntriesOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $TestGroupEntriesAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> groupId = const Value.absent(),
            Value<int> testId = const Value.absent(),
          }) =>
              TestGroupEntriesCompanion(
            id: id,
            groupId: groupId,
            testId: testId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int groupId,
            required int testId,
          }) =>
              TestGroupEntriesCompanion.insert(
            id: id,
            groupId: groupId,
            testId: testId,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $TestGroupEntriesReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({groupId = false, testId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                      dynamic>>(state) {
                if (groupId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.groupId,
                    referencedTable:
                        $TestGroupEntriesReferences._groupIdTable(db),
                    referencedColumn:
                        $TestGroupEntriesReferences._groupIdTable(db).id,
                  ) as T;
                }
                if (testId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.testId,
                    referencedTable:
                        $TestGroupEntriesReferences._testIdTable(db),
                    referencedColumn:
                        $TestGroupEntriesReferences._testIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $TestGroupEntriesProcessedTableManager = ProcessedTableManager<
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
    PrefetchHooks Function({bool groupId, bool testId})>;
typedef $QuestionStatsCreateCompanionBuilder = QuestionStatsCompanion Function({
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
});
typedef $QuestionStatsUpdateCompanionBuilder = QuestionStatsCompanion Function({
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
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get questionKey => $composableBuilder(
      column: $table.questionKey, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get frontText => $composableBuilder(
      column: $table.frontText, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get backText => $composableBuilder(
      column: $table.backText, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get streak => $composableBuilder(
      column: $table.streak, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get totalCorrect => $composableBuilder(
      column: $table.totalCorrect, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get totalIncorrect => $composableBuilder(
      column: $table.totalIncorrect,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get totalShown => $composableBuilder(
      column: $table.totalShown, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastAnsweredAt => $composableBuilder(
      column: $table.lastAnsweredAt,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastShownAt => $composableBuilder(
      column: $table.lastShownAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
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
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get questionKey => $composableBuilder(
      column: $table.questionKey, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get frontText => $composableBuilder(
      column: $table.frontText, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get backText => $composableBuilder(
      column: $table.backText, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get streak => $composableBuilder(
      column: $table.streak, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get totalCorrect => $composableBuilder(
      column: $table.totalCorrect,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get totalIncorrect => $composableBuilder(
      column: $table.totalIncorrect,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get totalShown => $composableBuilder(
      column: $table.totalShown, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastAnsweredAt => $composableBuilder(
      column: $table.lastAnsweredAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastShownAt => $composableBuilder(
      column: $table.lastShownAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
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
      column: $table.questionKey, builder: (column) => column);

  GeneratedColumn<String> get frontText =>
      $composableBuilder(column: $table.frontText, builder: (column) => column);

  GeneratedColumn<String> get backText =>
      $composableBuilder(column: $table.backText, builder: (column) => column);

  GeneratedColumn<int> get streak =>
      $composableBuilder(column: $table.streak, builder: (column) => column);

  GeneratedColumn<int> get totalCorrect => $composableBuilder(
      column: $table.totalCorrect, builder: (column) => column);

  GeneratedColumn<int> get totalIncorrect => $composableBuilder(
      column: $table.totalIncorrect, builder: (column) => column);

  GeneratedColumn<int> get totalShown => $composableBuilder(
      column: $table.totalShown, builder: (column) => column);

  GeneratedColumn<DateTime> get lastAnsweredAt => $composableBuilder(
      column: $table.lastAnsweredAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastShownAt => $composableBuilder(
      column: $table.lastShownAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $QuestionStatsTableManager extends RootTableManager<
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
      BaseReferences<_$AppDatabase, QuestionStats, QuestionStatsDatabaseDto>
    ),
    QuestionStatsDatabaseDto,
    PrefetchHooks Function()> {
  $QuestionStatsTableManager(_$AppDatabase db, QuestionStats table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $QuestionStatsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $QuestionStatsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $QuestionStatsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
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
          }) =>
              QuestionStatsCompanion(
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
          ),
          createCompanionCallback: ({
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
          }) =>
              QuestionStatsCompanion.insert(
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
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $QuestionStatsProcessedTableManager = ProcessedTableManager<
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
      BaseReferences<_$AppDatabase, QuestionStats, QuestionStatsDatabaseDto>
    ),
    QuestionStatsDatabaseDto,
    PrefetchHooks Function()>;
typedef $CardsCreateCompanionBuilder = CardsCompanion Function({
  Value<int> id,
  required int testId,
  required String question,
  required String answer,
  required DateTime createdAt,
  required DateTime updatedAt,
});
typedef $CardsUpdateCompanionBuilder = CardsCompanion Function({
  Value<int> id,
  Value<int> testId,
  Value<String> question,
  Value<String> answer,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $CardsReferences
    extends BaseReferences<_$AppDatabase, Cards, CardDatabaseDto> {
  $CardsReferences(super.$_db, super.$_table, super.$_typedResult);

  static Tests _testIdTable(_$AppDatabase db) =>
      db.tests.createAlias($_aliasNameGenerator(db.cards.testId, db.tests.id));

  $TestsProcessedTableManager get testId {
    final manager = $TestsTableManager($_db, $_db.tests)
        .filter((f) => f.id($_item.testId!));
    final item = $_typedResult.readTableOrNull(_testIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
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
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get question => $composableBuilder(
      column: $table.question, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get answer => $composableBuilder(
      column: $table.answer, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $TestsFilterComposer get testId {
    final $TestsFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.testId,
        referencedTable: $db.tests,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $TestsFilterComposer(
              $db: $db,
              $table: $db.tests,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
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
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get question => $composableBuilder(
      column: $table.question, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get answer => $composableBuilder(
      column: $table.answer, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $TestsOrderingComposer get testId {
    final $TestsOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.testId,
        referencedTable: $db.tests,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $TestsOrderingComposer(
              $db: $db,
              $table: $db.tests,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
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
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get question =>
      $composableBuilder(column: $table.question, builder: (column) => column);

  GeneratedColumn<String> get answer =>
      $composableBuilder(column: $table.answer, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $TestsAnnotationComposer get testId {
    final $TestsAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.testId,
        referencedTable: $db.tests,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $TestsAnnotationComposer(
              $db: $db,
              $table: $db.tests,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $CardsTableManager extends RootTableManager<
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
    PrefetchHooks Function({bool testId})> {
  $CardsTableManager(_$AppDatabase db, Cards table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $CardsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $CardsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $CardsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> testId = const Value.absent(),
            Value<String> question = const Value.absent(),
            Value<String> answer = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              CardsCompanion(
            id: id,
            testId: testId,
            question: question,
            answer: answer,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int testId,
            required String question,
            required String answer,
            required DateTime createdAt,
            required DateTime updatedAt,
          }) =>
              CardsCompanion.insert(
            id: id,
            testId: testId,
            question: question,
            answer: answer,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), $CardsReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({testId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                      dynamic>>(state) {
                if (testId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.testId,
                    referencedTable: $CardsReferences._testIdTable(db),
                    referencedColumn: $CardsReferences._testIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $CardsProcessedTableManager = ProcessedTableManager<
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
    PrefetchHooks Function({bool testId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $TestGroupsTableManager get testGroups =>
      $TestGroupsTableManager(_db, _db.testGroups);
  $TestsTableManager get tests => $TestsTableManager(_db, _db.tests);
  $TestGroupEntriesTableManager get testGroupEntries =>
      $TestGroupEntriesTableManager(_db, _db.testGroupEntries);
  $QuestionStatsTableManager get questionStats =>
      $QuestionStatsTableManager(_db, _db.questionStats);
  $CardsTableManager get cards => $CardsTableManager(_db, _db.cards);
}
