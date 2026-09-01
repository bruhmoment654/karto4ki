import 'package:quizzerg/feature/groups_list/data/dto/group_dto.dart';
import 'package:quizzerg/feature/groups_list/domain/repository/i_groups_api_repository.dart';
import 'package:quizzerg/network/api/api_client.dart';
import 'package:quizzerg/network/dto/page_response_dto.dart';

/// Реализация [IGroupsApiRepository] поверх REST.
class GroupsApiRepository implements IGroupsApiRepository {
  final ApiClient _client;

  const GroupsApiRepository({required ApiClient client}) : _client = client;

  @override
  Future<PageResponseDto<GroupDto>> getGroups({
    String? cursor,
    int? limit,
    String? search,
  }) =>
      _client.request(
        send: (dio) => dio.get<Object?>(
          '/groups',
          queryParameters: {
            if (cursor != null) 'cursor': cursor,
            if (limit != null) 'limit': limit,
            if (search != null) 'search': search,
          },
        ),
        parse: (data) => ApiClient.asPage(data, GroupDto.fromJson),
      );

  @override
  Future<GroupDto> createGroup(CreateGroupDto body) => _client.request(
        send: (dio) => dio.post<Object?>('/groups', data: body.toJson()),
        parse: (data) => GroupDto.fromJson(ApiClient.asMap(data)),
      );

  @override
  Future<GroupDto> getGroup(String id) => _client.request(
        send: (dio) => dio.get<Object?>('/groups/$id'),
        parse: (data) => GroupDto.fromJson(ApiClient.asMap(data)),
      );

  @override
  Future<GroupDto> updateGroup(String id, UpdateGroupDto body) =>
      _client.request(
        send: (dio) => dio.patch<Object?>('/groups/$id', data: body.toJson()),
        parse: (data) => GroupDto.fromJson(ApiClient.asMap(data)),
      );

  @override
  Future<void> deleteGroup(String id) =>
      _client.requestVoid((dio) => dio.delete<Object?>('/groups/$id'));

  @override
  Future<GroupDto> restoreGroup(String id) => _client.request(
        send: (dio) => dio.post<Object?>('/groups/$id/restore'),
        parse: (data) => GroupDto.fromJson(ApiClient.asMap(data)),
      );
}
