import 'package:quizzerg/core/feature/data/converter/converter.dart';
import 'package:quizzerg/feature/auth/domain/entity/auth_user_entity.dart';
import 'package:quizzerg/feature/profile/data/dto/user_dto.dart';

/// `UserDto` → [AuthUserEntity].
final class AuthUserConverter extends Converter<AuthUserEntity, UserDto> {
  const AuthUserConverter();

  @override
  AuthUserEntity convert(UserDto? input) {
    final dto = cast(input);

    return AuthUserEntity(
      id: dto.id,
      email: dto.email,
      plan: dto.plan,
      displayName: dto.displayName,
      avatarUrl: dto.avatarUrl,
    );
  }
}
