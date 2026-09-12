# 06. Авторизация и UI синхронизации

Статус: **реализовано полностью**, ветка `feature/api-sync-offline-first`.
Вход через Google работает до заглушки `IGoogleSignInService` — нативную часть
делает [07_google_auth_pigeon.md](07_google_auth_pigeon.md).
Что разошлось с планом по ходу работы — см. «Статус реализации» ниже; расхождения
внесены и в текст фаз, чтобы документ оставался справочником, а не архивом.

Реализация трёх новых дизайнов из `design_handoff_material_you/`:

1. Профиль в двух состояниях — гость и авторизованный (`screens-profile.jsx`).
2. Экран авторизации, светлая и тёмная темы, OAuth-кнопки (`screens-auth.jsx`).
3. Иконка состояния синхронизации на главной + диалоги (`screens-sync.jsx`, `screens-home.jsx`).

Это фазы 3 и 8 из [05_sync_offline_first.md](05_sync_offline_first.md) — §17 того плана
описывает, что именно осталось после первой итерации.

---

## 0. Статус реализации

Сделаны все фазы A–F. `flutter analyze` чист по `lib` и `test`. Тестов проходит 175;
падают 5 golden'ов `test_detail` — они устарели после апгрейда Flutter и к этой задаче
отношения не имеют (проверено на чистом HEAD).

### Чем результат отличается от плана

| # | Что | Почему |
|---|---|---|
| 1 | Вместо `SyncNotifier` (обёртка над `SyncBloc`) — `ISyncSignalRepository` со стримом | Обёртка означала блок внутри блока: 6 блоков фич держали ссылку на `SyncBloc`. Репозиторий разворачивает зависимость — фичи пишут, синхронизация читает (B5) |
| 2 | Вместо `authBloc.stream.map(...)` в DI — `IAuthStatusRepository` | То же нарушение в другом месте: `SyncBloc` зависел от выхода `AuthBloc`. Теперь сессией владеет репозиторий, оба блока — его подписчики (A6, A7) |
| 3 | `AuthState.authorized({AuthUserEntity? user})` — `user` nullable, а не required | Токены могут быть, а кеша профиля нет (переустановка, чистка префов). Синхронизацию всё равно надо запускать: она зависит от токена, а не от `/me` |
| 4 | `SyncBloc` принимает `Stream<List<ConnectivityResult>>`, а не `Connectivity` | У `connectivity_plus` приватный конструктор, подменить в тесте нечем |
| 5 | `RefreshInterceptor` не разлогинивает на `NetworkUnavailable` — третья правка в транспорте сверх A5 | Без неё один потерянный пакет во время refresh стирал живую сессию: `_runRefresh` ловил любое исключение и звал `onSessionExpired()` |
| 6 | Тесты без `bloc_test` | В проекте нет ни `bloc_test`, ни `mocktail`; писали руками фейки, как в существующих тестах |
| 7 | `flutter_svg` 2.0.6 → 2.0.17 | Сгенерированный `assets.gen.dart` с `SvgGenImage` не компилируется со старой версией |
| 8 | Golden'ы экрана входа только в тёмной теме | Общий `test/flutter_test_config.dart` описывает только тёмные `ZolotoTestCase`. Добавление светлых заведёт по два новых golden'а каждому экрану проекта — решение уровня проекта, не этой задачи |

### Что вскрылось по ходу

- **Golden-тест нашёл переполнение** кнопки Google на 64px: шрифт Nexa шире дизайнового.
  Починено `Flexible` + `AutoSizeText`.
- **Гонка на старте.** `SyncBloc` подписывается на статус авторизации в обработчике `started`,
  то есть на микротаск позже конструктора. Без реплея текущего значения `authorized` мог
  прийти раньше подписки, и синхронизация не стартовала бы до следующей смены состояния.
  Лечится `BehaviorSubject` в обоих новых репозиториях.
- **`google_sign_in: 6.2.2` (A1) в коде не используется.** План 07 идёт через Credential
  Manager + Pigeon, которому этот пакет на Android не нужен. Зависимость под вопросом —
  решать вместе с планом 07.
- **Проект переехал на Flutter 3.41.4** (коммит `015f268`), из-за чего разъехались все
  golden'ы. Наши перегенерированы; 5 golden'ов `test_detail` остались устаревшими —
  их надо просмотреть глазами и перегенерировать отдельно.

---

## 1. Что уже есть и чего нет

Разделы 1–3 описывают исходную точку **на момент написания плана**, до реализации.

Есть:

- Транспорт целиком: `ApiClient`, интерцепторы `Auth` / `Refresh` (single-flight) / `Retry` /
  `ErrorMapping` / `Logging`, `PublicPaths` уже пропускает `/auth/*` без токена.
- `IAuthTokenProvider` — контракт источника токена ([auth_token_provider.dart](../lib/network/api/auth_token_provider.dart)),
  в DI зарегистрирована заглушка `AnonymousAuthTokenProvider`.
- `SyncEngine` (pull → push → ответы), `SyncBloc` с подпиской на сеть, дебаунсом и `lastSyncedAt`.
- `IProfileApiRepository` (`GET/PATCH/DELETE /me`) и `UserDto`.
- `sync_meta` — key-value таблица, курсор и время последней синхронизации.
- `AppPageHeader` с готовым слотом `action` — туда встанет иконка синхронизации.
- `ColorScheme` расширен ролями `success` / `warning` / `info` ([app_theme.dart:156](../lib/uikit/theme/app_theme.dart#L156)).

Нет:

- Всей фичи `auth`: репозитория `/auth/*`, хранилища токенов, блока состояния, экрана.
- Запуска синхронизации: `SyncBloc` создаётся в DI, но `SyncEvent.started()` никто не шлёт,
  и сам блок нигде не отдан в дерево виджетов.
- Состояний `not_synced` и `expired` в `SyncStatus` (сейчас `idle | syncing | offline | failed`).
- Кеша профиля: `/me` читается напрямую, показать имя офлайн нечем.
- Зависимостей `flutter_secure_storage` и `google_sign_in` в `pubspec.yaml`.

---

## 2. Решения и допущения

| # | Решение | Почему |
|---|---|---|
| 1 | Логику Google Sign-In пишет владелец проекта. Мы даём интерфейс `IGoogleSignInService` и заглушку, которая бросает `UnimplementedError` | Явная просьба; всё остальное (nonce → обмен → хранение → состояния) от неё не зависит |
| 2 | Токены — `flutter_secure_storage`; профиль (id, email, displayName) — `SharedPreferences` | Токены секрет, профиль нет. Читать профиль из secure storage на каждом кадре дорого |
| 3 | «Дата последней синхронизации с бэка» = поле `serverTime` из ответов `/sync/changes` и `/sync/push` | Бэкенд добавляет его коммитом C8 (§3). На заголовок `Date` завязываться нельзя: на проде его ставит последний хоп цепочки, а не наш Tomcat |
| 4 | Дополнительная колонка в БД не нужна | `sync_meta` — key-value, новые ключи добавляются без миграции схемы. Счётчик несинхронизированного считается запросами по `sync_state = 'pending'` |
| 5 | `SyncBloc` знает про авторизацию через `Stream`, а не через ссылку на `AuthBloc` | Тестируется без блока авторизации, DI остаётся линейным. **Уточнено при реализации:** источник стрима — `IAuthStatusRepository`, а не `authBloc.stream`; иначе блок зависел бы от выхода другого блока |
| 6 | Кнопки Apple на экране входа нет ни на одной платформе | На бэкенде есть только `POST /v1/auth/google`, эндпоинта `/auth/apple` не существует (см. §3). Кнопка была бы заведомо нерабочей |
| 7 | Состояние `failed` из дизайна не выкинуто, а отрисовано как `not_synced` (amber) с текстом «Не удалось синхронизировать» | В дизайне пять состояний, error-тон занят под протухший токен; отдельного визуала под сетевую ошибку нет, а состояние в коде уже есть |

---

## 3. Ответы бэкенда

Контракт сверен с `../karto4ki_backend` и подтверждён бэкенд-агентом. Четыре пункта
он берёт в работу — клиент пишем сразу под них, поля делаем nullable, чтобы собираться
и до их выкатки.

> **Обновление:** по статусу в [05_sync_offline_first.md](05_sync_offline_first.md) все четыре
> коммита на сервере выкачены. Поля в DTO всё равно оставлены nullable: против живого бэкенда
> клиент в этой итерации не проверялся, а деградация на старой сборке сервера бесплатна —
> без `serverTime` пишется локальное время, без `remaining` полоса неопределённая.

| Коммит | Что добавляет | Где нужно нам |
|---|---|---|
| C8 | `serverTime` (ISO-8601 UTC, мс) в ответы `/sync/changes` и `/sync/push`, всегда | B1 |
| C9 | Код ошибки `401 auth.invalid_nonce`, отдельно от `auth.invalid_token` | A4, A5 |
| C10 | `users.avatar_url` + `avatarUrl: String?` в `UserDto` | A2, D |
| C11 | `remaining` в `/sync/changes` — число событий с `id > nextCursor`; заодно `hasMore` переопределяется как `remaining > 0` | B1, E |

**Время последней синхронизации — `serverTime`, не заголовок `Date`.** На `Date` завязываться
нельзя: на проде его будет ставить последний хоп цепочки (nginx/Cloudflare генерируют свой),
семантика у него «время генерации ответа», плюс секундная точность. Per-user
«последней синхронизации» на сервере нет и не будет — момент знает сам клиент, ему не хватало
только серверных часов.

**`/auth/apple` нет и в планах бэкенда нет.** Кнопку не делаем — согласовано. Но бэкенд поднял
флаг в сторону продукта, и его надо донести до владельца **до сборки iOS-релиза**:
App Store Review Guidelines 4.8 требуют предлагать эквивалентный приватный способ входа,
если в приложении есть сторонний соц-логин. С одним только Google это может стать блокером
ревью. Объём работ на бэкенде примерно как `/auth/google` (другой JWKS, другой issuer).
Вынесено в раздел «Риски», а не в задачи этой итерации.

**Nonce.** TTL 5 минут, одноразовый, Caffeine в памяти одного инстанса; Redis не планируется
до горизонтального масштабирования. Флаг `GOOGLE_NONCE_REQUIRED` — env, включат, когда
клиент с nonce уедет в релиз; лишний claim сервер игнорирует, поэтому шлём nonce сразу.
После C9 протухший, использованный или отсутствующий nonce отличим по коду — сценариев два
и оба лечатся одним повтором: рестарт инстанса и «пользователь застрял на гугловом экране
дольше 5 минут».

**Токены.** Access — 1 час (`JWT_TTL_SECONDS:3600`). Refresh — 90 дней, ротация отсчитывает
срок заново, так что при регулярном использовании сессия не истекает. Провал refresh даёт
**два разных ответа, оба терминальные**:

| Ситуация | Ответ | Клиент |
|---|---|---|
| refresh неизвестен / отозван / истёк | `401 auth.invalid_token` | сессия истекла → перелогин |
| refresh уже ротирован (reuse) | `409 resource.conflict`, `Refresh token already used` | сессия истекла → перелогин |

Ретраить нельзя ни один. Single-flight refresh — **обязателен, а не желателен**: при reuse
сервер зовёт `suspendTokens(userId)` и отзывает *все* refresh-токены пользователя, включая
только что выданный. Два параллельных refresh с одним токеном = гарантированный разлогин
на всех устройствах.

**Rate limit.** `/auth/*` — 20 запросов/мин, плюс общий 120/мин, оба применяются. Для
неавторизованных ключ — `remoteAddr`, то есть по IP. Один вход = 2 запроса, вход с автоповтором
= 4, запас есть. Ограничение: никаких автоматических циклов повторного входа без действия
пользователя — на общем NAT (офис, публичный Wi-Fi) 20/мин съедаются коллективно.

**Прогресс bootstrap.** Разбивки по типам сущностей не будет: журнал отдаёт события, а не
сущности, а после компакции соответствие «событие ↔ сущность» ещё менее прямое. `remaining`
(C11) даёт честный процент по изменениям. Формулировку дизайна «Загружено 2 из 3 групп»
меняем на изменения (см. E).

C11 попутно чинит лишний запрос: сейчас `hasMore` считается как «прочитали ровно `limit`
событий», поэтому на границе (страница ровно в лимит, дальше пусто) клиент делает ещё один
пустой заход. После C11 `hasMore = remaining > 0`, и надёжный признак конца — `remaining == 0`
(см. B1).

**`stats` и `test_session` — pull-only на MVP**, в `push` уходят в `Outcome.SKIPPED`. Влияет
на счётчик «не отправлено» (B2).

**Контракт `/auth/*`** (`AuthController.kt`), совпал с планом:

| Метод | Путь | Тело → ответ |
|---|---|---|
| POST | `/v1/auth/nonce` | → **201** `{ nonce }` |
| POST | `/v1/auth/google` | `{ idToken }` → **201** `{ accessToken, refreshToken }` |
| POST | `/v1/auth/refresh` | `{ refresh }` → 200 `{ accessToken, refreshToken }` |
| POST | `/v1/auth/logout` | `{ refresh }` → 204, идемпотентен |

**`UserDto`**: `id`, `email`, `displayName?`, `plan`, `createdAt`, `updatedAt`, плюс
`avatarUrl?` после C10. `PATCH /me` принимает только `displayName`.

---

## Фаза A. Ядро авторизации

### A1. Зависимости

```yaml
flutter_secure_storage: ^9.2.4   # токены
google_sign_in: ^6.2.2           # ставим, реализацию пишет владелец
```

Для Android — `minSdkVersion 23` и `android:allowBackup="false"` (иначе бэкап уносит
зашифрованные префы с ключом от другого устройства).

### A2. Модель состояния

`lib/feature/auth/domain/entity/auth_user_entity.dart` — freezed:
`id`, `email`, `displayName?`, `plan`, `avatarUrl?`. Конвертер `UserDto → AuthUserEntity`
(`data/converter/auth_user_converter.dart`, наследник `Converter`).

`avatarUrl` появляется в `UserDto` после C10 (picture из Google). Поле **навсегда nullable**,
инициалы остаются постоянным фолбэком: у аккаунта без фото Google ничего не отдаст, а сами
URL'ы Google периодически меняются и могут отдать 404 (ответ бэкенда, пункт 5).

`lib/feature/auth/domain/bloc/auth_state.dart` — freezed sealed:

```dart
AuthState.unknown()                                  // читаем storage, ещё не знаем
AuthState.unauthorized({ApiException? error})        // гость; error — провал последнего входа
AuthState.authorizing()                              // идёт обмен nonce → idToken → токены
AuthState.authorized({AuthUserEntity? user})         // user nullable — см. §0, п.3
AuthState.expired({AuthUserEntity? user})            // refresh не удался, нужен перелогин
```

`expired` — отдельное состояние, а не разновидность `unauthorized`: именно по нему UI
показывает индикатор синхронизации и красный тон, тогда как гостю не показывает ничего.

### A3. События

```dart
AuthEvent.started()                     // подписаться на статус, поднять сессию
AuthEvent.signInRequested()             // кнопка Google
AuthEvent.signOutRequested()
AuthEvent.statusChanged(AuthStatus)     // статус приехал из IAuthStatusRepository
AuthEvent.userRefreshed()               // повторный GET /me
```

`statusChanged` — единственный вход для «токены появились / пропали / протухли».
Транспорт сообщает об этом репозиторию, а не блоку напрямую.

### A4. Данные

`lib/feature/auth/data/dto/` — `nonce_dto.dart`, `token_pair_dto.dart`
(`accessToken`, `refreshToken`), `google_sign_in_dto.dart` (`idToken`),
`refresh_request_dto.dart`. Все — `json_serializable`, `checked: true`.
Коды ответов: `/auth/nonce` и `/auth/google` отвечают **201**, `/auth/refresh` — 200,
`/auth/logout` — 204 (см. §3).

`lib/feature/auth/domain/repository/i_auth_api_repository.dart`:

```dart
Future<String> nonce();                       // POST /auth/nonce
Future<TokenPairDto> google(String idToken);  // POST /auth/google
Future<TokenPairDto> refresh(String refresh); // POST /auth/refresh
Future<void> logout(String refresh);          // POST /auth/logout
```

`data/storage/i_auth_token_storage.dart` + реализация на `flutter_secure_storage`:
`read()`, `write(pair)`, `clear()`. Запись пары — **атомарная**: после ротации старый refresh
мёртв сразу, потеря нового = разлогин (правило из §4 плана 05). Реализовано одним ключом
с JSON-строкой: у secure storage транзакций нет, а два ключа дали бы окно, в котором
access уже новый, а refresh ещё старый.

`data/storage/auth_user_storage.dart` на `SharedPreferences` — кеш профиля, чтобы имя и почта
рисовались офлайн и мгновенно на старте.

`data/service/i_google_sign_in_service.dart`:

```dart
/// Возвращает Google ID-token, подписанный переданным nonce.
/// Реализация — на стороне владельца проекта (Credential Manager на Android,
/// google_sign_in на iOS): nonce передаётся в setNonce() дословно, без sha256.
abstract interface class IGoogleSignInService {
  Future<String> idToken({required String nonce});
  Future<void> signOut();
}
```

Плюс `StubGoogleSignInService`, бросающий `UnimplementedError` — приложение собирается и
работает как гость, пока реализации нет.

Сценарий входа в `AuthBloc`: `POST /auth/nonce` → `idToken(nonce:)` → `POST /auth/google`.
Nonce одноразовый и живёт 5 минут в памяти одного инстанса (§3). Два штатных сценария его
потери — рестарт инстанса и «пользователь застрял на гугловом экране дольше 5 минут» —
лечатся одинаково: **ровно один** автоповтор всей цепочки с новым nonce. Разбор ответа
после C9:

| Код | Что значит | Действие |
|---|---|---|
| `401 auth.invalid_nonce` | nonce отсутствует, протух или уже использован | один повтор: новый nonce → новый idToken → `/auth/google` |
| `401 auth.invalid_token` | не прошёл сам Google id-token | **не ретраить** — это баг конфигурации (audience/issuer) или подделка, показываем ошибку |

Больше одного повтора не делаем ни при каких условиях: лимит `/auth/*` считается по IP,
и на общем NAT автоцикл съест 20 запросов/мин на всех (§3).

### A5. Новый код ошибки и защита refresh от ретраев

Две правки в транспорте, обе маленькие и обе обязательные:

1. **`ApiErrorCode.authInvalidNonce = 'auth.invalid_nonce'`** + ветка в `ApiErrorMapper`
   и новый `final class AuthInvalidNonce extends ApiException`. Без этого nonce-ошибка
   неотличима от невалидного Google-токена, и автоповтор из A4 либо не сработает, либо
   будет срабатывать там, где не должен.
2. **`/auth/refresh`, `/auth/google`, `/auth/logout` → в `RetryInterceptor.nonIdempotentPaths`.**
   Сейчас там только `/sync/push`, `/stats/*`, `/import/csv`, `/tokens`
   ([retry_interceptor.dart:15](../lib/network/api/interceptor/retry_interceptor.dart#L15)).
   `_isRetryable` повторяет любой POST при сетевой ошибке без ответа — а это ровно тот
   случай, когда запрос дошёл до сервера, а ответ потерялся. Повтор `/auth/refresh` в такой
   ситуации = второе использование того же refresh = reuse-detection = `suspendTokens(userId)`
   и разлогин на всех устройствах (§3). 409 и 401 `RetryInterceptor` не трогает, так что
   опасен именно сетевой сценарий.

### A6. Владелец сессии, `AuthTokenProvider` и разрыв цикла в DI

Сессией владеет **`IAuthStatusRepository`** (`domain/repository/`, реализация
`AuthStatusRepository` в `data/repository/`) — единственный источник правды о том,
авторизован ли пользователь. Он держит `IAuthTokenStorage` и отдаёт статус через
`BehaviorSubject<AuthStatus>.seeded(unknown)`:

```dart
enum AuthStatus { unknown, unauthorized, authorized, expired }

AuthStatus get status;
Stream<AuthStatus> get statusChanges;   // реплеит текущий — подписка не опаздывает
Future<AuthTokenPair?> tokens();
Future<void> restore();                 // прочитать хранилище на старте
Future<void> saveTokens(AuthTokenPair pair);
Future<void> clear();                   // выход из аккаунта
Future<void> markExpired();             // refresh провалился
```

`authorizing` в этом перечислении нет намеренно: «идёт вход» — состояние экрана,
в хранилище токенов оно не отражается и живёт в `AuthState`.

Два инварианта, заданных явно:

- **Одинаковый статус подряд не эмитится.** Иначе ротация токенов (`refresh` →
  `saveTokens`) выглядела бы как повторный вход, и синхронизация считала бы сессию новой.
- **`markExpired()` даёт `expired`, только если сессия была** (`status == authorized`),
  иначе `unauthorized`. У гостя сессия истечь не может.

`AuthTokenProvider implements IAuthTokenProvider` — живёт в `lib/feature/auth/data/`,
состояния не держит: и токены, и статус берёт из репозитория. Зависимость циклическая:
`Dio` требует провайдер, провайдер требует `ApiClient` для `/auth/refresh`. Разрываем
setter-инъекцией в `app_scope_register`:

```dart
const tokenStorage = AuthTokenStorage();
final statusRepository = AuthStatusRepository(storage: tokenStorage);
final tokenProvider = AuthTokenProvider(authStatus: statusRepository, errorLogger: errorLogger);
final dio = DioFactory.create(config: config, tokenProvider: tokenProvider, ...);
final client = ApiClient(dio);
tokenProvider.attach(AuthApiRepository(client: client));
```

Рекурсии не будет: `/auth/refresh` — публичный путь, `AuthInterceptor` и `RefreshInterceptor`
его пропускают.

`refreshTokens()` считает терминальными **оба** ответа бэкенда и в обоих возвращает `false`
(что для `RefreshInterceptor` уже означает «сессия истекла»):

- `401 auth.invalid_token` — refresh неизвестен, отозван или истёк;
- `409 resource.conflict` — refresh уже ротирован (reuse).

Второй важен отдельно: по общему правилу проекта 409 — это «конфликт, разберись и повтори»,
а здесь это терминальный разлогин. Никаких ретраев ни в том, ни в другом случае.

`onSessionExpired()` делегирует в `markExpired()` репозитория. Отдельного стрима
`sessionExpired` у провайдера нет: иначе про «сессия истекла» знали бы два источника —
стрим провайдера и состояние блока. `AuthBloc` узнаёт об этом из `statusChanges`
и переходит в `AuthState.expired`. Локальные данные **не трогаем** — ни БД, ни курсор.

**Выход из аккаунта** — best-effort, но не блокирующий: зовём `/auth/logout` с коротким
таймаутом (он отзывает refresh на сервере, иначе украденный токен живёт до 90 дней), и
**в любом исходе** чистим локальные токены и уходим на экран входа. Нет сети — разлогинились
локально и забыли, повторять потом не нужно: токен уже недоступен. Сам эндпоинт идемпотентен,
на неизвестный токен отдаёт 401 — эту ошибку тоже глотаем.

### A7. Регистрация в `app_scope_register`

Порядок в `createScope()` (собрано в приватные хелперы `_createAuth` / `_createSync`):

1. `tokenStorage` → `statusRepository` → `tokenProvider` → `dio` → `client` →
   `tokenProvider.attach(...)`;
2. `authBloc = AuthBloc(authStatus: statusRepository, ...)..add(const AuthEvent.started())`;
3. `syncSignalRepository`;
4. `syncBloc = SyncBloc(engine: ..., syncSignal: ..., connectivityChanges: Connectivity().onConnectivityChanged, authStatus: _syncAuthStatus(statusRepository))`.

`_syncAuthStatus` мапит `AuthStatus` → `SyncAuthStatus` и отбрасывает `unknown`. Источник —
репозиторий, а не блок: `SyncBloc` не должен зависеть от выхода `AuthBloc`. Реплей текущего
значения даёт сам `BehaviorSubject`, поэтому поздняя подписка ничего не теряет.

В `AppScope` / `IAppScope` добавляются: `authBloc`, `authApiRepository`, `authTokenStorage`,
`authStatusRepository`, `googleSignInService`, `syncSignalRepository`, `serverClock`.
`AnonymousAuthTokenProvider` из DI уходит (класс оставляем — он полезен в тестах
и golden-тестах).

Оба глобальных блока отдаём в дерево один раз, в [app_flow.dart](../lib/app/app_flow.dart),
над `App`:

```dart
Provider<IAppScope>(
  create: (_) => appScope,
  child: MultiBlocProvider(
    providers: [
      BlocProvider.value(value: appScope.authBloc),
      BlocProvider.value(value: appScope.syncBloc),
    ],
    child: const App(),
  ),
)
```

---

## Фаза B. Ядро синхронизации

### B1. Серверное время — поле `serverTime`

Бэкенд добавляет `serverTime` в оба ответа синхронизации (коммит C8, см. §3):

```jsonc
// GET /v1/sync/changes и POST /v1/sync/push
{ "serverTime": "2026-09-02T13:22:04.117Z", ... }
```

ISO-8601 UTC с миллисекундами, приходит всегда — были изменения или нет.

**Какую проблему решаем.** Сейчас `SyncEngine` пишет `DateTime.now()`, то есть время
устройства. Часы устройства произвольно врут: ручная установка, слетевший NTP, смена
таймзоны, дешёвый Android с дрейфом. Пользователь видит «синхронизировано 3 часа назад»
сразу после успешного прогона — или, что хуже, время в будущем. Дата, приходящая с бэка,
эту зависимость убирает.

#### Две подписи — два разных требования

Дизайн просит время в двух местах, и это не одно и то же:

| Где | Формат | Что нужно |
|---|---|---|
| Карточка и бейдж (`screens-sync.jsx:37`) | относительный — «Последний раз — 2 минуты назад» | **разница** между «сейчас» и моментом синхронизации |
| Диалог (`screens-sync.jsx:110`) | абсолютный — «Сегодня в 13:22» | **момент** синхронизации в таймзоне устройства |

Абсолютную подпись `serverTime` закрывает сам по себе: это точный UTC-инстант, рендерим
его в локальной таймзоне и получаем верный циферблат даже при сбитых часах.

Относительную — **не закрывает**. Если хранить `lastSyncedAt` в серверном времени, а дельту
считать как `DateTime.now() - lastSyncedAt`, мы вычитаем одни часы из других. Устройство,
спешащее на три часа, сразу после успешной синхронизации напишет «3 часа назад». Проблема
не исчезла, а переехала.

#### Значит, сдвиг часов всё-таки нужен

`ServerClock` из первой редакции плана остаётся — меняется только источник: не заголовок
`Date`, а `serverTime` из тела ответа (мс вместо секунд, наш Tomcat вместо последнего хопа).

```dart
/// Часы сервера: сдвиг между локальным и серверным временем.
class ServerClock {
  Duration _skew = Duration.zero;

  /// Зовётся из SyncEngine на каждый ответ с serverTime.
  void syncWith(DateTime serverTime) => _skew = serverTime.difference(DateTime.now().toUtc());

  /// «Сейчас» серверными часами.
  DateTime now() => DateTime.now().toUtc().add(_skew);

  bool get hasServerTime;
}
```

Обе подписи считаются в одной системе координат: относительная — как
`serverClock.now() - lastSyncedAt`, абсолютная — как `lastSyncedAt.toLocal()`.
Интерцептора нет: `serverTime` лежит в теле, его отдаёт `SyncEngine` после разбора ответа.

**Сдвиг переживает перезапуск.** После холодного старта, до первого ответа, сдвиг неоткуда
взять — поэтому храним его в `sync_meta` (`sync_clock_skew_ms`) и поднимаем на старте.
Иначе первая же отрисовка экрана после запуска покажет относительное время по кривым
локальным часам — то есть ровно тот баг, который мы чиним.

#### Признак конца pull

После C11 `hasMore = remaining > 0`, то есть оба поля согласованы, и надёжный признак конца
журнала — `remaining == 0`. В `_pull()` ([sync_engine.dart:117](../lib/feature/sync/domain/service/sync_engine.dart#L117))
добавляется выход по нему, когда поле пришло; при `remaining == null` (сборка до C11)
работает прежняя логика по `hasMore`. Существующие страховки — `maxPullPages` и выход при
не сдвинувшемся курсоре — остаются в любом случае: они защищают от зацикливания, а не от
лишнего запроса.

#### Правила записи

- `SyncChangesDto` и `SyncPushResultDto` получают `DateTime? serverTime`
  (`@UtcDateTimeConverter()`). Nullable — чтобы клиент собирался и работал со сборкой
  бэкенда до C8.
- `SyncEngine.sync()` на каждый ответ зовёт `serverClock.syncWith()`, а по успеху прогона
  пишет последнее увиденное `serverTime` в `SyncMetaKeys.lastSyncedAt`.
- Ответ без `serverTime` (сборка до C8) → пишем локальное время и
  `SyncMetaKeys.lastSyncedSource = local`. При `local` в диалоге формулировка мягче
  («примерно»), относительную подпись не показываем вовсе — врать точнее, чем врать точно.
- Никогда не синхронизировались → «Ещё не синхронизировано», без даты.

#### Чего `serverTime` не делает

- **Не курсор.** Соблазн «попросить changes since serverTime» надо давить: курсор — это
  `sync_events.id`, а не время. Время в `?since=` не уйдёт никогда.
- **Не участвует в LWW.** `server_updated_at` и разрешение конфликтов остаются на
  миллисекундном `updatedAt` из payload сущности.
- **Не значит «мы забрали всё».** Это момент генерации ответа, а не отметка
  «клиент догнал сервер»: между страницами pull на сервере могли появиться новые события.
  Подпись про полноту данных из него делать нельзя, только «когда последний раз общались».

### B2. Счётчик неотправленного

- `SyncEntityAdapter` получает `Future<int> countDirty()` — реализуется в **трёх** адаптерах
  (`group` / `test` / `card`) одним `count`-запросом по `sync_state = 'pending'`.
- `StatsSyncAdapter` в счётчик **не входит**: `stats` и `test_session` на MVP pull-only,
  в `push` уходят в `Outcome.SKIPPED` (ответ бэкенда, пункт 7). Локальные pending-строки
  статистики не уедут никогда, и счётчик врал бы всегда.
- `SyncDatabase.countUnsentAnswers()` — `count` по `sent_at IS NULL`. Вот ответы на карточки
  в счётчик входят: они уезжают через `/stats/answers/batch`.
- `SyncEngine.pendingCount()` — сумма. Дёргается после каждого прогона и по `localMutation`.

### B3. `SyncStatus` под дизайн

```dart
SyncStatus.disabled()                                   // гость: индикатора нет вообще
SyncStatus.synced({DateTime? lastSyncedAt})
SyncStatus.syncing({DateTime? lastSyncedAt, double? progress})   // progress из remaining, см. E
SyncStatus.notSynced({required int pending, DateTime? lastSyncedAt})
SyncStatus.offline({int pending = 0, DateTime? lastSyncedAt})
SyncStatus.expired({DateTime? lastSyncedAt})
SyncStatus.failed({required ApiException error, int pending = 0, DateTime? lastSyncedAt})
```

`idle` переименовывается в `synced` (иначе состояние «всё ок» и «есть неотправленное»
неразличимы). Правила перехода после прогона: успех и `pending == 0` → `synced`;
успех и `pending > 0` → `notSynced`; `NetworkUnavailable` → `offline`;
`AuthInvalidToken` / `AuthMissingToken` → `expired`; остальное → `failed`.

### B4. Зависимость от авторизации

`SyncBloc` получает в конструкторе `Stream<SyncAuthStatus>` (`none | active | expired`),
собранный в DI из `authBloc.stream`. Новые события:

```dart
SyncEvent.authChanged(SyncAuthStatus status)
```

Поведение:

- `none` → отменить дебаунс, эмитить `SyncStatus.disabled()`, ничего не запускать;
- `active` → `started` (подписка на сеть + первый прогон);
- `expired` → эмитить `SyncStatus.expired(lastSyncedAt)`, прогоны не запускать
  (иначе будем молотить 401 в цикле).

При выходе из аккаунта — `SyncEngine.resetCursor()` и `syncDatabase.clearMeta()`, чтобы
следующий вход не пытался догнать чужой курсор. Локальные тесты/карточки остаются.

### B5. Точки вызова `localMutation`

Сообщать о мутации нужно из мест правки: создание/переименование/удаление группы, теста,
карточки и завершение прохождения.

Тащить `SyncBloc` в каждый блок нельзя — это блок внутри блока. Поэтому в `AppScope` живёт
**`ISyncSignalRepository`**:

```dart
Stream<void> get localMutations;   // BehaviorSubject<void>, не засеян
void notifyLocalMutation();
```

Блоки фич его только дёргают и про синхронизацию ничего не знают; `SyncBloc` подписывается
в `started` и сам решает, запускать прогон (у гостя — не запускать). Издателей 15 вызовов
в шести блоках: `GroupsListBloc`, `TestsListBloc`, `GroupDetailBloc`, `TestDetailBloc`,
`TestMergeBloc`, `TinderTestBloc`.

Subject, а не голый broadcast-контроллер: подписка происходит на микротаск позже
конструктора, и правка, сделанная до неё (CSV-импорт сразу после запуска), потерялась бы.
Дубль сигнала безопасен — прогон идемпотентен и идёт с дебаунсом. Не засеян, чтобы
на свежем запуске без правок не было лишнего прогона.

Дебаунс вынесен в параметр конструктора `SyncBloc` (`mutationDebounce`, по умолчанию 3 с) —
иначе его пришлось бы ждать таймером в тестах.

---

## Фаза C. Экран авторизации

Роут — корневой, поверх табов: `AutoRoute(page: AuthRoute.page)` в `app_router.dart`.
Открывается из профиля (карточка гостя) и из диалога/баннера «Сессия истекла».

```
lib/feature/auth/presentation/
  auth_flow.dart                     # @RoutePage, BlocProvider.value(authBloc)
  auth_screen.dart                   # State + IAuthViewModel (стиль ProfileScreen)
  auth_view.dart                     # композиция
  widget/
    auth_lattice_background.dart     # фон: сетка + радиальная маска
    auth_provider_button.dart        # кнопка провайдера (Google/Apple)
    auth_brand_marks.dart            # GoogleGMark, AppleMark
```

### C1. Фон — отдельные виджеты, готовые к анимации

Дизайн: две решётки под ±45°, период 74px, полосы 2px `primary@55%` и 1.5px `primary@24%`,
поверх — радиальная маска `radial-gradient(110% 62% at 50% 6%, #000 30%, transparent 76%)`.

`auth_lattice_background.dart` содержит:

- `AuthLatticeBackground` — публичный виджет-обёртка без собственной анимации, только
  параметры (`period`, `opacity`, `color`, `maskCenter`, `maskRadius`);
- `_LatticePainter extends CustomPainter` — рисует обе решётки;
- маска — `ShaderMask(shaderCallback: RadialGradient(...).createShader(rect), blendMode: dstIn)`.

Экран **не** знает, как это устроено: в `auth_view.dart` он вставляется одной строкой в `Stack`.
Все параметры прокинуты наружу, чтобы над ними можно было навесить `AnimationController`
(например, `TweenAnimationBuilder` по `maskRadius` и `opacity` при входе), не трогая вёрстку.

### C2. Контент

Порядок: `IconButton(arrow_back)` в строке 56 → `Spacer` → заголовок `headlineMedium/w700`
«Войдите в аккаунт» → пояснение `bodyLarge/onSurfaceVariant`, `maxWidth 320` → кнопки
провайдеров (`gap 12`, высота 56, `StadiumBorder`) → «Продолжить без входа» (`TextButton`,
высота 48, `primary`) → сноска про условия использования (`bodySmall`, по центру).
Внешние отступы `0 28 8`.

Цвета кнопки Google берём из дизайна дословно (бренд-гайдлайн, не тема): тёмная тема —
фон `#131314`, текст `#E3E3E3`, обводка `#8E918F`; светлая — фон `#FFFFFF`, текст `#1F1F1F`,
обводка `#747775`.

Кнопки Apple нет: `/auth/apple` на бэкенде отсутствует (§3). `AuthProviderButton` при этом
делаем с параметром `provider`, чтобы добавление Apple свелось к одной ветке и ассету.
Вёрстка колонки кнопок от количества провайдеров не зависит.

Знак Google — SVG в `assets/icons/google_g.svg`, доступ через `Assets.icons.*`
(`flutter_gen` + `flutter_svg` уже настроены). Цвета у неё фиксированные, `ColorFilter`
не применяем.

### C3. Поведение

`authorizing` → на кнопках `CircularProgressIndicator`, обе задизейблены.
`unauthorized(error != null)` → `SnackBar` с текстом ошибки, экран остаётся.
`authorized` → `context.router.maybePop()`, поверх профиля показывается снекбар
«Ваши локальные тесты добавлены в аккаунт» (решение §16 плана 05).

---

## Фаза D. Профиль

Файлы: [profile_screen.dart](../lib/feature/profile/presentation/profile_screen.dart),
[profile_view.dart](../lib/feature/profile/presentation/profile_view.dart) +
новые виджеты в `profile/presentation/widget/`.

1. `ProfileScreen` дополнительно читает `AuthBloc` и `SyncBloc` — оборачиваем тело в
   `BlocBuilder<AuthBloc, AuthState>`; в `IProfileViewModel` добавляются
   `authState`, `syncStatus`, `onSignInTap`, `onSignOutTap`, `onSyncTap`, `onSyncActionTap`.
2. `_IdentityCard` разделяется на два виджета:
   - `ProfileAccountCard` — авторизованный: круг 60, `titleLarge/w600` имя,
     `bodyMedium/onSurfaceVariant` почта с эллипсисом. В круге — фото по `avatarUrl`
     через `CachedNetworkImage` (пакет уже в проекте), **инициалы как `placeholder`
     и как `errorWidget`**: `avatarUrl` может не прийти вовсе, а гугловые URL'ы
     периодически протухают в 404 (§3, пункт 5). До выкатки C10 поле всегда null и
     карточка рисует инициалы — отдельной ветки под «до/после» не нужно.
   - `ProfileSignInCard` — гость: `primaryContainer`-плашка, иконка `person`,
     «Войдите в аккаунт» / «Чтобы синхронизировать прогресс», шеврон. Тап → `AuthRoute`.
3. `ProfileSyncCard` — новая карточка (см. Фазу E, компонент общий), рисуется только при
   `authorized` или `expired`. У гостя блока нет.
4. В списке настроек строка «Выйти» (`colorScheme.error`) — только когда авторизован.
   Тап → `AppDialog.confirm` с явной формулировкой: локальные карточки останутся
   на устройстве, синхронизация остановится.
5. Бейдж на табе профиля в `home_view.dart`: `NavigationDestination.icon` заворачивается
   в `Badge`, когда `AuthState.expired` (в дизайне — `badges={profile: true}`).

---

## Фаза E. Главная: иконка и диалог

Компоненты кладём в `lib/feature/sync/presentation/` — их используют и главная, и профиль:

```
lib/feature/sync/presentation/
  sync_status_badge.dart      # круглая иконка 44 с точкой-attention
  sync_status_card.dart       # карточка для профиля
  sync_status_dialog.dart     # диалог по тапу
  sync_status_visual.dart     # чистая функция статус → иконка/цвет/тексты
```

`sync_status_visual.dart` — единственное место, где статус превращается в иконку, цвет и
подписи (аналог `syncMeta()` из дизайна). Чистая функция, покрывается юнит-тестом:

| Статус | Иконка | Цвет | Заголовок |
|---|---|---|---|
| `synced` | `cloud_done` | `success` | Синхронизировано |
| `syncing` | `progress_activity` (вращается) | `primary` | Синхронизация… |
| `notSynced` / `failed` | `cloud_upload` | `warning` | Не синхронизировано |
| `offline` | `cloud_off` | `onSurfaceVariant` | Офлайн |
| `expired` | `lock_person` | `error` | Сессия истекла |

Иконка на главной вставляется в готовый слот `AppPageHeader.action`
([app_page_header.dart](../lib/uikit/appbar/app_page_header.dart)) — вёрстку шапки менять
не нужно. Виджет сам подписан на `SyncBloc` и при `disabled` возвращает
`SizedBox.shrink()`, поэтому у гостя шапка выглядит как сегодня.

Диалог (`showDialog` поверх `AppDialog`): иконка + статус в заголовке, пояснение,
плашка «Последняя синхронизация» с временем из `lastSyncedAt` (форматируем относительно:
«сегодня в 13:22»), при `syncing` — `LinearProgressIndicator`, кнопки «Закрыть» +
действие (`Синхронизировать` / `Повторить` / `Войти`; при `syncing` действия нет).

Дополнительно из дизайна, что стоит взять сразу, потому что стоит дёшево:

- `LinearProgressIndicator` под шапкой главной при `syncing` (в дизайне — та же полоса);
- баннер «Нужно войти заново» под шапкой при `expired` (`ReauthBanner`) — постоянный,
  не исчезает сам; кнопки «Позже» и «Войти».

**Прогресс первичной загрузки.** Дизайн подписывает `syncing` как «Загружено 2 из 3 групп» —
такой цифры не будет: журнал отдаёт события, а не сущности, разбивки по типам нет и не
планируется. Вместо этого `/sync/changes` отдаёт `remaining` (C11) — число событий после
отданного курсора. Формулировку меняем на изменения: «Загружено 1500 из 10 000 изменений».

`remaining` = число событий с `id > nextCursor`, то есть строго за пределами уже отданного
(уточнено бэкендом). Прогресс считаем **только по нему**, не подмешивая свои счётчики:

```dart
// новые события во время bootstrap расширяют знаменатель, а не откатывают полосу
total ??= remaining;
if (remaining > previousRemaining) total += remaining - previousRemaining;
previousRemaining = remaining;

final done = total - remaining;
final value = total == 0 ? 1.0 : done / total;
shown = max(shown, value);   // полоса не двигается назад никогда
```

Соблазн взять `applied / (applied + remaining)` надо давить: `applied` — это компактированные
сущности, `remaining` — сырые события журнала, и после компакции окна одно в другое не
переводится. Полоса дёргалась бы и не доходила до конца. Обе величины в формуле выше —
серверные и в одних единицах.

**`remaining` реально растёт по ходу bootstrap** — это не теоретический случай. Источники:
наши же ответы на карточки (человек листает тест, пока идёт первичная загрузка, а
`/stats/answers/batch` пишет события), второй источник записи (Obsidian/MCP через PAT,
CSV-импорт, второе устройство), и наши собственные пуши, если движок когда-нибудь начнёт
push параллельно с pull. Плюс изоляция `READ COMMITTED` на сервере: `COUNT` видит состояние
на момент самого `COUNT`, а не на момент чтения страницы — идеального снапшота не бывает
в принципе.

Расширение знаменателя спасает от отката полосы в 0%, но не даёт строгой монотонности:
при выросшем `remaining` числитель стоит, знаменатель растёт, и доля чуть проседает
(0.20 → 0.18 при росте на 10%). Поэтому сверху `shown = max(shown, value)` — честность
знаменателя оставляем в модели, а глазу показываем неубывающую полосу. Дёшево и убирает
единственный видимый артефакт.

Поле nullable: пока C11 не выкачен, полоса неопределённая, подпись без цифр.

Скелетоны первичной загрузки уже есть (`GroupsListSkeleton`) — «карточки по одной со
счётчиком» из дизайна откладываем.

---

## Фаза F. Локализация

Все новые строки — через `/localize` в `app_ru.arb` / `app_en.arb`, группы `auth*` и `sync*`.
Заодно вынести хардкод «Мои группы» / «Группы тестов для обучения по карточкам» из
`groups_list_view.dart`, раз шапка всё равно правится.

---

## Тесты

Написаны без `bloc_test`/`mocktail` — их в проекте нет, фейки руками (`test/feature/auth/auth_fakes.dart`).
Провайдер и блок тестируются поверх **настоящего** `AuthStatusRepository` с фейковым
хранилищем: проверять надо их связку, а не мок.

`test/feature/auth/` — 21 тест:

- `auth_bloc_test.dart` — старт с пустым хранилищем → `unauthorized`; старт с токенами →
  `authorized` (профиль из кеша, затем обновление из `/me`); офлайн на старте сессию не роняет;
  `markExpired` из репозитория → `expired`; у гостя сессия истечь не может; вход сохраняет пару
  и профиль; `401 auth.invalid_nonce` → **ровно один** повтор цепочки; второй `invalid_nonce`
  подряд → ошибка пользователю; `401 auth.invalid_token` → повторов нет; заглушка Google даёт
  ошибку, а не падение; выход чистит токены и кеш в любом исходе.
- `auth_token_provider_test.dart` — успешный refresh пишет пару целиком; `401 auth.invalid_token`
  и `409 resource.conflict` оба дают `false` (терминальный разлогин); сетевая ошибка **не**
  терминальна и уходит наружу; `onSessionExpired` чистит токены и переводит статус в `expired`;
  успешный refresh статус **не** переключает.
- `presentation/auth_view_golden_test.dart` — экран входа, тёмная тема, pixel_4 + iphone_14.
  Состояние `authorizing` не покрыто: бесконечный спиннер вешает `pumpAndSettle`.

`test/network/api/interceptor/retry_interceptor_test.dart` — регрессия на A5.2:
POST `/auth/refresh` при сетевой ошибке **не повторяется** (цена бага — разлогин на всех
устройствах), идемпотентный GET при той же ошибке повторяется.

`test/feature/sync/`:

- `sync_engine_test.dart` — `serverTime` из ответа попадает в `sync_meta`; ответ без `serverTime`
  пишет локальное время и `lastSyncedSource = local`; сдвиг часов переживает перезапуск;
  выход из `_pull()` по `remaining == 0` без лишнего запроса; ответ без `remaining` завершает
  цикл по `hasMore`; не сдвинувшийся курсор при `hasMore` рвёт цикл; прогресс не убывает.
- `server_clock_test.dart` — сдвиг считается по `serverTime`; при часах, уведённых на три часа,
  относительная подпись сразу после синхронизации даёт «только что»; `restore` поднимает сдвиг.
- `sync_pull_progress_test.dart` — выросший между страницами `remaining` расширяет знаменатель,
  показанное значение не убывает; нулевой `remaining` — это 100%; пустой журнал не делит на ноль.
- `sync_bloc_test.dart` — `authChanged(none)` → `disabled` и прогонов нет; `expired` → прогонов
  нет; успешный прогон с `pending > 0` → `notSynced`; сигнал из `ISyncSignalRepository` запускает
  прогон; правка гостя прогон не запускает; правка до подписки не теряется; выход сбрасывает
  курсор и метаданные; статус, пришедший до подписки, не теряется.
- `sync_status_visual_test.dart` — таблица статус → визуал; относительная подпись только при
  серверном времени; прогресс подписывается изменениями.
- `sync_time_format_test.dart` — относительная и абсолютная подписи (сегодня / вчера / дата).
  Форматирование покрыто здесь, а не golden'ами: абсолютная подпись зависит от таймзоны машины.
- `presentation/sync_status_golden_test.dart` — карточка и диалог во всех состояниях,
  кроме `syncing` (бесконечный спиннер).

`test/feature/profile/presentation/` — `profile_cards_golden_test.dart` (карточка аккаунта,
она же без имени, приглашение войти) и обновлённый `profile_view_golden_test.dart`.

Чтобы всё это тестировалось без блоков, презентационные части вынесены в отдельные виджеты:
`SyncStatusCardView`, `SyncStatusDialogView`, `SyncStatusBadgeView`. Они принимают `SyncState`
и `now` (иначе golden менялся бы на границе минуты), а обёртки над ними подписаны на `SyncBloc`.

---

## Порядок работ

| # | Шаг | Зависит от | |
|---|---|---|---|
| 1 | A1–A2: зависимости, entity, состояния, события | — | ✅ |
| 2 | A4–A6: DTO, репозиторий `/auth/*`, хранилища, `IAuthStatusRepository`, код `auth.invalid_nonce`, ретраи, `AuthTokenProvider` | 1 | ✅ |
| 3 | A3+A7: `AuthBloc`, регистрация в DI, провайдеры в `app_flow` | 2 | ✅ |
| 4 | B1–B2: `serverTime` в DTO, `ServerClock`, `countDirty`, `pendingCount` | — | ✅ |
| 5 | B3–B4: новые `SyncStatus`, связка с авторизацией | 3, 4 | ✅ |
| 6 | E: `sync_status_visual` + badge + card + dialog | 5 | ✅ |
| 7 | D: профиль в двух состояниях, «Выйти», бейдж на табе | 3, 6 | ✅ |
| 8 | C: экран авторизации, фон, кнопки провайдеров | 3 | ✅ |
| 9 | B5: сигнал о правке из мутирующих блоков | 5 | ✅ |
| 10 | F + тесты + `make gen-all` + `/feedback-loop` | всё выше | ✅ |

Шаги 1–3 и 8 дали рабочий вход в аккаунт с заглушкой Google. Дальше подставляется реальный
`IGoogleSignInService` — это [план 07](07_google_auth_pigeon.md), и больше ничего править
не нужно: контракт сервиса не меняется.

---

## Риски

**Apple Sign-In и ревью App Store.** App Store Review Guidelines 4.8 требуют предлагать
эквивалентный приватный способ входа, если в приложении есть сторонний соц-логин. У нас
будет только Google, а `/auth/apple` на бэкенде нет и в планах бэкенда не значится — это
потенциальный блокер ревью, а не косметика. **Решение продуктовое, нужно принять до сборки
iOS-релиза**, не после. Объём бэкендной части — примерно как `/auth/google` (другой JWKS,
другой issuer, `sub` от Apple); на клиенте — ветка в `AuthProviderButton`, ассет и
`sign_in_with_apple`. Пока флаг поднят и записан, на текущую итерацию не влияет.

**Ошибка в refresh стоит дорого.** Любой повторный вызов `/auth/refresh` с тем же токеном
(параллельный refresh, ретрай на сетевой ошибке) отзывает всю цепочку токенов пользователя.
Отсюда два обязательных пункта A5 и A6, а не «желательных». При реализации к ним добавился
третий: `RefreshInterceptor` ловил **любое** исключение и звал `onSessionExpired()`, то есть
одна сетевая ошибка во время refresh стирала живую сессию. Теперь `NetworkUnavailable`
обрабатывается отдельно и токены не трогает.

**Golden'ы устарели после апгрейда Flutter.** Проект переехал на 3.41.4 (коммит `015f268`),
новый движок иначе растеризует текст и иконки. Наши golden'ы перегенерированы, 5 штук
в `test_detail` — нет: там 100% diff, надо смотреть глазами перед перезаписью.
Отдельно: `zoloto` умеет допуск (`ZolotoFileComparator`, 10%), но проект его не подключает —
в `flutter_test_config.dart` вызывается `runWithConfiguration`, а подмена компаратора живёт
в `Zoloto.setup`. Сравнение идёт с нулевым допуском. Само по себе это не причина текущих
расхождений, но запас прочности у golden-тестов нулевой.

**`google_sign_in: 6.2.2` висит неиспользованным.** Добавлен по A1 в расчёте на то, что
владелец напишет реализацию поверх него. План 07 идёт через Credential Manager + Pigeon,
где на Android этот пакет не нужен. Решить при работе над 07: оставить под iOS или убрать.

---

## Осознанно не делаем

- Sign in with Apple — см. «Риски» выше.
- Редактирование `displayName` и удаление аккаунта (`PATCH/DELETE /me`) — эндпоинты есть,
  дизайна нет.
- Экран управления PAT-токенами (`lib/feature/tokens`), корзину, разрешение конфликтов —
  как и было отложено в плане 05.
- Прогрессивную загрузку групп «по одной со счётчиком» — оставляем существующий скелетон.
- Golden'ы в светлой теме — требуют правки общего `flutter_test_config.dart` (см. §0).
- Нативную реализацию входа через Google — это [план 07](07_google_auth_pigeon.md).
