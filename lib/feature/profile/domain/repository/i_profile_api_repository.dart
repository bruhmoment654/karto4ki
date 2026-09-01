import 'package:quizzerg/feature/profile/data/dto/user_dto.dart';

/// Эндпоинты `/me`. Локальной копии профиля нет — читаем напрямую.
abstract interface class IProfileApiRepository {
  Future<UserDto> getMe();

  Future<UserDto> updateMe(UpdateMeDto body);

  /// Удаление аккаунта. Каскад на сервере.
  Future<void> deleteMe();
}
