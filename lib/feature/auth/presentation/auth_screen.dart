import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:quizzerg/feature/auth/domain/bloc/auth_bloc.dart';
import 'package:quizzerg/feature/auth/presentation/auth_view.dart';
import 'package:quizzerg/l10n/app_localizations_x.dart';
import 'package:quizzerg/network/error/api_exception.dart';
import 'package:quizzerg/uikit/snackbars/snack_controller.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> implements IAuthViewModel {
  @override
  StateStreamable<AuthState> get authState => context.read<AuthBloc>();

  @override
  void onSignInTap() {
    context.read<AuthBloc>().add(const AuthEvent.signInRequested());
  }

  @override
  void onBackTap() {
    _close();
  }

  /// Закрыть экран, если он ещё в стеке.
  void _close() {
    context.router.maybePop();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: _onStateChanged,
      child: AuthView(viewModel: this),
    );
  }

  void _onStateChanged(BuildContext context, AuthState state) {
    switch (state) {
      case AuthState$Authorized():
        // Снекбар показывает app-level ScaffoldMessenger, поэтому он
        // переживёт закрытие экрана и будет виден поверх профиля.
        SnackController.show(context, context.l10n.authWelcomeSnack);
        _close();
      case AuthState$Unauthorized(:final error) when error != null:
        _showError(error);
      case _:
        break;
    }
  }

  void _showError(ApiException error) {
    final message = error.message?.trim();

    SnackController.showError(
      context,
      message == null || message.isEmpty
          ? context.l10n.authErrorGeneric
          : message,
    );
  }
}

abstract interface class IAuthViewModel {
  /// Состояние авторизации: от него зависит индикатор на кнопке входа.
  StateStreamable<AuthState> get authState;

  void onSignInTap();

  void onBackTap();
}
