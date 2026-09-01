import 'package:quizzerg/feature/profile/data/dto/user_dto.dart';
import 'package:quizzerg/feature/profile/domain/repository/i_profile_api_repository.dart';
import 'package:quizzerg/network/api/api_client.dart';

/// Реализация [IProfileApiRepository] поверх REST.
class ProfileApiRepository implements IProfileApiRepository {
  final ApiClient _client;

  const ProfileApiRepository({required ApiClient client}) : _client = client;

  @override
  Future<UserDto> getMe() => _client.request(
        send: (dio) => dio.get<Object?>('/me'),
        parse: (data) => UserDto.fromJson(ApiClient.asMap(data)),
      );

  @override
  Future<UserDto> updateMe(UpdateMeDto body) => _client.request(
        send: (dio) => dio.patch<Object?>('/me', data: body.toJson()),
        parse: (data) => UserDto.fromJson(ApiClient.asMap(data)),
      );

  @override
  Future<void> deleteMe() =>
      _client.requestVoid((dio) => dio.delete<Object?>('/me'));
}
