import 'package:quizzerg/feature/tokens/data/dto/pat_dto.dart';

/// Эндпоинты `/tokens` (Personal Access Tokens).
///
/// Доступны только по JWT: PAT управлять токенами не может (403).
/// UI отложен, эндпоинты реализованы.
abstract interface class ITokensApiRepository {
  Future<List<PatDto>> getTokens();

  /// Полный токен виден в ответе **один раз**.
  Future<CreatePatResponseDto> createToken(CreatePatDto body);

  Future<void> revokeToken(String id);
}
