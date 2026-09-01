import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';

/// Сценарный ответ фейкового транспорта.
class ScriptedResponse {
  final int statusCode;
  final Map<String, Object?> body;

  const ScriptedResponse(this.statusCode, [this.body = const {}]);
}

/// Фейковый [HttpClientAdapter]: отдаёт заранее заданные ответы по очереди
/// и запоминает все запросы.
class ScriptedAdapter implements HttpClientAdapter {
  final List<ScriptedResponse> script;
  final List<RequestOptions> requests = [];

  ScriptedAdapter(this.script);

  /// Ответ, который отдаётся, когда сценарий закончился.
  ScriptedResponse fallback = const ScriptedResponse(200);

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requests.add(options);
    final response = script.isEmpty ? fallback : script.removeAt(0);

    return ResponseBody.fromString(
      jsonEncode(response.body),
      response.statusCode,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}
