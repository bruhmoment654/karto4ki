import 'package:flutter/material.dart';
import 'package:quizzerg/feature/sync/domain/bloc/sync_bloc.dart';
import 'package:quizzerg/feature/sync/presentation/sync_status_card.dart';
import 'package:quizzerg/feature/sync/presentation/sync_status_dialog.dart';
import 'package:quizzerg/network/error/api_exception.dart';
import 'package:zoloto/zoloto.dart';

/// «Сейчас» и момент синхронизации фиксированы: иначе подписи
/// («2 минуты назад», «сегодня в 13:22») меняли бы golden на границе минуты.
final _now = DateTime.utc(2026, 9, 2, 13, 30);
final _lastSyncedAt = _now.subtract(const Duration(minutes: 2));

SyncState _state(SyncStatus status) => SyncState(status: status);

Widget _card(SyncStatus status) => Padding(
      padding: const EdgeInsets.all(16),
      child: SyncStatusCardView(
        state: _state(status),
        onSignInTap: () {},
        onSyncTap: () {},
        now: _now,
      ),
    );

/// Диалог показывает абсолютное время в таймзоне устройства, поэтому
/// в golden'ах даты нет: подпись «сегодня в 13:22» зависела бы от TZ машины.
/// Форматирование покрыто юнит-тестом `sync_time_format_test.dart`.
Widget _dialog(SyncStatus status) => Center(
      child: SyncStatusDialogView(
        state: _state(status),
        onSignInTap: () {},
        onSyncTap: () {},
        onCloseTap: () {},
        now: _now,
      ),
    );

void main() {
  // Карточка профиля во всех состояниях, кроме syncing: спиннер —
  // бесконечная анимация, pumpAndSettle на ней зависает.
  Zoloto.zolotoTest(
    'sync_card_synced',
    widgetBuilder: (context, tester, testCase) =>
        _card(SyncStatus.synced(lastSyncedAt: _lastSyncedAt)),
    testHeight: const TestHeight$BasedOnContent(),
  );

  Zoloto.zolotoTest(
    'sync_card_not_synced',
    widgetBuilder: (context, tester, testCase) => _card(
      SyncStatus.notSynced(pending: 4, lastSyncedAt: _lastSyncedAt),
    ),
    testHeight: const TestHeight$BasedOnContent(),
  );

  Zoloto.zolotoTest(
    'sync_card_offline',
    widgetBuilder: (context, tester, testCase) => _card(
      SyncStatus.offline(pending: 2, lastSyncedAt: _lastSyncedAt),
    ),
    testHeight: const TestHeight$BasedOnContent(),
  );

  Zoloto.zolotoTest(
    'sync_card_expired',
    widgetBuilder: (context, tester, testCase) =>
        _card(SyncStatus.expired(lastSyncedAt: _lastSyncedAt)),
    testHeight: const TestHeight$BasedOnContent(),
  );

  Zoloto.zolotoTest(
    'sync_card_failed',
    widgetBuilder: (context, tester, testCase) => _card(
      SyncStatus.failed(
        error: const UnknownApiException(),
        pending: 1,
        lastSyncedAt: _lastSyncedAt,
      ),
    ),
    testHeight: const TestHeight$BasedOnContent(),
  );

  // Диалог по тапу на индикатор.
  Zoloto.zolotoTest(
    'sync_dialog_synced',
    widgetBuilder: (context, tester, testCase) =>
        _dialog(const SyncStatus.synced()),
  );

  Zoloto.zolotoTest(
    'sync_dialog_not_synced',
    widgetBuilder: (context, tester, testCase) =>
        _dialog(const SyncStatus.notSynced(pending: 4)),
  );

  Zoloto.zolotoTest(
    'sync_dialog_offline',
    widgetBuilder: (context, tester, testCase) =>
        _dialog(const SyncStatus.offline(pending: 2)),
  );

  Zoloto.zolotoTest(
    'sync_dialog_expired',
    widgetBuilder: (context, tester, testCase) =>
        _dialog(const SyncStatus.expired()),
  );
}
