import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizzerg/feature/question_stats/domain/service/i_stats_export_service.dart';
import 'package:quizzerg/feature/settings/domain/bloc/settings_bloc.dart';
import 'package:quizzerg/feature/settings/presentation/settings_view.dart';
import 'package:quizzerg/persistence/settings/data/settings_dto.dart';
import 'package:quizzerg/uikit/snackbars/snack_controller.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    implements ISettingsViewModel {
  @override
  StateStreamable<SettingsState> get settingsState =>
      context.read<SettingsBloc>();

  @override
  void onCardFontSizeChanged(double value) {
    context.read<SettingsBloc>().add(
      SettingsEvent.cardFontSizeChanged(value: value),
    );
  }

  @override
  void onThemeModeChanged(AppThemeMode mode) {
    context.read<SettingsBloc>().add(
      SettingsEvent.themeModeChanged(mode: mode),
    );
  }

  @override
  void onAnimationDurationChanged(double value) {
    context.read<SettingsBloc>().add(
      SettingsEvent.animationDurationChanged(value: value),
    );
  }

  @override
  void onAccentColorHueChanged(double value) {
    context.read<SettingsBloc>().add(
      SettingsEvent.accentColorHueChanged(value: value),
    );
  }

  @override
  void onStatsExportPressed() {
    context.read<SettingsBloc>().add(
      const SettingsEvent.statsExportRequested(),
    );
  }

  @override
  void onBackPressed() {
    Navigator.of(context).pop();
  }

  void _onExportResult(BuildContext context, SettingsState state) {
    final result = state.exportResult?.value;
    if (result == null) return;

    final message = switch (result) {
      StatsExportSuccess(
        :final questionCount,
        :final cardCount,
        :final statsFilePath,
        :final cardsFilePath,
      ) =>
        'Экспорт: $questionCount вопросов, $cardCount карточек\n'
            '$statsFilePath\n$cardsFilePath',
      StatsExportCancelled() => 'Экспорт отменён',
      StatsExportEmpty() => 'Нет данных для экспорта',
      StatsExportFailure(:final message) => 'Ошибка экспорта: $message',
    };

    SnackController.show(
      context,
      message,
      duration: SnackController.longDuration,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingsBloc, SettingsState>(
      listenWhen: (previous, current) =>
          previous.exportResult != current.exportResult,
      listener: _onExportResult,
      child: SettingsView(viewModel: this),
    );
  }
}

/// Контракт взаимодействия [SettingsScreen] и [SettingsView].
abstract interface class ISettingsViewModel {
  /// Настройки приложения, версия и статус экспорта.
  StateStreamable<SettingsState> get settingsState;

  void onAnimationDurationChanged(double value);
  void onAccentColorHueChanged(double value);
  void onThemeModeChanged(AppThemeMode mode);
  void onCardFontSizeChanged(double value);
  void onStatsExportPressed();
  void onBackPressed();
}
