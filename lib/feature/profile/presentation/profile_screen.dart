import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizzerg/app/navigation/app_router.dart';
import 'package:quizzerg/feature/auth/domain/bloc/auth_bloc.dart';
import 'package:quizzerg/feature/profile/domain/bloc/profile_bloc.dart';
import 'package:quizzerg/feature/profile/presentation/profile_view.dart';
import 'package:quizzerg/feature/sync/domain/bloc/sync_bloc.dart';
import 'package:quizzerg/feature/sync/presentation/sync_status_dialog.dart';
import 'package:quizzerg/l10n/app_localizations_x.dart';
import 'package:quizzerg/uikit/dialogs/app_dialog.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    implements IProfileViewModel {
  @override
  StateStreamable<ProfileState> get profileState => context.read<ProfileBloc>();

  @override
  StateStreamable<AuthState> get authState => context.read<AuthBloc>();

  @override
  StateStreamable<SyncState> get syncState => context.read<SyncBloc>();

  @override
  void onSyncTap() {
    context.read<SyncBloc>().add(const SyncEvent.requested());
  }

  @override
  void onSignInTap() {
    context.router.push(const AuthRoute());
  }

  /// Тот же диалог, что по индикатору в шапке главной: подробности о
  /// последней синхронизации и то же действие.
  @override
  void onSyncStatusTap() {
    showSyncStatusDialog(
      context: context,
      syncState: context.read<SyncBloc>(),
      onSignInTap: onSignInTap,
      onSyncTap: onSyncTap,
    );
  }

  /// Выход подтверждаем явно: пользователю важно знать, что локальные
  /// карточки останутся, а синхронизация остановится.
  @override
  Future<void> onSignOutTap() async {
    final l10n = context.l10n;
    final bloc = context.read<AuthBloc>();
    final isConfirmed = await AppDialog.confirm(
      context: context,
      title: l10n.profileSignOutDialogTitle,
      message: l10n.profileSignOutDialogMessage,
      cancelLabel: l10n.commonCancel,
      confirmLabel: l10n.profileSignOutDialogConfirm,
    );

    if (isConfirmed ?? false) bloc.add(const AuthEvent.signOutRequested());
  }

  @override
  void onStatsTap() {
    context.tabsRouter.setActiveIndex(1);
  }

  @override
  void onSettingsTap() {
    context.router.push(const SettingsRoute());
  }

  @override
  void onRetryTap() {
    context.read<ProfileBloc>().add(const ProfileEvent.started());
  }

  @override
  Widget build(BuildContext context) {
    return ProfileView(viewModel: this);
  }
}

/// Контракт взаимодействия [ProfileScreen] и [ProfileView].
abstract interface class IProfileViewModel {
  /// Сводка профиля: загрузка, данные, ошибка.
  StateStreamable<ProfileState> get profileState;

  /// Состояние авторизации: от него зависит первый блок, карточка
  /// синхронизации и строка «Выйти».
  StateStreamable<AuthState> get authState;

  /// Состояние синхронизации для карточки в профиле.
  StateStreamable<SyncState> get syncState;

  /// Запустить синхронизацию вручную.
  void onSyncTap();

  /// Тап по карточке синхронизации — открыть диалог состояния.
  void onSyncStatusTap();

  void onStatsTap();
  void onSettingsTap();
  void onRetryTap();
  void onSignInTap();
  Future<void> onSignOutTap();
}
