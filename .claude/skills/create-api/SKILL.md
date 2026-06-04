---
name: create-api
description: Create Retrofit API interfaces and DTOs with proper nullability, JSON serialization, and code generation. Use when adding new API clients or data transfer objects.
---

# Create API Client & DTOs

Create Retrofit API interfaces and DTOs in the `module_datasource_network` module following project conventions.

For nullability rules, annotation requirements, and DTO conventions, see [retrofit-api-generation](mdc:.cursor/rules/retrofit-api-generation.mdc).

## File Locations

- **API interfaces**: `modules/datasource/network/lib/api/<feature>/<feature>_api.dart`
- **DTOs**: `modules/datasource/network/lib/dto/<name>_dto.dart` (each DTO in its own file)

## Step-by-Step Process

### 1. Create the API Interface

```dart
import 'package:dio/dio.dart' hide Headers;
import 'package:module_datasource_network/dto/user_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'user_api.g.dart';

/// {@template user_api.class}
/// API for user operations.
/// {@endtemplate}
@RestApi()
abstract class UserApi {
  /// {@macro user_api.class}
  factory UserApi(Dio dio, {String baseUrl}) = _UserApi;

  /// Fetch the current user profile.
  @GET('/api/v1/users/me')
  Future<UserDto> getMe();

  /// Update user settings.
  @PUT('/api/v1/users/settings')
  Future<void> updateSettings(@Body() UpdateSettingsRequestDto body);
}
```

### 2. Create Response DTOs

```dart
import 'package:json_annotation/json_annotation.dart';

part 'user_dto.g.dart';

/// {@template user_dto.class}
/// DTO for a user profile.
/// {@endtemplate}
@JsonSerializable()
class UserDto {
  /// User identifier.
  @JsonKey(name: 'id')
  final int id;

  /// Display name.
  @JsonKey(name: 'display_name')
  final String? displayName;

  /// User email.
  @JsonKey(name: 'email')
  final String? email;

  /// {@macro user_dto.class}
  const UserDto({
    required this.id,
    this.displayName,
    this.email,
  });

  /// Create instance from JSON.
  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  /// Convert instance to JSON.
  Map<String, dynamic> toJson() => _$UserDtoToJson(this);
}
```

### 3. Create Request DTOs

```dart
import 'package:json_annotation/json_annotation.dart';

part 'update_settings_request_dto.g.dart';

/// {@template update_settings_request_dto.class}
/// DTO for the update-settings request payload.
/// {@endtemplate}
@JsonSerializable(includeIfNull: false)
class UpdateSettingsRequestDto {
  /// New display name.
  @JsonKey(name: 'display_name')
  final String displayName;

  /// Notification preference (optional).
  @JsonKey(name: 'push_enabled')
  final bool? pushEnabled;

  /// {@macro update_settings_request_dto.class}
  const UpdateSettingsRequestDto({
    required this.displayName,
    this.pushEnabled,
  });

  /// Create instance from JSON.
  factory UpdateSettingsRequestDto.fromJson(Map<String, dynamic> json) =>
      _$UpdateSettingsRequestDtoFromJson(json);

  /// Convert instance to JSON.
  Map<String, dynamic> toJson() => _$UpdateSettingsRequestDtoToJson(this);
}
```

### 4. Run Code Generation

```bash
make gen-network
```

Or scoped:
```bash
make gen-scope scope="modules/datasource/network/lib/**/*.g.dart"
```

### 5. Create DTO-to-Entity Converters

DTOs must not leak into the domain layer. Create converter classes in `feature/<name>/data/converter/` following the [converter-creation](mdc:.cursor/rules/converter-creation.mdc) rule.

## Dio Configuration & Error Handling

- **Dio creation**: use `AppDioConfigurator.create()` from `module_datasource_network`. It configures timeouts, proxy support, and interceptors.
- **Token refresh**: the project uses `fresh_dio` (in `module_datasource_persistence`) for automatic token refresh. Do not implement custom token refresh interceptors.
- **Error handling**: `BaseRepository.handle()` wraps API calls, catches `DioException`, and maps them to typed `NetworkFailure` subclasses (`NoNetworkFailure`, `ServerNotRespondingFailure`, `UnknownNetworkFailure`). Repositories should always use this wrapper.
