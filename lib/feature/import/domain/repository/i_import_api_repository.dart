import 'package:quizzerg/feature/import/data/dto/import_result_dto.dart';

/// Эндпоинт `POST /import/csv`.
///
/// В UI-флоу не используется: локальный `CsvImportService` работает
/// офлайн, а результат уезжает через sync.
abstract interface class IImportApiRepository {
  Future<ImportResultDto> importCsv({
    required String filePath,
    String? targetTestId,
    String? groupTitle,
    String? testTitle,
    String? delimiter,
    bool? dryRun,
  });
}
