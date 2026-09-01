import 'package:quizzerg/feature/groups_list/data/dto/group_dto.dart';
import 'package:quizzerg/network/dto/page_response_dto.dart';

/// CRUD-эндпоинты `/groups`.
///
/// В UI-флоу не используются: запись идёт через `/sync/push`.
/// Нужны для отладки, интеграционных тестов и как фолбэк.
abstract interface class IGroupsApiRepository {
  Future<PageResponseDto<GroupDto>> getGroups({
    String? cursor,
    int? limit,
    String? search,
  });

  Future<GroupDto> createGroup(CreateGroupDto body);

  Future<GroupDto> getGroup(String id);

  Future<GroupDto> updateGroup(String id, UpdateGroupDto body);

  Future<void> deleteGroup(String id);

  /// Снять soft-delete. Связи с тестами не восстанавливаются.
  Future<GroupDto> restoreGroup(String id);
}
