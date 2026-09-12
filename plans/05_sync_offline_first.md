# 05. Клиентская интеграция с API + offline-first синхронизация

Статус: реализованы фазы 0–2 и 4–7 (ветка `feature/api-sync-offline-first`).
Не сделано: фаза 3 (авторизация) и фаза 8 (UI) — см. §17.
Документ самодостаточный — рассчитан на исполнителя, который бэкенд не читал.

> **Серверная часть готова** (проверено тестами, см. «Статус» в `backend/06_sync_lww_plan.md`):
> `serverTime`, `remaining` + `hasMore = remaining > 0`, `auth.invalid_nonce`, `avatarUrl`,
> `appliedItems`, `questionKey`, дедуп ответов `(cardId, answeredAt)`, компакция `/sync/changes`.

Смежные документы (репозиторий `karto4ki_backend`):
- `backend/api_client_guide.md` — контракт API с примерами;
- `backend/openapi.yaml` — формальная спека;
- `backend/06_sync_lww_plan.md` — серверные доработки под этот план;
- `backend/05_google_oauth_plan.md` — авторизация, фаза 9 = клиентская часть.

## 1. Цель и исходная точка

Приложение полностью локальное: в `pubspec.yaml` нет HTTP-клиента, нет сетевого слоя, нет
авторизации, id в Drift — `INTEGER AUTOINCREMENT`. Задача — реализовать **весь клиентский API-слой**
и включить offline-first синхронизацию так, чтобы приложение продолжало полноценно работать
без сети.

Объём: транспорт + авторизация + DTO/конвертеры на все эндпоинты + миграция локальной схемы на
uuid + движок синхронизации + обработка ошибок. UI-часть — минимальная (см. §14).

## 2. Ключевой принцип: где чтение, где запись

Приложение **не читает списки по REST и не пишет через CRUD-эндпоинты**. Источник данных для UI —
всегда локальная Drift-база; сервер и база сходятся через `/sync`.

| Область | Как работает |
|---|---|
| Чтение тестов, карточек, групп, статистики | только локальная БД |
| Запись тестов, карточек, групп | локальная БД → `POST /v1/sync/push` |
| Получение чужих/серверных изменений | `GET /v1/sync/changes` |
| Ответы на карточки | локальный журнал → `POST /v1/stats/answers/batch` |
| Профиль, авторизация, PAT-токены, health | напрямую по REST (локальной копии нет) |
| CRUD-эндпоинты `/tests`, `/cards`, `/groups` | реализуются в API-слое, но в UI-флоу **не используются**: нужны для отладки, интеграционных тестов и как фолбэк |

Это осознанный размен: одна кодовая ветка записи вместо двух (онлайн и офлайн), и никакой
рассинхронизации между ними.

## 3. Сетевой слой

Новые зависимости: `dio`, `flutter_secure_storage`, `uuid` (v7), `connectivity_plus`,
`google_sign_in` (или свой нативный мостик, см. §4).

`lib/network/` — общий транспорт:

- **Конфигурация окружений.** `dev` → `http://localhost:8080/v1` (для Android-эмулятора
  `http://10.0.2.2:8080/v1`), `prod` → `https://api.karto4ki.app/v1`. Всё, что ниже, — пути
  относительно base URL.
- **Таймауты:** connect 10 с, receive 30 с; для `/sync/changes` и `/import/csv` — 60 с.
- **Интерцепторы:**
  - `AuthInterceptor` — подставляет `Authorization: Bearer <access>`, кроме `/auth/*` и `/health`;
  - `RefreshInterceptor` — на 401 запускает refresh и повторяет запрос (см. §4, single-flight);
  - `RetryInterceptor` — повтор на сетевых ошибках и 5xx: 3 попытки, экспоненциальный бэкофф
    с джиттером. На 429 — тоже бэкофф (сервер `Retry-After` сейчас не шлёт). **Не повторять**
    неидемпотентные запросы: `POST /sync/push`, `POST /stats/answer(s)`, `POST /import/csv`,
    `POST /tokens` — их ретраит вызывающий код осознанно;
  - `LoggingInterceptor` — только в debug, без тел `/auth/*` (там токены).
- **Разбор ошибок RFC 7807.** Сервер отдаёт `application/problem+json`:
  `{ type, title, status, code, detail, instance, requestId, errors: [{field, message}] }`.
  Ориентироваться **на `code`**, не на `title`. Маппить в типизированные исключения:
  `AuthMissingToken`, `AuthInvalidToken`, `AuthForbidden`, `ValidationFailed(errors)`,
  `NotFound`, `Conflict`, `ImportTooLarge`, `ImportParseError`, `RateLimited`, `ServerError`,
  `NetworkUnavailable`. `requestId` тащить в логи — по нему ищут на бэке.
- **Пагинация.** Списочные эндпоинты возвращают `{ items, nextCursor, hasMore }`. Курсор
  **opaque** — не парсить. Хелпер, который тянет страницы, пока `hasMore == true`.
- **Лимиты сервера:** 120 запросов/мин, `/auth/*` — 20/мин, `/import/csv` — 10/мин. Для
  неавторизованных запросов ключ лимита — **IP**, поэтому на `/auth/*` он общий для всех клиентов
  за одним NAT. Один вход = 2 запроса, вход с автоповтором = 4; автоматических циклов повторного
  входа без действия пользователя не делать.

## 4. Авторизация

Бэкенд сам выпускает токены: Google нужен только чтобы подтвердить личность.

```
1. POST /v1/auth/nonce                        → { "nonce": "..." }
2. Google Sign-In с этим nonce                → Google ID-token
3. POST /v1/auth/google { "idToken": "..." }  → 201 { accessToken, refreshToken }
4. Bearer accessToken на все запросы
5. Истёк access → POST /v1/auth/refresh { "refresh": "..." } → новая пара
6. Выход → POST /v1/auth/logout { "refresh": "..." } → 204
```

- **Access** — JWT, TTL 1 час, отозвать досрочно нельзя. **Refresh** — opaque-строка, в БД хранится
  хеш, при каждом использовании **ротируется**.
- **Nonce — схема «А»: строку придумывает сервер.** Клиент кладёт полученную строку в
  `setNonce()` **дословно**. Никакого `sha256()` на клиенте (это схема «Б» из доков Apple/Firebase,
  она здесь ломает поиск на сервере и даёт 401 на каждый вход). Сейчас проверка nonce на бэке
  выключена флагом `GOOGLE_NONCE_REQUIRED=false`, но клиент должен слать nonce сразу — флаг
  включат после готовности клиента.
- **Android:** `google_sign_in` не даёт надёжно передать nonce (flutter/flutter#85439). Нужен свой
  мостик: Kotlin-код с `GetGoogleIdOption.setNonce(...)` через Credential Manager, `idToken`
  в Dart через `MethodChannel`. Перед реализацией проверить, не закрыт ли flutter/flutter#154205.
- **Хранение токенов** — `flutter_secure_storage` (Keychain / EncryptedSharedPreferences).
  В `SharedPreferences` токены не класть.

Три правила, без которых пользователя будет выкидывать из аккаунта:

1. **Single-flight refresh.** Несколько параллельных запросов получают 401 одновременно. Если
   каждый пойдёт обновляться, один и тот же refresh уйдёт на сервер дважды → сработает
   **reuse-detection** и сервер отзовёт **всю цепочку** токенов. Refresh должен быть один на
   процесс: `Completer`/мьютекс, остальные ждут его результат.
2. **Атомарная запись новой пары.** Ротация означает, что старый refresh мёртв сразу после
   успешного ответа. Сохранять новую пару в secure storage **до** того, как отпускать ожидающие
   запросы; старую пару удалять только после подтверждённой записи.
3. **Провал refresh = «сессия истекла»**, а не бесконечный ретрай: чистим токены, эмитим событие
   в `AuthBloc`, ведём на экран входа. Локальные данные при этом **не трогаем**.

Коды ответов, которые надо различать (проверено по коду бэкенда):

| Ситуация | Ответ | Поведение |
|---|---|---|
| refresh неизвестен / отозван / истёк | 401 `auth.invalid_token` | сессия истекла → перелогин |
| refresh уже ротирован (reuse) | **409 `resource.conflict`** | сессия истекла → перелогин, **не** «повторить позже» |
| nonce протух / уже использован / отсутствует в id-token | 401 `auth.invalid_nonce` | ровно один автоповтор: новый nonce → новый idToken → `/auth/google` |
| Google id-token не прошёл проверку | 401 `auth.invalid_token` | не ретраить: ошибка конфигурации audience/issuer |

При reuse сервер вызывает `suspendTokens(userId)` — отзывает **все** refresh-токены пользователя.
Поэтому single-flight refresh обязателен: два параллельных обновления с одним токеном гарантированно
разлогинивают пользователя.

Nonce живёт **5 минут** и одноразовый, кеш — в памяти процесса. Ошибка `auth.invalid_nonce` штатно
случается в трёх случаях: рестарт сервера, пользователь долго висел на гугловом экране, повторная
отправка того же nonce. Во всех трёх — один автоповтор.

**Access TTL — 1 час. Refresh — 90 дней, и каждая ротация отсчитывает срок заново**, поэтому при
регулярном использовании приложения сессия не истекает.

**Logout** желательно звать (иначе refresh живёт до 90 дней), но блокировать выход на нём нельзя:
пробуем с коротким таймаутом → в любом случае чистим локальные токены. Нет сети — разлогиниваемся
локально и забываем. Эндпоинт идемпотентен, на неизвестный токен отдаёт 401 — игнорировать.

## 5. Покрытие API

Реализуется весь контракт. Колонка «Использование» показывает, кто дёргает эндпоинт в реальном
флоу приложения.

### Auth — `/auth`

| Метод | Путь | Тело / Ответ | Использование |
|---|---|---|---|
| POST | `/auth/nonce` | → `{ nonce }` | вход |
| POST | `/auth/google` | `{ idToken }` → 201 `{ accessToken, refreshToken }` | вход |
| POST | `/auth/refresh` | `{ refresh }` → `{ accessToken, refreshToken }` | интерцептор |
| POST | `/auth/logout` | `{ refresh }` → 204 | выход |

`/auth/apple` **не существует** и в планах бэкенда его нет — кнопку «Войти через Apple» из дизайна
не реализуем. Риск для продукта: App Store Guidelines 4.8 могут потребовать её к iOS-релизу,
решение за владельцем.

### Профиль — `/me`

| Метод | Путь | Ответ | Использование |
|---|---|---|---|
| GET | `/me` | `UserDto { id, email, displayName?, avatarUrl?, plan, createdAt, updatedAt }` | экран профиля |
| PATCH | `/me` | `{ displayName }` → `UserDto` | редактирование профиля |
| DELETE | `/me` | 204 | удаление аккаунта (каскад на сервере) |

`avatarUrl` есть на сервере (`picture` из Google id-token, обновляется при каждом входе). Поле nullable, инициалы как
fallback остаются навсегда: у аккаунта без фото Google ничего не отдаёт, а сами URL периодически
меняются и могут отдать 404.

### Синхронизация — `/sync`

| Метод | Путь | Описание |
|---|---|---|
| GET | `/sync/changes?since&limit` | `{ serverTime, nextCursor, changes: [ChangeEvent], hasMore, remaining }`, limit 1..1000 (по умолчанию 500) |
| POST | `/sync/push` | `{ changes: [ChangeEvent] }` (≤1000) → `{ serverTime, applied, conflicts, appliedItems }` |

`ChangeEvent`: `{ entity, op, id, payload?, occurredAt }`, где `entity` ∈
`group | test | card | stats | test_session`, `op` ∈ `upsert | delete | restore`.

- Без `since` — полный bootstrap. Курсор хранить как строку, не парсить.
- `stats` — только на чтение; `test_session` сейчас всегда `payload: null` → игнорировать.
  Обе сущности **pull-only на MVP**: при push сервер их молча пропускает и даже в `applied` не
  считает. Счётчик «не отправлено» в UI = `pending`-строки по `group`/`test`/`card` плюс строки
  `answer_events_outbox` с `sent_at IS NULL`; локальные строки статистики в него не включать.
- Возможен `op: "upsert"` с `payload: null` (сущность успела удалиться) — не падать.
- `restore` — только `test` / `group`, payload не нужен; для `card` сервер отдаёт 400.
- Конфликты **per-change**: остальной батч применяется. `reason` ∈ `server_newer` (в `server`
  серверная копия) | `deleted` | `not_found`.
- `appliedItems` (есть на сервере) — снимки применённых сущностей, из них клиент берёт
  серверный `updatedAt`.
- **`serverTime`** (есть на сервере) — ISO-8601 UTC с миллисекундами, приходит **всегда**, даже когда
  изменений не было. Это **единственный** источник для плашки «последняя синхронизация»: сохранять
  в `sync_meta` при каждой успешной синхронизации. Локальные часы устройства и HTTP-заголовок `Date`
  для этого не использовать — `Date` имеет секундную точность и на проде его переписывает
  последний прокси/CDN. Per-user «времени последней синхронизации» на сервере нет и не будет.
- **`remaining`** (есть на сервере) — сколько событий осталось после отданного курсора. Годится на
  процентный прогресс bootstrap («загружено 1500 из 10000 изменений»); разбивки по типам сущностей
  нет, поэтому формулировка «Загружено 2 из 3 групп» из дизайна недостижима.

**Обязательные поля payload** — сервер требует их наличия, иначе 400 на весь батч:

| Сущность | Поля |
|---|---|
| `test` | `id`, `title`, `type` (только `"tinder"`), `questionCount`, `groupIds`, `createdAt`, `updatedAt`; `description` опционально |
| `card` | `id`, `testId`, `front`, `answers` (1..3, каждый 1..2000 символов), `createdAt`, `updatedAt` |
| `group` | `id`, `title`, `testCount`, `createdAt`, `updatedAt` |

`questionCount` и `testCount` сервер при применении игнорирует, но поля должны присутствовать.
`occurredAt` у самого `ChangeEvent` тоже обязателен. Все даты — ISO-8601 UTC.

### Статистика — `/stats`

| Метод | Путь | Использование |
|---|---|---|
| POST | `/stats/answers/batch` | **основной путь**: `{ events: [{ cardId, isCorrect, answeredAt }] }` (≤1000) → `{ applied, notFound, duplicates }` |
| POST | `/stats/answer` | одиночный ответ — не используем, батч покрывает |
| GET | `/stats?cursor&limit&sortBy&order` | не используем: статистика приезжает через `/sync/changes` |
| GET | `/stats/cards/{cardId}` | не используем (локальная БД) |
| GET | `/stats/export?format=question_stats\|cards` | не используем: экспорт уже реализован локально в `StatsExportService` |

`answeredAt` — время **самого ответа**, не время отправки: по паре `(cardId, answeredAt)` сервер
дедуплицирует повторные батчи (есть на сервере).

### Контент — `/tests`, `/cards`, `/groups`

Реализуются полностью в API-слое, в UI-флоу не используются (запись идёт через `/sync/push`).

| Метод | Путь |
|---|---|
| GET/POST | `/tests`, `/cards`, `/groups` |
| GET/PATCH/DELETE | `/tests/{id}`, `/cards/{id}`, `/groups/{id}` |
| POST | `/tests/{id}/restore`, `/tests/{id}/merge`, `/tests/{id}/move-cards`, `/groups/{id}/restore` |
| POST | `/cards/batch` — `{ testId, cards: [{front, answers}] }` → `{ created, skipped, ids }` |

Ограничения валидации (дублируем на клиенте, чтобы не ловить 400): `title` 1..200,
`description` ≤2000, `front` 1..2000, `answers` 1..3 элемента по 1..2000, `type` = `tinder`,
`limit` 1..200 (по умолчанию 50).

Особенность `PATCH /tests/{id}`: `"description": null` **очищает** описание, отсутствие ключа —
не трогает. При сериализации это надо различать явно.

### Импорт и токены

| Метод | Путь | Использование |
|---|---|---|
| POST | `/import/csv` (multipart: `file`, `targetTestId?`, `groupTitle?`, `testTitle?`, `delimiter?`, `dryRun?`) | не используем: локальный `CsvImportService` работает офлайн, результат уезжает через sync |
| GET/POST/DELETE | `/tokens`, `/tokens/{id}` | UI отложен (§14); эндпоинты реализовать. Только JWT, PAT их дёргать не может. `token` в ответе на создание виден **один раз** |

### Health

| Метод | Путь | Использование |
|---|---|---|
| GET | `/health`, `/health/ready` | опционально — диагностика в debug-меню |

## 6. Слои данных

- **DTO** — `json_serializable` с `checked: true`, зеркалят серверные DTO один в один.
- **Converter** — `Converter<Entity, Dto>`, как в остальном проекте.
- **Entity** — существующие freezed-модели; в них добавляются `id` типа `String` и поля состояния
  синхронизации не добавляются (они живут только в таблицах).
- **uuid v7** генерируется на клиенте (`uuid` ≥4.5): сервер принимает клиентские id в `/sync/push`,
  поэтому маппинг local↔remote не нужен.
- **`question_key`** считается локально по той же формуле, что на сервере:
  `lower(trim(front)) + '\x1F' + lower(trim(answers.join('|')))`.
- **Даты** — везде UTC, ISO-8601 с миллисекундами.

## 7. Миграция схемы Drift (8 → 9)

Самая рискованная часть: живая база у пользователей, `INTEGER AUTOINCREMENT` → uuid.

Целевые изменения в `tests`, `cards`, `test_groups`, `test_group_entries`:

```
id                TEXT NOT NULL PRIMARY KEY        -- uuid v7
base_payload      TEXT                             -- JSON последнего серверного снимка
server_updated_at DATETIME                         -- серверный updatedAt (см. §9, правило 2)
sync_state        TEXT NOT NULL DEFAULT 'pending'  -- 'synced' | 'pending'
deleted_at        DATETIME                         -- tombstone
```

Дополнительно:
- `cards`: `question` / `answer` → `front TEXT` + `answers TEXT` (JSON-массив, 1..3) + `question_key TEXT`;
- новая таблица `sync_meta(key TEXT PRIMARY KEY, value TEXT)` — курсор, время последнего pull;
- новая таблица `answer_events_outbox(id INTEGER PK, card_id TEXT, is_correct INTEGER,
  answered_at DATETIME, sent_at DATETIME)` — ответы это события, из состояния строк их не вывести;
- очередь операций для тестов/карточек/групп **не нужна**: push шлёт полный снимок, а операция
  выводится из состояния строки (§9).

Порядок (в `onUpgrade`, одной транзакцией):

1. Создать новые таблицы и колонки.
2. Для каждой строки сгенерировать uuid v7 **с таймстемпом из `created_at`** — сохраняется
   хронологический порядок id.
3. Переписать ссылки: `cards.test_id`, `test_group_entries.group_id` / `test_id`.
4. `sync_state = 'pending'` всем строкам — при первом sync всё уедет на сервер.
5. `active_sessions` хранит JSON `ActiveTestSessionDto` со старыми int-id внутри — строку удалить
   (это «продолжить последнюю сессию», потеря незначительная), отметить в release notes.
6. `question_stats` не трогаем: ключ — `question_key`, ссылок на id нет.

Перед мержем прогнать миграцию на реальном дампе с устройства, а не только на пустой базе.

## 8. Разрешение конфликтов: LWW по дате

Решение зафиксировано: **Last-Write-Wins по `updatedAt`**, без версий и без merge — приложение
рассчитано на одного человека с одним устройством.

Политика при `server_newer` — серверная версия применяется, локальная не выкидывается:

- карточка → локальный текст заливается **новой карточкой** с новым uuid (дубли на сервере
  чистятся дедупом по `(front, answers)`);
- тест / группа → применяется серверная версия, локальная правка в лог + snackbar
  «правка названия не применена».

Экранов разрешения конфликтов, диалогов выбора версий и diff-вью **не делаем**.

## 9. Четыре обязательных правила sync

1. **Compare-payload при `server_newer`.** Сравнить `server` с тем, что пушили: совпало — значит
   push реально прошёл, а ответ потерялся в сети. Принять серверную версию, пометить `synced`,
   конфликт не логировать. Без этого при флапающей сети будут постоянные ложные конфликты на
   собственных ретраях.
2. **Bump `updatedAt` при push:** `updatedAt = max(now, lastKnownServerUpdatedAt + 1ms)`. Без
   этого устройство с отстающими часами залипает навсегда — его правки вечно отвергаются как
   `server_newer`. Тот же эффект даёт секундная гранулярность Drift `DATETIME` (правка в
   `11:00:00.900` округляется до `11:00:00`).
3. **Не применять входящий pull-payload на строку с `sync_state = 'pending'`.** После push клиент
   получает свои же изменения обратно (в журнале сервера нет device id); если между push и pull
   пользователь успел ещё раз отредактировать запись, эхо молча затрёт правку.
4. **Удаление — только tombstone.** Физический `DELETE` означает, что нечего пушить как
   `op: delete`, и сущность вернётся с сервера при следующем pull. Строка живёт с `deleted_at`
   до подтверждённого push, потом удаляется физически.

## 10. Движок синхронизации

```dart
Future<void> sync() async {
  await _pull();          // сначала забираем серверные изменения
  await _pushDirty();     // потом отдаём свои
  await _pushAnswers();   // ответы на карточки — отдельным эндпоинтом
}

Future<void> _pull() async {
  var cursor = await _meta.cursor();
  SyncChangesDto page;
  do {
    page = await _repository.changes(since: cursor, limit: 500);
    for (final change in page.changes) {
      // Правило 3: локальная правка приоритетнее эха своего же push.
      if (await _isPending(change.entity, change.id)) continue;
      await _apply(change);
    }
    cursor = page.nextCursor ?? cursor;
    await _meta.setCursor(cursor);
  } while (page.hasMore);
}

Future<void> _pushDirty() async {
  // Операция выводится из состояния строки:
  //   deleted_at != null → delete, иначе → upsert.
  // Порядок батча: groups → tests → cards; удаления — в обратном порядке.
  final changes = await _collectDirty(limit: 1000);
  final result = await _repository.push(changes);

  for (final applied in result.appliedItems) {
    await _markSynced(applied);   // server_updated_at + base_payload + sync_state='synced'
  }
  for (final conflict in result.conflicts) {
    await _policy.handle(conflict);   // §8 и правило 1
  }
}
```

Когда запускать: после успешной авторизации на старте, при появлении сети (`connectivity_plus`),
при возврате в foreground и с дебаунсом после локальной мутации. Realtime на сервере нет —
только polling; фонового periodic-таймера на MVP не нужно.

**Первый вход при существующих локальных данных:** все строки помечены `pending`, поэтому
локальные тесты просто уедут на сервер и сольются с тем, что там есть. Отдельного экрана выбора
нет — показываем снекбар «Ваши локальные тесты добавлены в аккаунт».

## 11. Поведение по кодам ошибок

| Код | Поведение |
|---|---|
| нет сети | тихо: остаёмся офлайн, статус `offline`, ретрай по появлению сети |
| 401 `auth.invalid_token` | single-flight refresh → повтор запроса; провал → «сессия истекла» |
| 403 `auth.forbidden` | логировать; в мобилке штатно не должно случаться (это про PAT-скоупы) |
| 400 `validation.*` | баг клиента: логировать с `requestId`, изменение пометить как проблемное и не ретраить бесконечно |
| 404 `resource.not_found` | сущность удалена на сервере — применяем локальное удаление |
| 409 `resource.conflict` | на `/auth/refresh` — **терминальный разлогин** (reuse-detection, все токены отозваны); на остальных путях — нарушение инварианта (например merge в себя), показать сообщение |
| 401 `auth.invalid_nonce` | один автоповтор входа: новый nonce → новый idToken → `/auth/google` |
| 413 / 422 | только импорт CSV на сервере; локальным импортом не используется |
| 429 `rate_limit.exceeded` | экспоненциальный бэкофф с джиттером, статус `syncing` не сбрасывать |
| 5xx | 3 ретрая с бэкоффом, потом статус `failed` |

## 12. Структура модулей

```
lib/network/
  api/                       # dio, конфиг окружений, интерцепторы
  error/                     # RFC 7807 → типизированные исключения
  dto/                       # общие: PageResponse, ProblemDetails

lib/feature/auth/
  data/repository/auth_repository.dart     # /auth/*
  data/service/token_storage.dart          # flutter_secure_storage
  data/service/google_sign_in_service.dart # + MethodChannel для nonce на Android
  domain/bloc/auth_bloc.dart
  presentation/                            # экран входа

lib/feature/sync/
  data/database/sync.drift                 # sync_meta, answer_events_outbox
  data/dto/                                # change_event, sync_changes, sync_push_result, test/card/group
  data/converter/
  data/repository/sync_repository.dart     # /sync/*, /stats/answers/batch
  domain/entity/sync_status.dart           # freezed: idle | syncing | offline | failed
  domain/service/sync_engine.dart
  domain/service/conflict_policy.dart      # чистые функции
  domain/bloc/sync_bloc.dart
  presentation/sync_status_indicator.dart

lib/feature/profile/data/repository/profile_repository.dart   # /me
lib/feature/tokens/                                           # /tokens, UI отложен
```

Три точки касания с существующими фичами:

1. Флаги в `.drift`-файлах (`tests.drift`, `cards.drift`, `test_groups.drift`, `test_group_entries.drift`).
2. Существующие репозитории при мутации ставят `sync_state = 'pending'`, при удалении пишут
   `deleted_at` вместо `DELETE`. Затрагиваются: `TestsListRepository`, `TestDetailRepository`,
   `CardRepository`, `GroupsListRepository`, `GroupDetailRepository`, `TestMergeRepository`,
   `QuestionStatsRepository` (ответы → `answer_events_outbox`).
3. Индикатор статуса в UI + регистрация в `app_scope_register.dart`.

Чтобы модуль sync не импортировал все DAO, каждая фича предоставляет `SyncEntityAdapter`
(таблица, `toPayload`, `fromPayload`), регистрируемый в app scope.

## 13. Фазы

| # | Что | Блокеры |
|---|---|---|
| 0 | ✅ Миграция Drift 8 → 9: uuid v7, флаги, tombstone, `sync_meta`, `answer_events_outbox`; репозитории пишут `pending` / `deleted_at` | нет |
| 1 | ✅ DTO + конвертеры на весь контракт + `ConflictPolicy` и `question_key` с юнит-тестами | нет |
| 2 | ✅ Транспорт: `dio`, конфиг окружений, интерцепторы, разбор RFC 7807 | нет |
| 3 | ⬜ Авторизация: nonce → Google → токены, secure storage, single-flight refresh, экран входа | готовый OAuth на бэке |
| 4 | ✅ Pull-only: bootstrap без `since`, применение changes, курсор | фаза 3 |
| 5 | ✅ Push (dirty-scan) + обработка `conflicts` + правила 1–2 | фаза 4 |
| 6 | ✅ Ответы на карточки: `answer_events_outbox` → `/stats/answers/batch` с `sent_at` | нет |
| 7 | ✅ Остаток API: `/me`, CRUD-эндпоинты, `/tokens`, `/health` | фаза 2 |
| 8 | ⬜ UI: индикатор синхронизации, snackbar, «сессия истекла» | фаза 5 |

Фазы 0–2 не зависят ни от бэкенда, ни от дизайна — можно начинать сразу. Фаза 0 обязательна
первой и она же самая рискованная.

## 14. Тесты

- Чистые юнит-тесты без БД и сети: `ConflictPolicy`, `question_key`, разбор RFC 7807, бэкофф.
- Миграция 8 → 9 — тест на реальном дампе (`AppDatabase.forTesting` в проекте уже есть).
- Транспорт — с моком `dio`: 401 → refresh → повтор; два параллельных 401 → **один** refresh;
  429 → бэкофф; 5xx → 3 попытки.
- `SyncEngine` — интеграционные тесты с `AppDatabase.forTesting` и замоканным `SyncRepository`:
  эхо своего push не затирает pending-правку; повторный push после «потерянного» ответа не даёт
  конфликта; удаление уезжает как `delete` и потом чистится физически; bootstrap с несколькими
  страницами не теряет курсор.

## 15. Конвенции проекта

- Все команды через `fvm` (`fvm flutter`, `fvm dart`); кодогенерация — `make gen-all`.
- Entity — `freezed` (без `map` / `when`), DTO — `json_serializable` с `checked: true`,
  конвертеры от `Converter<Entity, Dto>`.
- Файлы `*.g.dart` / `*.freezed.dart` руками не редактировать.
- Комментарии и документация — на русском. Линтер `surf_lint_rules` + `surf_dcm_presets`,
  максимум 80 строк на функцию.
- В верстке не использовать билд-методы (`_buildCard()`) — только виджеты.

## 16. Задачи дизайну

Отдано в работу: экран авторизации (Google), обновление профиля.

Требуется дополнительно:

1. **Индикатор состояния синхронизации** — 4 состояния: `synced` («обновлено N минут назад»),
   `syncing`, `offline`, `failed` (тап → повторить). Основное место — блок в профиле (статус,
   время последней синхронизации, «синхронизировать сейчас»); в основной навигации — минимальный
   маркер. Важно: `offline` — нормальное рабочее состояние, не ошибка, без тревожных стилей.
2. **Первичная загрузка (bootstrap) после входа** — скелетон/прогресс для списка тестов и групп.
   Иначе на новом устройстве пользователь видит пустую библиотеку.
3. **«Сессия истекла»** — состояние при неудачном refresh с возвратом на экран входа.

Уточнить в задаче на профиль (бэкенд это поддерживает): редактирование `displayName`
(`PATCH /me`), удаление аккаунта (`DELETE /me`) с подтверждением, выход из аккаунта с
формулировкой про судьбу локальных данных.

Решено без дизайна: при первом входе локальные данные молча сливаются с серверными, показывается
снекбар «Ваши локальные тесты добавлены в аккаунт».

Осознанно отложено: корзина / восстановление удалённого, экран управления PAT-токенами, бейджи
«не синхронизировано» на сущностях, любые компоненты разрешения конфликтов.

## 17. Что осталось после первой итерации

Реализовано в ветке `feature/api-sync-offline-first`: миграция схемы на uuid, весь
API-слой, движок синхронизации, `SyncBloc`, тесты.

Отклонения от плана, о которых нужно знать:

- **DTO сущностей лежат в своих фичах**, а не в `lib/feature/sync/data/dto`
  (`tests_list/data/dto/test_dto.dart`, `test_detail/data/dto/card_dto.dart`,
  `groups_list/data/dto/group_dto.dart`, ...). В `sync/data/dto` — только сам
  протокол (`change_event`, `sync_changes`, `sync_push`). Иначе `tests_list`
  зависел бы от модуля синхронизации.
- **`server_updated_at` — колонка TEXT**, а не DATETIME: drift хранит DATETIME
  как unix-секунды, а LWW на сервере сравнивает время с точностью до
  миллисекунд (правило 2 из §9 иначе не работает).
- **`QuestionKeyNormalizer` переведён на серверную формулу**, а старые ключи
  `question_stats` пересчитаны в миграции 8 → 9. Без этого вся накопленная
  статистика осиротела бы.
- **Пул адаптеров вместо прямых DAO**: `SyncEntityAdapter` реализован в каждой
  фиче (`*/data/sync/*_sync_adapter.dart`) и собирается в `app_scope_register`.

Что нужно доделать вместе с авторизацией (фаза 3):

1. Реализовать `IAuthTokenProvider` (`lib/network/api/auth_token_provider.dart`)
   поверх secure storage и Google Sign-In. Сейчас в DI зарегистрирована заглушка
   `AnonymousAuthTokenProvider`: запросы уходят без `Authorization`.
   Single-flight refresh и обработка «сессия истекла» уже в транспорте
   (`RefreshInterceptor`), провайдеру остаётся только сам обмен токенов.
2. Запустить `SyncBloc`: сейчас его никто не стартует — `SyncEvent.started()`
   должен уйти после успешного входа. Подписка на сеть, дебаунс после мутации
   и повтор по кнопке уже внутри блока.
3. Дёргать `SyncEvent.localMutation()` из мест, где меняются данные, если нужен
   быстрый push (иначе синхронизация случится на следующем старте/сети).

Что нужно доделать вместе с UI (фаза 8):

- Индикатор `SyncStatus` (4 состояния), снекбар по `SyncState.conflicts`
  и экран «сессия истекла».
