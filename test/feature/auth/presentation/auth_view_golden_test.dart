import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizzerg/feature/auth/domain/bloc/auth_bloc.dart';
import 'package:quizzerg/feature/auth/presentation/auth_screen.dart';
import 'package:quizzerg/feature/auth/presentation/auth_view.dart';
import 'package:quizzerg/network/error/api_exception.dart';
import 'package:zoloto/zoloto.dart';

import '../../../util/fake_state_streamable.dart';

class _MockViewModel implements IAuthViewModel {
  _MockViewModel(AuthState state) : authState = FakeStateStreamable(state);

  @override
  final StateStreamable<AuthState> authState;

  @override
  void onSignInTap() {}

  @override
  void onBackTap() {}
}

void main() {
  // Гость открыл экран входа.
  Zoloto.zolotoTest(
    'auth_unauthorized',
    widgetBuilder: (context, tester, testCase) => AuthView(
      viewModel: _MockViewModel(const AuthState.unauthorized()),
    ),
  );

  // Предыдущая попытка входа провалилась: экран остаётся, ошибка уходит
  // в снекбар, поэтому вёрстка та же — проверяем, что она не разъезжается.
  Zoloto.zolotoTest(
    'auth_error',
    widgetBuilder: (context, tester, testCase) => AuthView(
      viewModel: _MockViewModel(
        const AuthState.unauthorized(
          error: AuthInvalidToken(code: 'auth.invalid_token', statusCode: 401),
        ),
      ),
    ),
  );

  // Состояние authorizing не покрываем: на кнопке бесконечный спиннер,
  // pumpAndSettle на нём зависает (см. .claude/ZOLOTO-CUSTOM-PUMP-ISSUE.md).
}
