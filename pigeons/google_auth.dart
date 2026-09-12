import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/feature/auth/data/service/google_auth_api.g.dart',
    kotlinOut:
        'android/app/src/main/kotlin/dev/urbaev/c4rds/GoogleAuthApi.g.kt',
    kotlinOptions: KotlinOptions(package: 'dev.urbaev.c4rds'),
    swiftOut: 'ios/Runner/GoogleAuthApi.g.swift',
    dartPackageName: 'quizzerg',
  ),
)
/// Исход попытки входа.
///
/// Отмена — не ошибка, а нормальный результат, поэтому она здесь, а не
/// в канале ошибок: `PlatformException.code` — строка, опечатку в которой
/// компилятор не поймает.
enum GoogleSignInStatus {
  /// Токен получен.
  success,

  /// Пользователь закрыл пикер. Показывать ошибку нельзя.
  cancelled,

  /// На устройстве нет подходящего аккаунта Google.
  noCredential,

  /// Всё остальное: конфигурация, сеть, отказ Credential Manager.
  failure,
}

/// Результат входа.
///
/// Union-типа тут не получить — Pigeon не умеет sealed-иерархии, поэтому
/// формально можно собрать `success` с `idToken == null`. Дырка закрывается
/// в адаптере на стороне Dart, наружу идут нормальные исключения.
class GoogleSignInResult {
  GoogleSignInResult({
    required this.status,
    this.idToken,
    this.errorMessage,
  });

  final GoogleSignInStatus status;

  /// Заполнен только при [GoogleSignInStatus.success].
  /// Полноценный credential — не логировать.
  final String? idToken;

  /// Диагностика для лога при [GoogleSignInStatus.failure].
  final String? errorMessage;
}

/// Flutter зовёт натив.
@HostApi()
abstract class GoogleAuthApi {
  /// [nonce] уходит в токен дословно, без sha256 — сервер сравнивает claim
  /// с выданной строкой как есть.
  ///
  /// [serverClientId] — OAuth-клиент типа Web: он станет `aud` токена,
  /// его же проверяет бэкенд.
  ///
  /// Параметры позиционные: именованных Pigeon не поддерживает. Именованный
  /// контракт остаётся в `IGoogleSignInService`, его разворачивает адаптер.
  @async
  GoogleSignInResult signIn(String nonce, String serverClientId);

  /// Сбросить выбранный аккаунт, чтобы следующий вход снова спросил.
  @async
  void signOut();


  void test();
}
