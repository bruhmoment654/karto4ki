import 'package:dio/dio.dart';

import 'package:quizzerg/core/feature/core/entity/request_operation.dart';
import 'package:quizzerg/core/feature/data/repository/base_repository.dart';
import 'package:quizzerg/feature/developer/domain/repository/i_debug_repository.dart';
import 'package:quizzerg/network/api/api_config.dart';
import 'package:quizzerg/network/api/dio_proxy.dart';
import 'package:quizzerg/persistence/debug/i_debug_config_storage.dart';

/// Реализация [IDebugRepository].
class DebugRepository extends BaseRepository implements IDebugRepository {
  final IDebugConfigStorage _debugConfigStorage;
  final ApiConfig _apiConfig;
  final Dio _dio;

  const DebugRepository({
    required IDebugConfigStorage debugConfigStorage,
    required ApiConfig apiConfig,
    required Dio dio,
    required super.errorLogger,
  })  : _debugConfigStorage = debugConfigStorage,
        _apiConfig = apiConfig,
        _dio = dio;

  @override
  String get baseUrl => _apiConfig.baseUrl;

  @override
  String? getProxyUrl() => _debugConfigStorage.getProxyUrl();

  @override
  RequestOperation<void> saveProxyUrl(String? proxyUrl) => makeCall(() async {
        final trimmed = proxyUrl?.trim();
        final value = trimmed == null || trimmed.isEmpty ? null : trimmed;

        await _debugConfigStorage.setProxyUrl(value);
        DioProxy.apply(_dio, value);
      });
}
