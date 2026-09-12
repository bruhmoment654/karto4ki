#!/usr/bin/env sh
#
# dep.sh — просмотр версий пакета на pub.dev и его ограничений на другие пакеты.
#
# СНАЧАЛА ПОПРОБУЙ ШТАТНЫЙ PUB — в большинстве случаев этот скрипт не нужен:
#
#   dart pub outdated
#       Колонка Resolvable — максимальная версия, до которой можно дойти, не
#       сломав остальной граф. Работает ДАЖЕ когда резолв падает целиком, так
#       что это первое, что стоит запускать при "version solving failed":
#       вместо ручного поиска пересечения он сразу называет рабочую версию.
#   dart pub upgrade --major-versions [пакет]
#       Поднять пины до Resolvable автоматически. Есть -n/--dry-run.
#       Ещё полезны --tighten и --unlock-transitive.
#   dart pub get -v
#       Ход работы солвера: какие версии перебирал и на чём отвалился.
#       Обычный (не verbose) текст ошибки почти всегда уже называет виновника.
#   dart pub deps --json  |  dart run pubviz
#       Граф уже отрезолвленного набора. pubviz рисует его вместе с
#       ограничениями версий (dot/mermaid/web-UI, флаг --flag-outdated).
#
# КОГДА ЭТОТ СКРИПТ ВСЁ-ТАКИ ПОЛЕЗЕН — то, чего pub не покажет:
#
#   1. Пакета ещё нет в зависимостях. Прикинуть, с какой версии его брать и во
#      что он упрётся, не трогая pubspec и не запуская резолв.
#   2. Планирование апгрейда SDK. pub outdated отвечает относительно текущего
#      установленного Dart SDK; здесь видны объявленные требования безотносительно
#      него — "что встанет, если я перееду на Dart 3.12".
#   3. История ограничений. С какой версии пакет перескочил на новый analyzer —
#      нужно, когда выбираешь, до какой версии откатиться, или когда сверяешь
#      несколько генераторов между собой и ищешь общее окно.
#   4. Разбор чужого или сломанного pubspec, когда проекта под рукой нет вообще.
#
# Использование:
#   sh dep.sh <пакет> [зависимость ...] [опции]
#
# Опции:
#   -n <N>   сколько последних версий показать (по умолчанию 10)
#   -a       показать все версии
#   -p       не скрывать пре-релизы (по умолчанию скрыты)
#   -h       эта справка
#
# Примеры:
#   sh dep.sh theme_tailor analyzer
#   sh dep.sh auto_route_generator lean_builder analyzer -n 15
#   sh dep.sh drift_flutter sqlite3 drift
#
# Колонки:
#   VERSION    версия пакета
#   PUBLISHED  дата публикации
#   SDK        требование к Dart SDK, объявленное самим пакетом (environment.sdk).
#              ВНИМАНИЕ: это только декларация, и она бывает неверной. Реальный
#              минимум — максимум по всему дереву зависимостей. Живой пример:
#              auto_route_generator 10.6.0 объявляет >=3.4.0, но тянет
#              lean_builder 1.2.0, которому нужен Dart >=3.12.
#   далее      по колонке на каждую запрошенную зависимость; "—" = пакет её не
#              тянет, "(dev)" = объявлена в dev_dependencies, "any" = без
#              ограничения, "sdk:flutter"/"git"/"hosted" = не-строковые источники
#
# Требования: curl, jq
# Коды выхода: 2 аргументы, 3 нет curl/jq, 4 сеть, 5 пакет не найден, 6 парсинг
#
set -eu

COUNT=10
ALL=0
PRERELEASE=0
PKG=""
DEPS=""

# Справка печатается из шапки этого же файла, чтобы дока и --help не разъезжались.
usage() {
  sed -n '2,/^[^#]/p' "$0" | sed -e '$d' -e 's/^# \{0,1\}//'
  exit "${1:-0}"
}

while [ $# -gt 0 ]; do
  case "$1" in
    -h|--help) usage 0 ;;
    -a) ALL=1 ;;
    -p) PRERELEASE=1 ;;
    -n)
      [ $# -ge 2 ] || { echo "dep.sh: -n требует число" >&2; exit 2; }
      COUNT="$2"
      shift
      ;;
    -*) echo "dep.sh: неизвестная опция $1" >&2; usage 2 ;;
    *)
      if [ -z "$PKG" ]; then PKG="$1"; else DEPS="$DEPS $1"; fi
      ;;
  esac
  shift
done

[ -n "$PKG" ] || usage 2

for bin in curl jq; do
  command -v "$bin" >/dev/null 2>&1 || { echo "dep.sh: не найден $bin" >&2; exit 3; }
done

BODY=$(curl -sS --max-time 30 "https://pub.dev/api/packages/$PKG") || {
  echo "dep.sh: не удалось получить данные с pub.dev" >&2
  exit 4
}

if ! printf '%s' "$BODY" | jq -e . >/dev/null 2>&1; then
  echo "dep.sh: pub.dev вернул не-JSON — вероятно, пакета $PKG не существует" >&2
  exit 5
fi

if ! printf '%s' "$BODY" | jq -e '.versions' >/dev/null 2>&1; then
  MSG=$(printf '%s' "$BODY" | jq -r '.error.message? // empty')
  echo "dep.sh: ${MSG:-пакет не найден: $PKG}" >&2
  exit 5
fi

OUT=$(printf '%s' "$BODY" | jq -r \
  --arg deps "$DEPS" \
  --argjson count "$COUNT" \
  --argjson all "$ALL" \
  --argjson prerelease "$PRERELEASE" '
  def render($c):
    if $c == null then "—"
    elif ($c | type) == "object" then
      (if $c.sdk then "sdk:" + $c.sdk
       elif $c.git then "git"
       else ($c.version // "hosted") end)
    elif $c == "" then "any"
    else ($c | tostring) end;

  ($deps | split(" ") | map(select(length > 0))) as $names
  | [ .versions[]
      | select($prerelease == 1 or (.version | test("-") | not)) ] as $vs
  | ($vs | length) as $total
  | (if $all == 1 then $vs else ($vs | .[-$count:]) end) as $shown
  | (["VERSION", "PUBLISHED", "SDK"] + $names | join("\t")),
    ($shown[]
      | .pubspec as $p
      | [ .version,
          (.published | split("T")[0]),
          render($p.environment.sdk // null)
        ]
        + [ $names[] as $n
            | if ($p.dependencies // {})[$n] != null then render($p.dependencies[$n])
              elif ($p.dev_dependencies // {})[$n] != null then render($p.dev_dependencies[$n]) + " (dev)"
              else "—" end ]
      | join("\t")),
    "показано \($shown | length) из \($total) версий" +
      (if $prerelease == 1 then ", включая пре-релизы" else ", пре-релизы скрыты (см. -p)" end)
') || exit 6

printf 'пакет: %s\n\n' "$PKG"
printf '%s\n' "$OUT" | sed '$d' | column -t -s "$(printf '\t')"
printf '\n%s\n' "$(printf '%s\n' "$OUT" | tail -n 1)"
