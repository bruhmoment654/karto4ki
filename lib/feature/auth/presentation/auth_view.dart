import 'package:flutter/material.dart';

import 'package:quizzerg/core/bloc/state_streamable_builder.dart';
import 'package:quizzerg/feature/auth/domain/bloc/auth_bloc.dart';
import 'package:quizzerg/feature/auth/presentation/auth_screen.dart';
import 'package:quizzerg/feature/auth/presentation/widget/auth_lattice_background.dart';
import 'package:quizzerg/feature/auth/presentation/widget/auth_provider_button.dart';
import 'package:quizzerg/l10n/app_localizations_x.dart';
import 'package:quizzerg/uikit/scaffold/app_scaffold.dart';
import 'package:quizzerg/uikit/spacing/height.dart';

class AuthView extends StatelessWidget {
  final IAuthViewModel viewModel;

  const AuthView({required this.viewModel, super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      useSafeArea: false,
      body: Stack(
        children: [
          const Positioned.fill(child: AuthLatticeBackground()),
          SafeArea(
            child: Column(
              children: [
                _BackRow(onBackTap: viewModel.onBackTap),
                Expanded(
                  child: StateStreamableBuilder<AuthState>(
                    bloc: viewModel.authState,
                    builder: (context, state) => _Content(
                      viewModel: viewModel,
                      state: state,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BackRow extends StatelessWidget {
  final VoidCallback onBackTap;

  const _BackRow({required this.onBackTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: SizedBox(
        height: 56,
        child: Align(
          alignment: Alignment.centerLeft,
          child: IconButton(
            onPressed: onBackTap,
            icon: const Icon(Icons.arrow_back),
          ),
        ),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  final IAuthViewModel viewModel;
  final AuthState state;

  const _Content({required this.viewModel, required this.state});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;
    final isAuthorizing = state.isAuthorizing;

    return Padding(
      padding: const EdgeInsets.fromLTRB(28, 0, 28, 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.authTitle,
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const Height(10),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 320),
            child: Text(
              l10n.authSubtitle,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          const Height(30),
          AuthProviderButton(
            provider: AuthProvider.google,
            isLoading: isAuthorizing,
            onPressed: isAuthorizing ? null : viewModel.onSignInTap,
          ),
          const Height(18),
          _GuestButton(
            onPressed: isAuthorizing ? null : viewModel.onBackTap,
          ),
          const Height(14),
          Align(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 320),
              child: Text(
                l10n.authLegalNote,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GuestButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const _GuestButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: double.infinity,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(shape: const StadiumBorder()),
        child: Text(
          context.l10n.authContinueAsGuest,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
