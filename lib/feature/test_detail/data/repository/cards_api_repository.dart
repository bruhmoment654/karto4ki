import 'package:quizzerg/feature/test_detail/data/dto/card_dto.dart';
import 'package:quizzerg/feature/test_detail/domain/repository/i_cards_api_repository.dart';
import 'package:quizzerg/network/api/api_client.dart';
import 'package:quizzerg/network/dto/page_response_dto.dart';

/// Реализация [ICardsApiRepository] поверх REST.
class CardsApiRepository implements ICardsApiRepository {
  final ApiClient _client;

  const CardsApiRepository({required ApiClient client}) : _client = client;

  @override
  Future<PageResponseDto<CardDto>> getCards({
    String? cursor,
    int? limit,
    String? testId,
    String? search,
    String? questionKey,
  }) =>
      _client.request(
        send: (dio) => dio.get<Object?>(
          '/cards',
          queryParameters: {
            if (cursor != null) 'cursor': cursor,
            if (limit != null) 'limit': limit,
            if (testId != null) 'testId': testId,
            if (search != null) 'search': search,
            if (questionKey != null) 'questionKey': questionKey,
          },
        ),
        parse: (data) => ApiClient.asPage(data, CardDto.fromJson),
      );

  @override
  Future<CardDto> createCard(CreateCardDto body) => _client.request(
        send: (dio) => dio.post<Object?>('/cards', data: body.toJson()),
        parse: (data) => CardDto.fromJson(ApiClient.asMap(data)),
      );

  @override
  Future<CardDto> getCard(String id) => _client.request(
        send: (dio) => dio.get<Object?>('/cards/$id'),
        parse: (data) => CardDto.fromJson(ApiClient.asMap(data)),
      );

  @override
  Future<CardDto> updateCard(String id, UpdateCardDto body) => _client.request(
        send: (dio) => dio.patch<Object?>('/cards/$id', data: body.toJson()),
        parse: (data) => CardDto.fromJson(ApiClient.asMap(data)),
      );

  @override
  Future<void> deleteCard(String id) =>
      _client.requestVoid((dio) => dio.delete<Object?>('/cards/$id'));

  @override
  Future<BatchCreateCardsResultDto> createCardsBatch(
    BatchCreateCardsDto body,
  ) =>
      _client.request(
        send: (dio) => dio.post<Object?>('/cards/batch', data: body.toJson()),
        parse: (data) =>
            BatchCreateCardsResultDto.fromJson(ApiClient.asMap(data)),
      );
}
