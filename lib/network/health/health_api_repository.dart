import 'package:quizzerg/network/api/api_client.dart';
import 'package:quizzerg/network/health/health_dto.dart';

/// Пробы `/health`. Авторизация не нужна — используется в debug-меню.
abstract interface class IHealthApiRepository {
  Future<HealthDto> live();

  Future<ReadyDto> ready();
}

/// Реализация [IHealthApiRepository] поверх REST.
class HealthApiRepository implements IHealthApiRepository {
  final ApiClient _client;

  const HealthApiRepository({required ApiClient client}) : _client = client;

  @override
  Future<HealthDto> live() => _client.request(
        send: (dio) => dio.get<Object?>('/health'),
        parse: (data) => HealthDto.fromJson(ApiClient.asMap(data)),
      );

  @override
  Future<ReadyDto> ready() => _client.request(
        send: (dio) => dio.get<Object?>('/health/ready'),
        parse: (data) => ReadyDto.fromJson(ApiClient.asMap(data)),
      );
}
