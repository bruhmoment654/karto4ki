import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizzerg/feature/question_stats/domain/service/i_stats_export_service.dart';
import 'package:quizzerg/feature/settings/domain/bloc/settings_bloc.dart';
import 'package:quizzerg/feature/settings/presentation/settings_view.dart';
import 'package:quizzerg/feature/test_execution/domain/bloc/attempt_history_bloc.dart';
import 'package:quizzerg/l10n/app_localizations_x.dart';
import 'package:quizzerg/persistence/settings/data/settings_dto.dart';
import 'package:quizzerg/uikit/dialogs/app_dialog.dart';
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
  StateStreamable<AttemptHistoryState> get attemptHistoryState =>
      context.read<AttemptHistoryBloc>();

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
  void onColorStyleChanged(AppColorStyle style) {
    context.read<SettingsBloc>().add(
      SettingsEvent.colorStyleChanged(style: style),
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

  /// Очистка необратима, а у истории нет синка — подтверждаем явно.
  @override
  Future<void> onAttemptHistoryClearPressed() async {
    final l10n = context.l10n;
    final bloc = context.read<AttemptHistoryBloc>();
    final isConfirmed = await AppDialog.confirm(
      context: context,
      title: l10n.settingsHistoryClearDialogTitle,
      message: l10n.settingsHistoryClearDialogMessage,
      cancelLabel: l10n.commonCancel,
      confirmLabel: l10n.settingsHistoryClearDialogConfirm,
    );

    if (isConfirmed ?? false) {
      bloc.add(const AttemptHistoryEvent.clearRequested());
    }
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

  void _onClearResult(BuildContext context, AttemptHistoryState state) {
    if (state is! AttemptHistoryState$Loaded) return;
    final result = state.clearResult?.value;
    if (result == null) return;

    final l10n = context.l10n;
    switch (result) {
      case AttemptHistoryClearResult.cleared:
        SnackController.show(context, l10n.settingsHistoryClearedSnack);
      case AttemptHistoryClearResult.failed:
        SnackController.showError(
          context,
          l10n.settingsHistoryClearFailedSnack,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<SettingsBloc, SettingsState>(
          listenWhen: (previous, current) =>
              previous.exportResult != current.exportResult,
          listener: _onExportResult,
        ),
        BlocListener<AttemptHistoryBloc, AttemptHistoryState>(
          listenWhen: (previous, current) =>
              current is AttemptHistoryState$Loaded &&
              (previous is! AttemptHistoryState$Loaded ||
                  previous.clearResult != current.clearResult),
          listener: _onClearResult,
        ),
      ],
      child: SettingsView(viewModel: this),
    );
  }
}

/// Контракт взаимодействия [SettingsScreen] и [SettingsView].
abstract interface class ISettingsViewModel {
  /// Настройки приложения, версия и статус экспорта.
  StateStreamable<SettingsState> get settingsState;

  /// Размер истории прохождений и статус её очистки.
  StateStreamable<AttemptHistoryState> get attemptHistoryState;

  void onAnimationDurationChanged(double value);
  void onAccentColorHueChanged(double value);
  void onThemeModeChanged(AppThemeMode mode);
  void onColorStyleChanged(AppColorStyle style);
  void onCardFontSizeChanged(double value);
  void onStatsExportPressed();
  void onAttemptHistoryClearPressed();
  void onBackPressed();
}
