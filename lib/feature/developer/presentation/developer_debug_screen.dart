import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizzerg/feature/developer/domain/bloc/debug_bloc.dart';
import 'package:quizzerg/feature/developer/presentation/developer_debug_view.dart';
import 'package:quizzerg/uikit/snackbars/snack_controller.dart';

/// Презентационная логика дебаг-экрана.
class DeveloperDebugScreen extends StatefulWidget {
  const DeveloperDebugScreen({super.key});

  @override
  State<DeveloperDebugScreen> createState() => _DeveloperDebugScreenState();
}

class _DeveloperDebugScreenState extends State<DeveloperDebugScreen>
    implements IDeveloperDebugViewModel {
  late final TextEditingController _proxyController;

  @override
  void initState() {
    super.initState();
    _proxyController = TextEditingController(
      text: context.read<DebugBloc>().state.proxyUrl,
    );
  }

  @override
  void dispose() {
    _proxyController.dispose();
    super.dispose();
  }

  @override
  TextEditingController get proxyController => _proxyController;

  @override
  StateStreamable<DebugState> get debugState => context.read<DebugBloc>();

  @override
  void onApplyProxyPressed() {
    context.read<DebugBloc>().add(
      DebugEvent.proxyApplied(proxyUrl: _proxyController.text),
    );
  }

  @override
  void onClearProxyPressed() {
    _proxyController.clear();
    context.read<DebugBloc>().add(const DebugEvent.proxyCleared());
  }

  @override
  void onBackPressed() {
    context.router.maybePop();
  }

  void _onOutcome(BuildContext context, DebugState state) {
    final outcome = state.outcome?.value;
    if (outcome == null) return;

    final message = switch (outcome) {
      DebugProxyOutcome.applied => 'Прокси сохранён',
      DebugProxyOutcome.cleared => 'Прокси выключен',
      DebugProxyOutcome.failed => 'Не сохранилось: ${state.errorMessage}',
    };

    SnackController.show(context, message);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DebugBloc, DebugState>(
      listenWhen: (previous, current) => previous.outcome != current.outcome,
      listener: _onOutcome,
      child: DeveloperDebugView(viewModel: this),
    );
  }
}

/// Контракт взаимодействия [DeveloperDebugScreen] и [DeveloperDebugView].
abstract interface class IDeveloperDebugViewModel {
  /// Контроллер поля ввода адреса прокси.
  TextEditingController get proxyController;

  /// Состояние дебаг-экрана: окружение и сохранённый прокси.
  StateStreamable<DebugState> get debugState;

  /// Сохранить введённый адрес и применить его.
  void onApplyProxyPressed();

  /// Выключить прокси.
  void onClearProxyPressed();

  /// Назад.
  void onBackPressed();
}
