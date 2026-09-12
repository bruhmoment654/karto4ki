# План: вход через Google — Credential Manager + Pigeon

> **Статус на 05.09.2026.** Из фазы A закрыты шаги 1 и 3 — `applicationId` сменён
> на `dev.urbaev.c4rds`, `INTERNET` переехал в основной манифест. Сверх плана появились
> keystore для dev и prod с рабочей подписью релизных сборок, поэтому в шаге 2 теперь
> есть все SHA-1, которые нужны для регистрации OAuth-клиентов.
>
> **Обновление:** шаги 1–15 закрыты, вход **работает на устройстве**. Проверено по логам
> сквозняком: `/auth/nonce` → 201, `/auth/google` → 201, `/me` → 200, дальше синхронизация
> сама поднялась (`/sync/changes`, `/sync/push` → 200), `/auth/logout` → 204, курсор
> переиспользуется (`?since=Mg`). Осталось: остальные сценарии шага 16 и iOS.

### Грабли, на которые напоролись при первом запуске

Обе — не в коде, но диагностируются неочевидно, поэтому записаны.

**1. Установилось не то приложение.** `fvm flutter run` без `--flavor` собрал оба флейвора,
а flutter-тул поставил флейворно-нейтральный `build/app/outputs/flutter-apk/app-debug.apk` —
четырёхдневный артефакт с ещё старым `com.example.quizzerg` внутри, без `setUp()` в
`MainActivity`. Симптом: `Unable to establish connection on channel:
dev.flutter.pigeon.quizzerg.GoogleAuthApi.<метод>` — выглядит как поломка Pigeon, а на самом
деле Dart-код свежий, а натив из старого APK. Лечится `flutter clean` и запуском
**с `--flavor dev`**.

**2. Неверный package name в Android OAuth-клиенте.** Симптом обманчивый: в приложение
приезжает `GetCredentialCancellationException` с сообщением `[16] Account reauth failed`,
то есть **отмена**, хотя пользователь ничего не отменял. Настоящая причина видна только
в логкате:

```
W Auth: [GetTokenResponseHandler] Server returned error: This android application
        is not registered to use OAuth2.0, please confirm the package name and
        SHA-1 certificate fingerprint match what you registered...
```

Важное: ошибка регистрации **не** приходит кодом 10 `DEVELOPER_ERROR`, как можно ожидать.
GMS доходит до `CREDENTIALS_RECEIVED` и `onUiEntrySelected` (пикер показан, аккаунт выбран),
и только на выдаче токена сервер отвечает отказом — а наружу это выходит как `[16] CANCELED`.
Поэтому при отладке смотреть надо на `GetTokenResponseHandler`, а не на статус в приложении.

Отсюда правка в шаге 8: ветка `GetCredentialCancellationException` **обязана** тащить
`e.errorMessage` наружу. Изначально она отдавала `null`, `AuthBloc` глотал отмену молча,
и сбой выглядел как «нажал кнопку — ничего не произошло», без следа в логах.

## Текущее состояние

### Что уже готово (менять не нужно)

- `IGoogleSignInService` — контракт получения ID-token, `lib/feature/auth/data/service/i_google_sign_in_service.dart`. Nonce передаётся дословно, без sha256: сервер сравнивает claim как есть.
- `AuthBloc._signIn` — цепочка `nonce → idToken → обмен`, с ретраем на `AuthInvalidNonce` ровно один раз (лимит `/auth/*` считается по IP).
- `AuthApiRepository` + `auth_dto.dart` — эндпоинты `/auth/nonce`, `/auth/google`, `/auth/refresh`, `/auth/logout`.
- DI: `StubGoogleSignInService` зарегистрирован в `app_scope_register.dart:177`, приложение собирается и работает как гость.
- Сессией владеет `IAuthStatusRepository` (см. [план 06](06_auth_and_sync_ui.md), §0 и A6). Для этого плана важно одно: после успешного обмена токенов `AuthBloc` зовёт `saveTokens`, и статус разъезжается по подписчикам сам — трогать здесь нечего.
- Подпись Android настроена: `devRelease` → `android/keystore/dev-keystore.jks`, `prodRelease` → `prod-keystore.jks`, debug-варианты → `~/.android/debug.keystore`. Проверено `./gradlew :app:signingReport` и `apksigner verify`.

### Что написано, но не работает

`android/app/src/main/kotlin/dev/urbaev/c4rds/GoogleAuthService.kt` + правки `MainActivity.kt`. Три блокера:

1. **`result.success(GoogleTokenResult)` не сериализуется.** `StandardMessageCodec` умеет только null / Boolean / Int / Long / Double / String / byte[] / int[] / long[] / double[] / List / Map. На попытке отдать Kotlin-класс прилетит `IllegalArgumentException: Unsupported value` внутри корутины, и ответ во Flutter не придёт вообще. Это и решает переезд на Pigeon: кодек генерируется под схему.
2. **`setFilterByAuthorizedAccounts(true)` роняет первый вход.** У пользователя, который в приложении ещё не авторизовывался, нет «authorized account» → `NoCredentialException`.
3. **`signOut` не реализован.** В `when (call.method)` только `signIn`, а `IGoogleSignInService.signOut()` вызывается из `AuthBloc._trySignOutGoogle`. Плюс нет `else -> notImplemented()`, так что неизвестный метод висит вечно.

Помимо этого: `MutableContextWrapper` мешает Credential Manager определить Activity; `activityScope` никогда не отменяется; `googleIdOption` — поле с зашитым nonce; отмена входа показывается пользователю как ошибка.

### Чего нет

- Pigeon не подключён.
- `serverClientId` захардкожен заглушкой `"w1we12"`.
- iOS-реализации нет вообще.

---

## Фаза A. Подготовка (без неё ничего не протестировать)

### Шаг 1. Сменить `applicationId` — ✅ сделано

Итог, на который опираются следующие шаги:

| | значение |
|---|---|
| `namespace` / `applicationId` | `dev.urbaev.c4rds` |
| каталог Kotlin | `android/app/src/main/kotlin/dev/urbaev/c4rds/` |
| package name флейвора `dev` | `dev.urbaev.c4rds.dev` (суффикс `.dev`) |
| package name флейвора `prod` | `dev.urbaev.c4rds` |

**Почему это было первым:** Google Play не принимает `applicationId` на `com.example`, а OAuth-клиент типа Android привязывается к паре «package name + SHA-1» — сменить id после регистрации значит сломать вход с невнятным `DEVELOPER_ERROR`.

**Важное следствие для шага 2:** package name у флейворов **разные**. Значит и Android-клиентов в Google Cloud нужно несколько — по одному на пару «package + SHA-1».

**И следствие для всех команд ниже:** везде по плану — `--flavor dev`.

Не потому, что без него падает: `fvm flutter build apk --debug` без флейвора отрабатывает
успешно (проверено). Он запускает `assembleDebug`, а тот с флейворами собирает **оба**
варианта — и `app-dev-debug.apk`, и `app-prod-debug.apk`. При этом в финальной строке
flutter рапортует про `app-debug.apk`, которого в этой сборке вообще не создавалось: если
в `build/` лежит артефакт со старых времён, сообщение будет указывать на него. Так что
без `--flavor` ты собираешь вдвое дольше и не знаешь наверняка, какой package name
поставится на устройство — а от него зависит, подойдёт ли зарегистрированный OAuth-клиент.
`DEVELOPER_ERROR` от Google при несовпадении package name никак не объясняет причину,
поэтому дешевле не создавать себе эту неопределённость.

---

### Шаг 2. Настроить OAuth-клиенты в Google Cloud

**Где:** console.cloud.google.com → APIs & Services → Credentials

**Что сделать:**

1. Создать (или взять существующий) проект, настроить OAuth consent screen.
2. Создать клиентов:
   - **Web** — один. Его Client ID и есть тот `serverClientId`, который уходит в `setServerClientId`.
   - **Android** — по одному на каждую пару «package name + SHA-1», которой предстоит логиниться. Ключи уже созданы, отпечатки известны:

   | Что собираем | Package name | SHA-1 |
   |---|---|---|
   | `devDebug` — повседневная разработка | `dev.urbaev.c4rds.dev` | `F4:68:8A:F7:42:32:05:54:7F:8F:ED:B2:2B:98:D2:02:90:58:AC:81` |
   | `devRelease` | `dev.urbaev.c4rds.dev` | `8E:41:76:DA:EA:38:05:45:3B:33:7F:CA:51:52:0E:F2:7C:90:D8:14` |
   | `prodRelease` | `dev.urbaev.c4rds` | `27:06:92:72:7D:A0:B1:1E:3C:75:0F:08:EC:9E:6D:1B:E7:C8:91:8F` |

   Минимум для начала работы — первая строка. Остальные две нужны до первой проверки релизной сборки.
3. Web Client ID передать бэкендеру — он должен проверять его как `aud`.

**Пересчитать отпечатки в любой момент:** `cd android && ./gradlew :app:signingReport` — покажет ключ для каждого варианта сборки.

**Если приложение поедет через Play App Signing:** Google подменяет ключ подписи на свой, и в консоли надо будет дополнительно зарегистрировать SHA-1 **из Play Console** (App integrity → App signing key certificate). Иначе вход развалится именно в проде и только у сборок из Play.

**Зачем:** самое частое недопонимание в этом флоу — что в `setServerClientId` идёт Android-клиент. Нет: там **Web**-клиент. Android-клиент обязан существовать (по нему GMS решает, можно ли этому приложению выдавать токены), но в код он не попадает.

**Важно:** этот ID — не секрет. Он уходит в claim `aud` подписанного токена и виден в любом декомпиле. Секрет — client secret, он живёт только на бэкенде. Так что прятать `serverClientId` смысла нет, выносить его стоит только ради конфигурации по окружениям.

**Отдельно (закрыто):** раньше release подписывался debug-ключом. Сейчас signing настроен по-настоящему — `android/keystore/signingConfigs.gradle` подключён из `build.gradle.kts`, флейворы берут свои ключи. SHA-1 релизных ключей — в таблице выше.

---

### Шаг 3. Добавить `INTERNET` в основной манифест — ✅ сделано

`<uses-permission android:name="android.permission.INTERNET" />` стоит в
`android/app/src/main/AndroidManifest.xml:3`.

**Зачем было нужно:** по шаблону Flutter разрешение объявлено только в `src/debug/`
и `src/profile/`. В release-сборке весь сетевой слой — включая `/auth/nonce` — молча
отвалился бы, и обнаружилось бы это ровно на первой проверке релиза.

---

### Шаг 4. Поправить зависимости Android — ✅ сделано

**Файл:** `android/app/build.gradle.kts`

**Что сделать:**

1. `androidx.credentials` + `credentials-play-services-auth` — с `1.7.0-alpha03` на **`1.6.0`** (последняя стабильная на maven.google.com; версии обязаны совпадать).
2. `googleid` — с `1.1.1` на **`1.2.0`**.
3. `androidx.lifecycle:lifecycle-runtime-ktx:2.7.0` — под `lifecycleScope` из шага 9. Приезжает и транзитивно с эмбеддингом Flutter (сборка проходит и без него), но полагаться на чужой граф зависимостей не стоит.
4. Блок `dependencies` **оставлен в конце файла**, вопреки исходной формулировке плана: это top-level блок Gradle, внутрь `android { }` он не переносится, а порядок `plugins → android → flutter → dependencies` — как раз шаблонный для Flutter.

**Зачем:** альфа-версия в проде — источник сюрпризов при обновлении AGP. `1.2.0` нужен ещё и потому, что там точно есть `GetSignInWithGoogleOption`, на который переходим в шаге 8.

**Проверка `minSdk`:** стоит `flutter.minSdkVersion`. Credential Manager с Google ID требует API 23+ — условие выполняется, ничего менять не надо.

---

## Фаза B. Pigeon

### Что такое Pigeon и зачем он здесь

Кодогенератор от команды Flutter. Пишешь **схему** — обычный Dart-файл с классами
и абстрактными интерфейсами — и `pigeon` собирает по ней связующий код сразу для двух
сторон: Dart-клиент и нативный интерфейс (Kotlin/Java, Swift/ObjC, C++).

Разница с голым `MethodChannel` в одном: канал — это `Map<String, dynamic>` и строковые
имена методов, то есть контракт, который держится на договорённости. Опечатка в имени
метода или лишнее поле в словаре — ошибка времени выполнения. Pigeon делает тот же контракт
проверяемым компилятором с обеих сторон.

**Что генерируется** из одной схемы:

| Файл | Что внутри |
|---|---|
| `…_api.g.dart` | классы данных + клиент: методы, которые вызываешь из Dart |
| `…Api.g.kt` | `interface GoogleAuthApi` (реализуешь руками) + `setUp()` для регистрации |
| `…Api.g.swift` | то же для iOS |

Плюс во все три — свой кодек: подкласс `StandardMessageCodec`, который умеет
(де)сериализовать классы из схемы. Ровно этого не хватало старому `GoogleAuthService.kt`:
он пытался отдать в канал Kotlin-класс, а стандартный кодек знает только примитивы,
`List` и `Map`.

**Мысленная модель.** Схема — это `.proto`, а `pigeon` — `protoc`. Схема нигде не
компилируется в приложение, она сырьё для генератора; поэтому и лежит вне `lib/`,
в `pigeons/`.

**Аннотации, которые понадобятся:**

- `@HostApi()` — Flutter зовёт натив. Наш случай.
- `@FlutterApi()` — наоборот, натив зовёт Dart (нам не нужно, но именно так делают
  колбэки и события).
- `@async` — метод на нативной стороне отвечает не сразу. Без неё Pigeon ждёт
  синхронный `return`, а Credential Manager — это корутина.
- `@ConfigurePigeon(PigeonOptions(...))` — куда класть выхлоп; альтернатива длинной
  строке аргументов CLI.

**Чего Pigeon не умеет** (споткнуться легко, а в документации это разбросано):

- именованных параметров в методах — только позиционные;
- дженериков в сигнатурах;
- sealed-иерархий и union-типов: `@ProxyApi` — про другое, про обёртки над нативными
  объектами. Значит честного `Result<Success | Cancelled>` не получить;
- наследования у классов данных.

**Ошибки.** Исключение на нативной стороне приезжает в Dart как `PlatformException`.
Чтобы задать `code`/`message`/`details` осознанно, Pigeon генерирует на нативной стороне
класс `FlutterError` — бросают именно его.

**Цикл работы:** правишь `pigeons/*.dart` → `make gen-pigeon` → чинишь то, что перестало
компилироваться с обеих сторон. Сгенерированные файлы перезаписываются целиком, руками
в них не лезут.

---

### Шаг 5. Подключить Pigeon — ✅ сделано

**Файлы:** `pubspec.yaml`, `make/codegen.mk`

**Что сделать:**

1. `fvm dart pub add -d pigeon` — версию пусть подберёт резолвер.
2. В `make/codegen.mk`:

```make
.PHONY: gen-all gen-l10n gen-pigeon

gen-all: gen-pigeon ## Generate code from all modules
	fvm dart run build_runner build --delete-conflicting-outputs

gen-pigeon: ## Generate platform channel code from pigeons/
	fvm dart run pigeon --input pigeons/google_auth.dart
```

**Зачем:** Pigeon не работает через `build_runner`, это отдельный CLI. Вешаем его зависимостью на `gen-all`, чтобы не забывать про отдельную команду и чтобы CI подхватил автоматически.

---

### Шаг 6. Описать схему — ✅ сделано

**Файл:** `pigeons/google_auth.dart` (новая папка)

**Что сделать:**

```dart
import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/feature/auth/data/service/google_auth_api.g.dart',
    kotlinOut:
        'android/app/src/main/kotlin/dev/urbaev/c4rds/GoogleAuthApi.g.kt',
    kotlinOptions: KotlinOptions(package: 'dev.urbaev.c4rds'),
    swiftOut: 'ios/Runner/GoogleAuthApi.g.swift',
    // Имя пакета из pubspec.yaml — Pigeon подставляет его в сообщения об ошибках.
    dartPackageName: 'quizzerg',
  ),
)
/// Исход попытки входа.
///
/// Отмена — не ошибка, а нормальный результат, поэтому она в enum,
/// а не в канале ошибок: `PlatformException.code` — строка, опечатку
/// в которой компилятор не поймает.
enum GoogleSignInStatus { success, cancelled, noCredential, failure }

class GoogleSignInResult {
  GoogleSignInResult({
    required this.status,
    this.idToken,
    this.errorMessage,
  });

  final GoogleSignInStatus status;
  final String? idToken;
  final String? errorMessage;
}

@HostApi()
abstract class GoogleAuthApi {
  @async
  GoogleSignInResult signIn(String nonce, String serverClientId);

  @async
  void signOut();
}
```

**Зачем:** это ровно та идея, что была в `GoogleTokenResult` — вернуть результат-тип вместо жонглирования кодами ошибок. Она была верной, не работала только потому, что стандартный кодек не знает про пользовательские классы. Pigeon генерирует кодек под схему, и вопрос снимается.

**Два ограничения схемы, о которые легко споткнуться:**

- Методы Pigeon принимают **только позиционные** параметры, именованных в схеме нет. Именованный контракт (`idToken({required String nonce})`) остаётся в `IGoogleSignInService`, разворачивает его адаптер из шага 12.
- Pigeon **не умеет sealed-иерархии** для data-классов (`@ProxyApi` — про другое). Честной union-типизации как во freezed тут не получить: остаётся плоский enum + nullable-поля, где формально можно собрать `success` с `idToken == null`. Эта дырка запирается в 15 строк адаптера — наружу пойдут нормальные исключения.

---

### Шаг 7. Сгенерировать и проверить выхлоп — ✅ сделано

**Что сделать:**

1. `make gen-pigeon`
2. Открыть `google_auth_api.g.dart` и `GoogleAuthApi.g.kt`, посмотреть:
   - как называются константы enum в Kotlin (`SUCCESS` или `success` — Pigeon по версиям менял регистр);
   - какая подпись у `@async`-методов: колбэчная `(Result<T>) -> Unit` или `suspend fun` (свежие версии умеют генерировать корутины — тогда обёртка с `launch` в шаге 8 не нужна);
   - есть ли в файле класс `FlutterError` (по умолчанию Pigeon его генерирует, он понадобится в `signOut`).
3. Убедиться, что `google_auth_api.g.dart` не попал в анализ — под `analyzer.exclude` уже есть `lib/**/*.g.dart` (`analysis_options.yaml:10`), поэтому имя с `.g.dart` выбрано не случайно.

**Что получилось на pigeon 27.3.0** (проверено, не по памяти):

| Вопрос | Ответ |
|---|---|
| регистр enum в Kotlin | `SCREAMING_SNAKE_CASE`: `SUCCESS`, `CANCELLED`, `NO_CREDENTIAL`, `FAILURE`, каждый с `(val raw: Int)` |
| подпись `@async` | **колбэк**, не корутина: `fun signIn(nonce: String, serverClientId: String, callback: (Result<GoogleSignInResult>) -> Unit)`. Значит обёртка с `launch` в шаге 8 нужна |
| `FlutterError` | генерируется, `GoogleAuthApi.g.kt:189` |
| регистрация | `GoogleAuthApi.setUp(binaryMessenger, api, messageChannelSuffix = "")` |
| doc-комментарии из схемы | переносятся в сгенерированный Kotlin и Dart — писать их в схеме имеет смысл |

**Отдельно проверено:** `@HostApi() abstract class GoogleAuthApi implements IGoogleSignInService`
**не работает** — Pigeon `implements` молча игнорирует, сгенерированный `class GoogleAuthApi`
(`google_auth_api.g.dart:213`) не реализует ничего. Связать сгенерированный API с доменным
контрактом можно только адаптером (шаг 13), и это правильно: транспортный тип
`GoogleSignInResult` не должен протекать в `IGoogleSignInService`.

**Где лежит схема:** `pigeons/google_auth.dart`, **вне `lib/`**. Это не стилистика:
схема импортирует `package:pigeon/pigeon.dart`, а `pigeon` — dev-зависимость. Положить
схему в `lib/` — значит потянуть dev-пакет в код приложения; анализатор ругается
`depend_on_referenced_packages`, а если на схему сошлётся рабочий код, развалится и сборка.

**Зачем:** дальше пишется код против сгенерированного интерфейса, и лучше один раз посмотреть на него глазами, чем угадывать. Pigeon перезаписывает файлы целиком — правило CLAUDE.md «`*.g.dart` не редактировать руками» на них распространяется в полной мере.

---

## Фаза C. Нативная реализация

### Шаг 8. Написать `GoogleAuthApiImpl` — ✅ сделано

**Файл:** `android/app/src/main/kotlin/dev/urbaev/c4rds/GoogleAuthApiImpl.kt` (новый)

**Что сделать:** реализовать сгенерированный интерфейс:

```kotlin
/** Реализация сгенерированного [GoogleAuthApi] поверх Credential Manager. */
class GoogleAuthApiImpl(
    private val activity: Activity,
    private val scope: CoroutineScope,
) : GoogleAuthApi {

    private val credentialManager = CredentialManager.create(activity)

    private var signInJob: Job? = null

    override fun signIn(
        nonce: String,
        serverClientId: String,
        callback: (Result<GoogleSignInResult>) -> Unit,
    ) {
        if (signInJob?.isActive == true) {
            callback(
                Result.success(
                    result(GoogleSignInStatus.FAILURE, null, "Вход уже выполняется")
                )
            )

            return
        }

        signInJob = scope.launch {
            callback(Result.success(requestIdToken(nonce, serverClientId)))
        }
    }

    override fun signOut(callback: (Result<Unit>) -> Unit) {
        scope.launch {
            try {
                credentialManager.clearCredentialState(ClearCredentialStateRequest())
                callback(Result.success(Unit))
            } catch (e: Exception) {
                callback(Result.failure(FlutterError("sign_out_failed", e.message)))
            }
        }
    }

    private suspend fun requestIdToken(
        nonce: String,
        serverClientId: String,
    ): GoogleSignInResult = try {
        val option = GetSignInWithGoogleOption.Builder(serverClientId)
            .setNonce(nonce)
            .build()
        val request = GetCredentialRequest.Builder()
            .addCredentialOption(option)
            .build()
        val token = credentialManager
            .getCredential(activity, request)
            .extractIdToken()

        result(GoogleSignInStatus.SUCCESS, token, null)
    } catch (e: GetCredentialCancellationException) {
        result(GoogleSignInStatus.CANCELLED, null, null)
    } catch (e: NoCredentialException) {
        result(GoogleSignInStatus.NO_CREDENTIAL, null, e.message)
    } catch (e: Exception) {
        result(GoogleSignInStatus.FAILURE, null, e.message ?: e.javaClass.simpleName)
    }

    private fun result(
        status: GoogleSignInStatus,
        idToken: String?,
        errorMessage: String?,
    ) = GoogleSignInResult(status, idToken, errorMessage)

    private fun GetCredentialResponse.extractIdToken(): String {
        val credential = credential
        if (credential !is CustomCredential ||
            credential.type != GoogleIdTokenCredential.TYPE_GOOGLE_ID_TOKEN_CREDENTIAL
        ) {
            throw IllegalStateException("Unexpected credential: ${credential.type}")
        }

        return GoogleIdTokenCredential.createFrom(credential.data).idToken
    }
}
```

**Что здесь изменилось относительно старого кода и почему:**

- **`GetSignInWithGoogleOption` вместо `GetGoogleIdOption`.** Это брендированный флоу «Sign in with Google»: он всегда показывает пикер и не требует танца «попробовать с `filterByAuthorizedAccounts = true`, на `NoCredentialException` повторить с `false`». Ровно то, что нужно для явного нажатия кнопки. Заодно уходит `setAutoSelectEnabled(true)`, который мог залогинить молча.
- **`activity` вместо `MutableContextWrapper(context)`.** Credential Manager нужен Activity-контекст, чтобы поднять bottom sheet; обёртка только мешает его определить и никакой пользы не приносит.
- **Опция строится на каждый вызов.** В старом коде `googleIdOption` был `val`-полем с зашитым nonce — один nonce на всё время жизни активити.
- **`scope` приходит извне** (см. шаг 9), а не создаётся внутри.
- **Гард `signInJob`.** Два быстрых тапа дали бы два параллельных `getCredential`. `AuthBloc` прикрыт проверкой `isAuthorizing`, но нативный гард дешевле, чем разбираться потом.
- **`extractIdToken` приватный.** Старый `handleSign` был public без причины.

**Не тащить из старого файла:** `import android.content.ContentValues.TAG` и `android.util.Log` — мёртвые импорты. И отдельно: **никогда не логировать `idToken`**, это полноценный credential.

---

### Шаг 9. Упростить `MainActivity` — ✅ сделано

**Файл:** `android/app/src/main/kotlin/dev/urbaev/c4rds/MainActivity.kt`

**Что сделать:** свести к регистрации API:

```kotlin
class MainActivity : FlutterActivity() {

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        GoogleAuthApi.setUp(
            flutterEngine.dartExecutor.binaryMessenger,
            GoogleAuthApiImpl(activity = this, scope = lifecycleScope),
        )
    }
}
```

Для `lifecycleScope` добавить в `build.gradle.kts`:

```kotlin
implementation("androidx.lifecycle:lifecycle-runtime-ktx:<версия>")
```

**Зачем:** вся ручная обвязка — имя канала, строковые имена методов, разбор аргументов, коды ошибок — уходит в генерацию. Из ~40 строк остаётся 10.

`lifecycleScope` вместо своего `CoroutineScope(Dispatchers.Main + SupervisorJob())` — потому что старый скоуп никогда не отменялся: утечка, а если активити умрёт посреди флоу, колбэк прилетит в отсоединённый канал. `FlutterActivity` наследуется от обычного `Activity`, **но** реализует `LifecycleOwner` (проверено в исходниках эмбеддинга: `FlutterActivity extends Activity implements FlutterActivityAndFragmentDelegate.Host, LifecycleOwner`), поэтому расширение `lifecycleScope` доступно.

---

### Шаг 10. Удалить старый `GoogleAuthService.kt` — ✅ сделано

**Файл:** `android/app/src/main/kotlin/dev/urbaev/c4rds/GoogleAuthService.kt`

**Что сделать:** удалить целиком — его роль полностью занял `GoogleAuthApiImpl`.

**Зачем:** иначе останется мёртвый класс с нерабочей сериализацией, который кто-нибудь через полгода примет за актуальный.

---

## Фаза D. Dart

### Шаг 11. Завести типы ошибок — ✅ сделано

**Файл:** `lib/feature/auth/data/service/i_google_sign_in_service.dart`

**Что сделать:** добавить к существующему интерфейсу:

```dart
/// Пользователь закрыл пикер аккаунтов.
///
/// Не ошибка: экран должен просто вернуться в исходное состояние.
class GoogleSignInCancelled implements Exception {
  const GoogleSignInCancelled();
}

/// Вход не удался по технической причине.
class GoogleSignInFailure implements Exception {
  final String message;

  const GoogleSignInFailure(this.message);

  @override
  String toString() => 'GoogleSignInFailure: $message';
}
```

**Зачем:** отмену нужно отличать от сбоя выше по стеку, в блоке. Сейчас `AuthBloc._onSignInRequested` ловит `on Object` и рисует `UnknownApiException(message: error.toString())` — пользователь, закрывший пикер, увидит «PlatformException(...)».

`StubGoogleSignInService` в том же файле можно оставить: он понадобится для iOS в шаге 14.

---

### Шаг 12. Вынести `serverClientId` в конфиг — ✅ сделано

**Файл:** `lib/feature/auth/auth_config.dart`

```dart
abstract final class AuthConfig {
  static const googleServerClientId = '<Web client ID>';
}
```

**Решение:** значение зашито константой, без `--dart-define-from-file`. Осознанный
размен: окружение пока одно, а лишний файл, который надо не забыть подложить перед
запуском и прокинуть в IDE и в `make/build.mk`, — источник «у меня не собирается»
на ровном месте.

Значение взято из `karto4ki_backend/.env`, ключ `GOOGLE_JWT_AUDIENCE` — тот самый, что
бэкенд подставляет в `GoogleTokenVerifier.withAudience()`. Одно место правды на клиент
и сервер: разъедутся — вход упадёт с `401 auth.invalid_token`, и причина будет
неочевидной.

**Что это значит на практике:** ID попадает в git. Это допустимо — он не секрет,
уезжает в claim `aud` подписанного токена и виден в любом декомпиле. Секрет — client
secret, он остаётся на бэкенде.

**Когда придётся вернуться к dart-define:** появится второе окружение (stage-бэкенд
со своим Google-проектом) или прод с другим Web-клиентом. Тогда — `String.fromEnvironment`
и `--dart-define-from-file=env.json`. Осторожно: не подсовывать туда существующий `.env`,
он подключён как Makefile-переменные в `make/legacy.mk:1`, и dart-define втащит в бинарь
**все** его ключи. Нужен отдельный файл.

**Вариант на подумать (не обязательный):** отдавать clientId с бэкенда вместе с nonce —
`POST /auth/nonce` → `{nonce, clientId}`. Красиво тем, что клиент физически не может
разойтись с сервером по audience. Цена — правка API и лишняя связность.

---

### Шаг 13. Написать адаптер — ✅ сделано

**Файл:** `lib/feature/auth/data/service/google_sign_in_service.dart` (новый)

**Что сделать:**

```dart
/// Реализация [IGoogleSignInService] поверх нативного Credential Manager.
class GoogleSignInService implements IGoogleSignInService {
  final GoogleAuthApi _api;

  /// OAuth-клиент типа Web — его audience проверяет бэкенд.
  final String serverClientId;

  GoogleSignInService({
    required this.serverClientId,
    GoogleAuthApi? api,
  }) : _api = api ?? GoogleAuthApi();

  @override
  Future<String> idToken({required String nonce}) async {
    final GoogleSignInResult result;
    try {
      result = await _api.signIn(nonce, serverClientId);
    } on PlatformException catch (error) {
      // Сюда падает только необработанное исключение в нативе или обрыв
      // канала: ожидаемые исходы приезжают в статусе.
      throw GoogleSignInFailure(error.message ?? error.code);
    }

    switch (result.status) {
      case GoogleSignInStatus.success:
        final token = result.idToken;
        if (token == null) {
          throw const GoogleSignInFailure('Натив вернул пустой id-token');
        }

        return token;
      case GoogleSignInStatus.cancelled:
        throw const GoogleSignInCancelled();
      case GoogleSignInStatus.noCredential:
        throw const GoogleSignInFailure(
          'На устройстве нет доступного Google-аккаунта',
        );
      case GoogleSignInStatus.failure:
        throw GoogleSignInFailure(result.errorMessage ?? 'Неизвестная ошибка');
    }
  }

  @override
  Future<void> signOut() => _api.signOut();
}
```

**Зачем:** здесь и только здесь плоский результат Pigeon превращается в контракт `IGoogleSignInService`. `switch` по enum исчерпывающий — добавишь статус в схему, компилятор укажет на это место.

**Оба пути обработки нужны.** Enum закрывает ожидаемые исходы, но реальный краш в нативе всё равно вернётся через собственный error-канал Pigeon как `PlatformException` — от этого никуда не деться.

**Побочный выигрыш:** `GoogleAuthApi` инжектится в конструктор, так что сервис тестируется без платформы. На голом `MethodChannel` для этого пришлось бы подменять хендлер канала через `TestDefaultBinaryMessenger`.

---

### Шаг 14. Научить `AuthBloc` не ругаться на отмену — ✅ сделано

**Файл:** `lib/feature/auth/domain/bloc/auth_bloc.dart`

**Что сделать:** в `_onSignInRequested` добавить ветку **перед** `on Object`:

```dart
} on GoogleSignInCancelled {
  emit(const AuthState.unauthorized());

  return;
} on Object catch (error, stackTrace) {
```

**Зачем:** порядок `catch`-блоков в Dart значим — `on Object` перехватит всё, что стоит после него. Отмена должна тихо возвращать экран в исходное состояние, без баннера с ошибкой и без записи в `ErrorLogger`.

**Мимо кассы не пройти:** nonce на отмене не «сгорает» — сервер списывает его только при обмене в `/auth/google`, так что просто истечёт через 5 минут. Ретраить ничего не нужно.

---

### Шаг 15. Заменить стаб в DI — ✅ сделано

**Файл:** `lib/app/di/app_scope_register.dart` (строка 177)

**Что сделать:**

```dart
final googleSignInService = Platform.isAndroid
    ? GoogleSignInService(serverClientId: AuthConfig.googleServerClientId)
    : const StubGoogleSignInService();
```

**Зачем:** iOS-реализации пока нет, и без этой проверки на iOS полетит `MissingPluginException` вместо внятной заглушки «вход ещё не реализован».

**Мелочь:** `const googleSignInService` придётся сделать `final` — тип теперь вычисляется в рантайме. Проверить, что ниже по функции (`_Auth`, `_createAuthBloc`) это не ломает `const`-контексты.

---

## Фаза E. Проверка

### Шаг 16. Прогнать флоу

**Что проверить руками:**

1. **Успешный вход** на debug-сборке: `/auth/nonce` → пикер → токены сохранились, статус `authorized`, профиль подтянулся из `/me`.
2. **Отмена**: закрыть пикер свайпом → экран вернулся в `unauthorized`, баннера с ошибкой нет, в логгер ничего не ушло.
3. **Первый вход на чистом устройстве** (эмулятор с новым аккаунтом) — тот кейс, который ломал `filterByAuthorizedAccounts`.
4. **Двойной тап** по кнопке → второй запрос не открывает второй пикер.
5. **`signOut`** → следующий вход снова спрашивает аккаунт (то есть `clearCredentialState` реально сработал).
6. **Протухший nonce**: подождать >5 минут в пикере → должен сработать ретрай `AuthInvalidNonce` из `_signIn`, а не показаться ошибка.
7. **`make gen-all`** и `fvm flutter analyze` — чисто.

**Отдельно release-сборка:** `fvm flutter build apk --flavor dev --release` и проверить вход на ней. Credential Manager регулярно отваливается под R8 — `androidx.credentials` везёт свои consumer-правила, но `googleid` в некоторых конфигурациях требует keep-правил. Если в релизе вход падает, а в debug работает — смотреть в эту сторону.

---

### Шаг 17. Напомнить про серверную валидацию

**Не наша зона, но без этого схема не защищает ни от чего.** Бэкенд обязан проверять у ID-token:

- подпись по JWKS Google;
- `iss` ∈ {`accounts.google.com`, `https://accounts.google.com`};
- `aud` == Web Client ID из шага 2;
- `exp`;
- `nonce` == выданному, и что он одноразовый;
- `email_verified`, если email где-то используется.

И брать `sub` как стабильный идентификатор пользователя — **не email**, он у пользователя может измениться.

---

## Отложено: iOS

Pigeon уже сгенерирует `ios/Runner/GoogleAuthApi.g.swift` — протокол, который надо реализовать. Что потребуется отдельной задачей:

1. Добавить сгенерированный файл в target Runner через Xcode. Pigeon пишет файл на диск, но в `project.pbxproj` его не прописывает — это руками, один раз.
2. Реализовать протокол через `GoogleSignIn` SDK (или `AppAuth`), с передачей того же nonce.
3. Создать OAuth-клиент типа iOS в том же проекте Google Cloud, прописать URL scheme в `Info.plist`.
4. Снять `Platform.isAndroid` из шага 15.

---

## Чего в этом плане нет

- **Отказ от нативной реализации в пользу `google_sign_in` 7.x.** Плагин внутри использует тот самый Credential Manager, поддерживает nonce, отдаёт idToken и закрывает iOS «из коробки». Нативный путь дублирует это руками — взамен даёт полный контроль и независимость от чужих релизов. `IGoogleSignInService` абстрагирует выбор так, что переехать на плагин потом дёшево, если надоест поддерживать две платформы.
- **Юнит-тесты.** После шага 13 `GoogleSignInService` тестируется моком `GoogleAuthApi` без платформы — четыре теста на четыре статуса плюс один на `PlatformException`. Дёшево, стоит сделать, но это отдельная задача.
- **Silent sign-in при старте.** Сейчас вход только по кнопке. Автовход при живой Google-сессии — отдельная фича; технически это `GetGoogleIdOption` с `setFilterByAuthorizedAccounts(true)` и `setAutoSelectEnabled(true)`, то есть ровно то, что мы убрали из кнопочного флоу.

---

## Порядок работ

Фазы независимы ровно настолько, чтобы останавливаться между ними:

| Фаза | Шаги | Точка проверки |
|------|------|----------------|
| ~~A. Подготовка~~ | ~~1–4~~ | ✅ собирается, клиенты в Google Cloud заведены |
| ~~B. Pigeon~~ | ~~5–7~~ | ✅ три файла, `analyze` чистый |
| ~~C. Натив~~ | ~~8–10~~ | ✅ `fvm flutter build apk --flavor dev --debug` собирается |
| ~~D. Dart~~ | ~~11–15~~ | `analyze` чистый, кнопка входа доходит до пикера |
| E. Проверка | 16–17 | сценарии из шага 16 |

Внутри фаз шаги лучше делать по порядку: шаг 8 пишется против того, что сгенерировал шаг 7, а шаг 15 не скомпилируется без шагов 12 и 13.
