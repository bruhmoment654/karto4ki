import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quizzerg/feature/sync/domain/bloc/sync_bloc.dart';
import 'package:quizzerg/feature/sync/presentation/sync_status_card.dart';
import 'package:quizzerg/l10n/app_localizations.dart';
import 'package:quizzerg/uikit/theme/app_theme.dart';

/// Карточка синхронизации в профиле: тап по ней открывает диалог, а кнопка
/// действия остаётся отдельной целью и диалог не дёргает.
void main() {
  late int cardTaps;
  late int syncTaps;

  setUp(() {
    cardTaps = 0;
    syncTaps = 0;
  });

  Widget app(SyncStatus status) => MaterialApp(
        theme: AppTheme.dark(),
        locale: const Locale('ru', 'RU'),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: Center(
            child: SyncStatusCardView(
              state: SyncState(status: status),
              onSignInTap: () {},
              onSyncTap: () => syncTaps++,
              onCardTap: () => cardTaps++,
              now: DateTime.utc(2026, 9, 2, 13, 30),
            ),
          ),
        ),
      );

  testWidgets('тап по карточке дёргает onCardTap', (tester) async {
    await tester.pumpWidget(app(const SyncStatus.notSynced(pending: 4)));

    await tester.tap(find.byType(SyncStatusCardView));
    await tester.pumpAndSettle();

    expect(cardTaps, 1);
    expect(syncTaps, 0);
  });

  testWidgets('тап по кнопке действия не открывает диалог', (tester) async {
    await tester.pumpWidget(app(const SyncStatus.notSynced(pending: 4)));

    await tester.tap(find.byType(IconButton));
    await tester.pumpAndSettle();

    expect(syncTaps, 1);
    expect(cardTaps, 0);
  });
}
