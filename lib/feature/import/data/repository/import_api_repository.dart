import 'package:dio/dio.dart';

import 'package:quizzerg/feature/import/data/dto/import_result_dto.dart';
import 'package:quizzerg/feature/import/domain/repository/i_import_api_repository.dart';
import 'package:quizzerg/network/api/api_client.dart';
import 'package:quizzerg/network/api/api_config.dart';

/// Реализация [IImportApiRepository] поверх REST.
class ImportApiRepository implements IImportApiRepository {
  final ApiClient _client;
  final ApiConfig _config;

  const ImportApiRepository({
    required ApiClient client,
    required ApiConfig config,
  })  : _client = client,
        _config = config;

  @override
  Future<ImportResultDto> importCsv({
    required String filePath,
    String? targetTestId,
    String? groupTitle,
    String? testTitle,
    String? delimiter,
    bool? dryRun,
  }) async {
    final form = FormData.fromMap({
      'file': await MultipartFile.fromFile(filePath),
      if (targetTestId != null) 'targetTestId': targetTestId,
      if (groupTitle != null) 'groupTitle': groupTitle,
      if (testTitle != null) 'testTitle': testTitle,
      if (delimiter != null) 'delimiter': delimiter,
      if (dryRun != null) 'dryRun': dryRun,
    });

    return _client.request(
      send: (dio) => dio.post<Object?>(
        '/import/csv',
        data: form,
        options: Options(receiveTimeout: _config.longReceiveTimeout),
      ),
      parse: (data) => ImportResultDto.fromJson(ApiClient.asMap(data)),
    );
  }
}
