import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quizzerg/core/logger/error_logger.dart';
import 'package:quizzerg/feature/developer/data/repository/debug_repository.dart';
import 'package:quizzerg/network/api/api_config.dart';
import 'package:quizzerg/network/api/api_environment.dart';
import 'package:quizzerg/persistence/debug/i_debug_config_storage.dart';

class _FakeDebugConfigStorage implements IDebugConfigStorage {
  String? proxyUrl;

  @override
  String? getProxyUrl() => proxyUrl;

  @override
  Future<void> setProxyUrl(String? value) async {
    proxyUrl = value;
  }
}

class _SilentErrorLogger implements ErrorLogger {
  @override
  void logError(Object error, StackTrace stackTrace) {}
}

void main() {
  late _FakeDebugConfigStorage storage;
  late DebugRepository repository;

  setUp(() {
    storage = _FakeDebugConfigStorage();
    repository = DebugRepository(
      debugConfigStorage: storage,
      apiConfig: const ApiConfig(environment: AppUrl.prod),
      dio: Dio(),
      errorLogger: _SilentErrorLogger(),
    );
  });

  group('DebugRepository', () {
    test('сохраняет адрес прокси', () async {
      final result = await repository.saveProxyUrl('192.168.0.2:8888');

      expect(result.isOk, isTrue);
      expect(storage.proxyUrl, '192.168.0.2:8888');
      expect(repository.getProxyUrl(), '192.168.0.2:8888');
    });

    test('обрезает пробелы вокруг адреса', () async {
      await repository.saveProxyUrl('  10.0.0.1:9090  ');

      expect(storage.proxyUrl, '10.0.0.1:9090');
    });

    test('пустая строка выключает прокси', () async {
      storage.proxyUrl = '10.0.0.1:9090';

      await repository.saveProxyUrl('   ');

      expect(storage.proxyUrl, isNull);
    });

    test('null выключает прокси', () async {
      storage.proxyUrl = '10.0.0.1:9090';

      await repository.saveProxyUrl(null);

      expect(storage.proxyUrl, isNull);
    });

    test('отдаёт base url окружения', () {
      expect(repository.baseUrl, AppUrl.prod.baseUrl);
    });
  });
}
