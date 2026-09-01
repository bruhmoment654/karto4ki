import 'package:quizzerg/feature/tests_list/data/dto/test_dto.dart';
import 'package:quizzerg/feature/tests_list/domain/repository/i_tests_api_repository.dart';
import 'package:quizzerg/network/api/api_client.dart';
import 'package:quizzerg/network/dto/page_response_dto.dart';

/// Реализация [ITestsApiRepository] поверх REST.
class TestsApiRepository implements ITestsApiRepository {
  final ApiClient _client;

  const TestsApiRepository({required ApiClient client}) : _client = client;

  @override
  Future<PageResponseDto<TestDto>> getTests({
    String? cursor,
    int? limit,
    String? groupId,
    String? search,
    String? type,
  }) =>
      _client.request(
        send: (dio) => dio.get<Object?>(
          '/tests',
          queryParameters: {
            if (cursor != null) 'cursor': cursor,
            if (limit != null) 'limit': limit,
            if (groupId != null) 'groupId': groupId,
            if (search != null) 'search': search,
            if (type != null) 'type': type,
          },
        ),
        parse: (data) => ApiClient.asPage(data, TestDto.fromJson),
      );

  @override
  Future<TestDto> createTest(CreateTestDto body) => _client.request(
        send: (dio) => dio.post<Object?>('/tests', data: body.toJson()),
        parse: (data) => TestDto.fromJson(ApiClient.asMap(data)),
      );

  @override
  Future<TestDto> getTest(String id) => _client.request(
        send: (dio) => dio.get<Object?>('/tests/$id'),
        parse: (data) => TestDto.fromJson(ApiClient.asMap(data)),
      );

  @override
  Future<TestDto> updateTest(String id, UpdateTestDto body) => _client.request(
        send: (dio) => dio.patch<Object?>('/tests/$id', data: body.toJson()),
        parse: (data) => TestDto.fromJson(ApiClient.asMap(data)),
      );

  @override
  Future<void> deleteTest(String id) =>
      _client.requestVoid((dio) => dio.delete<Object?>('/tests/$id'));

  @override
  Future<TestDto> restoreTest(String id) => _client.request(
        send: (dio) => dio.post<Object?>('/tests/$id/restore'),
        parse: (data) => TestDto.fromJson(ApiClient.asMap(data)),
      );

  @override
  Future<TestDto> mergeTest(String id, MergeTestDto body) => _client.request(
        send: (dio) =>
            dio.post<Object?>('/tests/$id/merge', data: body.toJson()),
        parse: (data) => TestDto.fromJson(ApiClient.asMap(data)),
      );

  @override
  Future<MoveCardsResultDto> moveCards(String id, MoveCardsDto body) =>
      _client.request(
        send: (dio) => dio.post<Object?>(
          '/tests/$id/move-cards',
          data: body.toJson(),
        ),
        parse: (data) => MoveCardsResultDto.fromJson(ApiClient.asMap(data)),
      );
}
