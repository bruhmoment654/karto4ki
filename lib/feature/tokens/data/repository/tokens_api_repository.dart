import 'package:quizzerg/feature/tokens/data/dto/pat_dto.dart';
import 'package:quizzerg/feature/tokens/domain/repository/i_tokens_api_repository.dart';
import 'package:quizzerg/network/api/api_client.dart';

/// Реализация [ITokensApiRepository] поверх REST.
class TokensApiRepository implements ITokensApiRepository {
  final ApiClient _client;

  const TokensApiRepository({required ApiClient client}) : _client = client;

  @override
  Future<List<PatDto>> getTokens() => _client.request(
        send: (dio) => dio.get<Object?>('/tokens'),
        parse: (data) => PatListDto.fromJson(ApiClient.asMap(data)).tokens,
      );

  @override
  Future<CreatePatResponseDto> createToken(CreatePatDto body) =>
      _client.request(
        send: (dio) => dio.post<Object?>('/tokens', data: body.toJson()),
        parse: (data) => CreatePatResponseDto.fromJson(ApiClient.asMap(data)),
      );

  @override
  Future<void> revokeToken(String id) =>
      _client.requestVoid((dio) => dio.delete<Object?>('/tokens/$id'));
}
