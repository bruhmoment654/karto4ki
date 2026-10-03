import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quizzerg/feature/sync/domain/bloc/sync_bloc.dart';
import 'package:quizzerg/feature/sync/presentation/sync_status_card.dart';
import 'package:quizzerg/l10n/app_localizations.dart';
import 'package:quizzerg/l10n/app_localizations_x.dart';
import 'package:quizzerg/uikit/motion/app_animated_switcher.dart';
import 'package:quizzerg/uikit/theme/app_theme.dart';

/// Смена состояния карточки синхронизации идёт переходом, а не скачком:
/// на полпути видны и прежний, и новый заголовок.
void main() {
  Widget app(SyncStatus status, {bool isAnimationDisabled = false}) =>
      MaterialApp(
        theme: AppTheme.dark(),
        locale: const Locale('ru', 'RU'),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(disableAnimations: isAnimationDisabled),
          child: child ?? const SizedBox.shrink(),
        ),
        home: Scaffold(
          body: Center(
            child: SyncStatusCardView(
              state: SyncState(status: status),
              onSignInTap: () {},
              onSyncTap: () {},
              onCardTap: () {},
              now: DateTime.utc(2026, 9, 2, 13, 30),
            ),
          ),
        ),
      );

  String titleOf(WidgetTester tester, SyncStatus status) {
    final l10n = tester.element(find.byType(SyncStatusCardView)).l10n;

    return switch (status) {
      SyncStatus$Offline() => l10n.syncTitleOffline,
      _ => l10n.syncTitleNotSynced,
    };
  }

  testWidgets('заголовки сменяются переходом', (tester) async {
    const from = SyncStatus.notSynced(pending: 4);
    const to = SyncStatus.offline();

    await tester.pumpWidget(app(from));
    final fromTitle = titleOf(tester, from);
    final toTitle = titleOf(tester, to);

    await tester.pumpWidget(app(to));
    await tester.pump(AppAnimatedSwitcher.duration ~/ 2);

    expect(find.text(fromTitle), findsOneWidget);
    expect(find.text(toTitle), findsOneWidget);

    await tester.pumpAndSettle();
    expect(find.text(fromTitle), findsNothing);
    expect(find.text(toTitle), findsOneWidget);
  });

  testWidgets('анимации отключены — состояние меняется сразу', (tester) async {
    const from = SyncStatus.notSynced(pending: 4);
    const to = SyncStatus.offline();

    await tester.pumpWidget(app(from, isAnimationDisabled: true));
    final fromTitle = titleOf(tester, from);

    await tester.pumpWidget(app(to, isAnimationDisabled: true));
    await tester.pump();

    expect(find.text(fromTitle), findsNothing);
  });
}
