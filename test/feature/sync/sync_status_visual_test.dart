import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quizzerg/feature/sync/domain/bloc/sync_bloc.dart';
import 'package:quizzerg/feature/sync/domain/entity/sync_meta_keys.dart';
import 'package:quizzerg/feature/sync/domain/entity/sync_progress.dart';
import 'package:quizzerg/feature/sync/presentation/sync_status_visual.dart';
import 'package:quizzerg/l10n/app_localizations.dart';
import 'package:quizzerg/network/error/api_exception.dart';
import 'package:quizzerg/uikit/theme/palette/seed_palette.dart';

void main() {
  late AppLocalizations l10n;
  final colorScheme = ColorScheme.fromSeed(seedColor: const Color(0xFF6750A4));
  final appColors = const SeedPalette().appColors(colorScheme);
  final now = DateTime.utc(2026, 9, 2, 13, 30);

  SyncStatusVisual visualOf(
    SyncStatus status, {
    SyncTimeSource source = SyncTimeSource.server,
  }) =>
      syncStatusVisual(
        status: status,
        colorScheme: colorScheme,
        appColors: appColors,
        l10n: l10n,
        now: now,
        lastSyncedSource: source,
      );

  setUpAll(() async {
    l10n = await AppLocalizations.delegate.load(const Locale('ru'));
  });

  group('syncStatusVisual: таблица статус → визуал', () {
    test('synced — cloud_done, success, без attention', () {
      final visual = visualOf(const SyncStatus.synced());

      expect(visual.icon, Icons.cloud_done);
      expect(visual.color, appColors.success);
      expect(visual.needsAttention, isFalse);
      expect(visual.action, SyncStatusAction.sync);
    });

    test('syncing — спиннер и primary, действия нет', () {
      final visual = visualOf(const SyncStatus.syncing());

      expect(visual.isSpinner, isTrue);
      // Статичная замена спиннера там, где загрузку показывает лоадер кнопки.
      expect(visual.icon, Icons.cloud_sync);
      expect(visual.color, colorScheme.primary);
      expect(visual.action, isNull);
    });

    test('notSynced — cloud_upload, warning, attention', () {
      final visual = visualOf(const SyncStatus.notSynced(pending: 4));

      expect(visual.icon, Icons.cloud_upload);
      expect(visual.color, appColors.warning);
      expect(visual.needsAttention, isTrue);
      expect(visual.subtitle, contains('4'));
    });

    test('offline — нейтральный тон, это режим работы, а не ошибка', () {
      final visual = visualOf(const SyncStatus.offline());

      expect(visual.icon, Icons.cloud_off);
      expect(visual.isNeutral, isTrue);
      expect(visual.color, colorScheme.onSurfaceVariant);
      expect(visual.needsAttention, isFalse);
      expect(visual.action, SyncStatusAction.retry);
    });

    test('expired — единственное error-состояние', () {
      final visual = visualOf(const SyncStatus.expired());

      expect(visual.icon, Icons.lock_person);
      expect(visual.color, colorScheme.error);
      expect(visual.action, SyncStatusAction.signIn);
      expect(visual.needsAttention, isTrue);
    });

    test('failed — тон not_synced, но заголовок честный', () {
      // error-тон занят протухшим токеном, отдельного визуала под сетевую
      // ошибку в дизайне нет.
      final visual = visualOf(
        const SyncStatus.failed(error: UnknownApiException()),
      );

      expect(visual.color, appColors.warning);
      expect(visual.icon, Icons.cloud_upload);
      expect(visual.title, isNot(l10n.syncTitleNotSynced));
      expect(visual.action, SyncStatusAction.retry);
    });
  });

  group('syncStatusVisual: подпись времени', () {
    test('никогда не синхронизировались — без даты', () {
      expect(
        visualOf(const SyncStatus.synced()).subtitle,
        l10n.syncSubtitleNever,
      );
    });

    test('серверное время — относительная подпись', () {
      final visual = visualOf(
        SyncStatus.synced(lastSyncedAt: now.subtract(const Duration(minutes: 2))),
      );

      expect(visual.subtitle, contains('2 минуты назад'));
    });

    test('локальное время — относительной подписи нет', () {
      // Часы устройства могут врать; врать точнее, чем врать точно.
      final visual = visualOf(
        SyncStatus.synced(lastSyncedAt: now.subtract(const Duration(minutes: 2))),
        source: SyncTimeSource.local,
      );

      expect(visual.subtitle, l10n.syncSubtitleSyncedNoTime);
    });

    test('прогресс bootstrap подписывается изменениями', () {
      final visual = visualOf(
        const SyncStatus.syncing(
          progress: SyncProgress(value: 0.15, done: 1500, total: 10000),
        ),
      );

      // Числа форматируются группами (с неразрывным пробелом) — подпись
      // рассчитана на десятки тысяч изменений.
      final normalized = visual.subtitle.replaceAll('\u00A0', ' ');
      expect(normalized, contains('1 500'));
      expect(normalized, contains('10 000'));
    });

    test('без remaining подпись без цифр', () {
      expect(
        visualOf(const SyncStatus.syncing()).subtitle,
        l10n.syncSubtitleSyncingPlain,
      );
    });
  });
}
