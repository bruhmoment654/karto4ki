import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizzerg/app/di/app_scope.dart';
import 'package:quizzerg/core/feature/core/entity/result.dart';
import 'package:quizzerg/feature/developer/domain/repository/i_debug_repository.dart';
import 'package:quizzerg/feature/developer/presentation/developer_debug_view.dart';

/// Презентационная логика дебаг-экрана.
class DeveloperDebugScreen extends StatefulWidget {
  const DeveloperDebugScreen({super.key});

  @override
  State<DeveloperDebugScreen> createState() => _DeveloperDebugScreenState();
}

class _DeveloperDebugScreenState extends State<DeveloperDebugScreen>
    implements IDeveloperDebugViewModel {
  late final IDebugRepository _repository;
  late final TextEditingController _proxyController;

  String? _savedProxyUrl;

  @override
  void initState() {
    super.initState();
    _repository = context.read<IAppScope>().debugRepository;
    _savedProxyUrl = _repository.getProxyUrl();
    _proxyController = TextEditingController(text: _savedProxyUrl);
  }

  @override
  void dispose() {
    _proxyController.dispose();
    super.dispose();
  }

  @override
  TextEditingController get proxyController => _proxyController;

  @override
  String get baseUrl => _repository.baseUrl;

  @override
  String? get savedProxyUrl => _savedProxyUrl;

  @override
  void onApplyProxyPressed() {
    unawaited(_saveProxy(_proxyController.text, 'Прокси сохранён'));
  }

  @override
  void onClearProxyPressed() {
    _proxyController.clear();
    unawaited(_saveProxy(null, 'Прокси выключен'));
  }

  @override
  void onBackPressed() {
    context.router.maybePop();
  }

  Future<void> _saveProxy(String? value, String successMessage) async {
    final result = await _repository.saveProxyUrl(value);
    if (!mounted) return;

    switch (result) {
      case ResultOk():
        setState(() {
          _savedProxyUrl = _repository.getProxyUrl();
        });
        _showMessage(successMessage);
      case ResultFailed(:final error):
        _showMessage('Не сохранилось: $error');
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return DeveloperDebugView(viewModel: this);
  }
}

/// Контракт взаимодействия [DeveloperDebugScreen] и [DeveloperDebugView].
abstract interface class IDeveloperDebugViewModel {
  /// Контроллер поля ввода адреса прокси.
  TextEditingController get proxyController;

  /// Base URL текущего окружения.
  String get baseUrl;

  /// Сохранённый адрес прокси или `null`, если прокси выключен.
  String? get savedProxyUrl;

  /// Сохранить введённый адрес и применить его.
  void onApplyProxyPressed();

  /// Выключить прокси.
  void onClearProxyPressed();

  /// Назад.
  void onBackPressed();
}
