---
name: create-storage
description: Create local data storage (key-value/secure storage) or database DAO (Drift/SQLite) implementations with interfaces, DTOs, and DI wiring. Use when adding persistent local storage or database DAOs for a feature.
---

# Create Local Storage

Create domain-specific storages or DAOs in the `modules/datasource/persistence/` module following project conventions.

## Choose Your Path

| Need | Path | Rule |
|------|------|------|
| Simple flags, single values, small config | **Key-Value / Secure Storage** (below) | [persistence-storage](mdc:.cursor/rules/persistence-storage.mdc) |
| Structured relational data, complex queries, bulk operations | **Database DAO** (bottom of this file) | [database-dao](mdc:.cursor/rules/database-dao.mdc) |

## Module Location

All storage and DAO code lives in `modules/datasource/persistence/lib/storage/`.

## Directory Layout

```
modules/datasource/persistence/lib/storage/example_storage/
├── data/
│   ├── example_dto.dart
│   └── example_dto.g.dart
├── i_example_storage.dart
└── example_storage.dart
```

For simple storages that only store primitives, the `data/` directory and DTOs are not needed.

## Step-by-Step Process

### 1. Create the Interface

```dart
abstract interface class IExampleStorage {
  Future<ExampleDto?> example();
  Future<void> saveExample(ExampleDto dto);
  Future<void> clearExample();
}
```

### 2. Create Storage DTOs (if storing structured data)

```dart
@JsonSerializable()
class ExampleDto {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'name')
  final String name;

  const ExampleDto({required this.id, required this.name});

  factory ExampleDto.fromJson(Map<String, dynamic> json) =>
      _$ExampleDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ExampleDtoToJson(this);
}
```

### 3. Create the Implementation

```dart
final class ExampleStorage implements IExampleStorage {
  final IKeyValueStorage _storage;

  const ExampleStorage(this._storage);

  @override
  Future<ExampleDto?> example() async {
    final jsonString = await _storage.getString(ExampleStorageKeys.data.keyString);
    if (jsonString == null) return null;

    final json = jsonDecode(jsonString) as Map<String, dynamic>;
    return ExampleDto.fromJson(json);
  }

  @override
  Future<void> saveExample(ExampleDto dto) {
    return _storage.setString(
      ExampleStorageKeys.data.keyString,
      jsonEncode(dto.toJson()),
    );
  }

  @override
  Future<void> clearExample() {
    return _storage.remove(ExampleStorageKeys.data.keyString);
  }
}

enum ExampleStorageKeys {
  data('example_data');

  final String keyString;

  const ExampleStorageKeys(this.keyString);
}
```

### 4. Run Code Generation (if DTOs added)

```bash
make gen-persistence
```

Or scoped:
```bash
make gen-scope scope="modules/datasource/persistence/lib/**/*.g.dart"
```

### 5. Wire into DI

1. `AppPersistenceConfigurator` creates low-level storage instances (`IKeyValueStorage`, `ISecureStorage`)
2. Domain-specific storages are constructed with the appropriate low-level storage and registered in `AppAssembly`
3. Storages are injected into repositories via `AppAssembly` and the Assembly pattern

## Existing Storages (reference)

- **config_storage/** — debug configuration (proxy URL). Uses `IKeyValueStorage`
- **first_run/** — first app run status. Uses `IKeyValueStorage`
- **tokens_storage/** — auth token pair. Uses `ISecureStorage`. Implements `fresh.TokenStorage<AuthTokenPairDto>` for `fresh_dio` integration

## Converters

For Entity-to-DTO transformation, create converters in `lib/feature/{feature_name}/data/converter/` following the [converter-creation](mdc:.cursor/rules/converter-creation.mdc) rule.

---

# Database DAO Path

Use this path when you need to store **structured relational data** in SQLite via Drift. For table definitions, DAO patterns, and method naming, see [database-dao](mdc:.cursor/rules/database-dao.mdc).

## Directory Layout

```
modules/datasource/persistence/lib/
├── src/db/
│   ├── app_database.dart          # @DriftDatabase — register tables here
│   ├── app_database.g.dart        # Generated (DB DTOs, table classes)
│   └── tables/
│       └── example_table.dart     # Table definition with @DataClassName
└── storage/example_dao/
    ├── i_example_dao.dart         # DAO interface
    └── example_dao.dart           # DAO implementation
```

## Step-by-Step Process

### 1. Create the Table Definition

Location: `modules/datasource/persistence/lib/src/db/tables/{plural_name}_table.dart`

```dart
import 'package:drift/drift.dart';

@DataClassName('ExampleDBDto')
class ExamplesTable extends Table {
  const ExamplesTable();

  @override
  String get tableName => 'examples';

  @override
  Set<Column<Object>> get primaryKey => {id};

  @JsonKey('id')
  TextColumn get id => text()();

  @JsonKey('name')
  TextColumn get name => text()();

  @JsonKey('created_at')
  DateTimeColumn get createdAt => dateTime()();
}
```

### 2. Register Table in AppDatabase

Add the table class to the `tables` list in `lib/src/db/app_database.dart`:

```dart
@DriftDatabase(
  tables: [
    UsersTable,
    ExamplesTable, // <-- add here
  ],
)
class AppDatabase extends _$AppDatabase {
```

Increment `schemaVersion` if this is not a fresh database.

### 3. Create the DAO Interface

Location: `modules/datasource/persistence/lib/storage/{entity}_dao/i_{entity}_dao.dart`

```dart
import 'package:module_datasource_persistence/src/db/app_database.dart';

abstract interface class IExampleDao {
  Future<void> insertExample(ExampleDBDto example);
  Future<ExampleDBDto?> exampleById(String id);
  Future<List<ExampleDBDto>> allExamples();
  Future<bool> updateExample(ExampleDBDto example);
  Future<bool> deleteExample(String id);
}
```

### 4. Create the DAO Implementation

Location: `modules/datasource/persistence/lib/storage/{entity}_dao/{entity}_dao.dart`

```dart
import 'package:drift/drift.dart';
import 'package:module_datasource_persistence/src/db/app_database.dart';
import 'package:module_datasource_persistence/storage/example_dao/i_example_dao.dart';

final class ExampleDao implements IExampleDao {
  final AppDatabase _database;

  const ExampleDao(this._database);

  @override
  Future<void> insertExample(ExampleDBDto example) async {
    await _database
        .into(_examplesTable)
        .insert(example.toCompanion(true), mode: InsertMode.insertOrReplace);
  }

  @override
  Future<ExampleDBDto?> exampleById(String id) {
    final query = _database.select(_examplesTable)
      ..where((tbl) => tbl.id.equals(id));

    return query.getSingleOrNull();
  }

  @override
  Future<List<ExampleDBDto>> allExamples() {
    return _database.select(_examplesTable).get();
  }

  @override
  Future<bool> updateExample(ExampleDBDto example) async {
    final query = _database.update(_examplesTable)
      ..where((tbl) => tbl.id.equals(example.id));
    final updatedRows = await query.write(example.toCompanion(true));

    return updatedRows > 0;
  }

  @override
  Future<bool> deleteExample(String id) async {
    final query = _database.delete(_examplesTable)
      ..where((tbl) => tbl.id.equals(id));
    final deletedRows = await query.go();

    return deletedRows > 0;
  }

  $ExamplesTableTable get _examplesTable => _database.examplesTable;
}
```

### 5. Run Code Generation

```bash
make gen-persistence
```

Or scoped:
```bash
make gen-scope scope="modules/datasource/persistence/lib/src/db/app_database.g.dart"
```

### 6. Wire into DI

1. `AppPersistenceConfigurator.createAppDatabase(name)` creates the `AppDatabase` instance
2. The DAO is constructed with `AppDatabase` and registered in `AppAssembly`
3. DAOs are injected into repositories via `AppAssembly` and the Assembly pattern

## Existing DAOs (reference)

- **users_dao/** — CRUD operations on users table. Takes `AppDatabase`
