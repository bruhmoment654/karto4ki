import 'package:quizzerg/feature/tests_list/data/dto/test_dto.dart';
import 'package:quizzerg/network/dto/page_response_dto.dart';

/// CRUD-эндпоинты `/tests`.
///
/// В UI-флоу не используются: запись идёт через `/sync/push`.
abstract interface class ITestsApiRepository {
  Future<PageResponseDto<TestDto>> getTests({
    String? cursor,
    int? limit,
    String? groupId,
    String? search,
    String? type,
  });

  Future<TestDto> createTest(CreateTestDto body);

  Future<TestDto> getTest(String id);

  Future<TestDto> updateTest(String id, UpdateTestDto body);

  Future<void> deleteTest(String id);

  /// Снять soft-delete. Карточки оживают автоматически.
  Future<TestDto> restoreTest(String id);

  /// Перенести карточки в target и удалить исходный тест.
  Future<TestDto> mergeTest(String id, MergeTestDto body);

  /// Перенести конкретные карточки в другой тест.
  Future<MoveCardsResultDto> moveCards(String id, MoveCardsDto body);
}
