/// Результат экспорта статистики.
sealed class StatsExportResult {
  const StatsExportResult();
}

final class StatsExportSuccess extends StatsExportResult {
  final String statsFilePath;
  final String cardsFilePath;
  final int questionCount;
  final int cardCount;

  const StatsExportSuccess({
    required this.statsFilePath,
    required this.cardsFilePath,
    required this.questionCount,
    required this.cardCount,
  });
}

final class StatsExportCancelled extends StatsExportResult {
  const StatsExportCancelled();
}

final class StatsExportEmpty extends StatsExportResult {
  const StatsExportEmpty();
}

final class StatsExportFailure extends StatsExportResult {
  final String message;
  const StatsExportFailure(this.message);
}

/// Экспортирует статистику вопросов и связь карточка↔тест↔группа в CSV.
abstract interface class IStatsExportService {
  Future<StatsExportResult> export();
}
