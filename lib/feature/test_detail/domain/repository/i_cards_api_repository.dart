import 'package:quizzerg/feature/test_detail/data/dto/card_dto.dart';
import 'package:quizzerg/network/dto/page_response_dto.dart';

/// CRUD-эндпоинты `/cards`.
///
/// В UI-флоу не используются: запись идёт через `/sync/push`.
abstract interface class ICardsApiRepository {
  Future<PageResponseDto<CardDto>> getCards({
    String? cursor,
    int? limit,
    String? testId,
    String? search,
    String? questionKey,
  });

  Future<CardDto> createCard(CreateCardDto body);

  Future<CardDto> getCard(String id);

  Future<CardDto> updateCard(String id, UpdateCardDto body);

  Future<void> deleteCard(String id);

  /// Пачка карточек. Дубли по `(front, answers)` внутри теста пропускаются.
  Future<BatchCreateCardsResultDto> createCardsBatch(BatchCreateCardsDto body);
}
