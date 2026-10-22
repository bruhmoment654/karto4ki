import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:quizzerg/app/navigation/app_router.dart';
import 'package:quizzerg/core/services/csv_import_service.dart';
import 'package:quizzerg/core/utils/answer_parser.dart';
import 'package:quizzerg/feature/main/domain/entity/card_entity.dart';
import 'package:quizzerg/feature/test_detail/domain/bloc/csv_import_bloc.dart';
import 'package:quizzerg/feature/test_detail/domain/bloc/test_detail_bloc.dart';
import 'package:quizzerg/feature/test_detail/presentation/csv_import_dialog.dart';
import 'package:quizzerg/feature/test_detail/presentation/test_detail_view.dart';
import 'package:quizzerg/feature/test_detail/presentation/test_settings_dialog.dart';
import 'package:quizzerg/feature/tests_list/domain/entity/test_type.dart';
import 'package:quizzerg/l10n/app_localizations_x.dart';
import 'package:quizzerg/uikit/dialogs/app_dialog.dart';
import 'package:quizzerg/uikit/fields/karto4ki_text_field.dart';
import 'package:quizzerg/uikit/snackbars/deferred_removal.dart';
import 'package:quizzerg/uikit/snackbars/snack_controller.dart';
import 'package:quizzerg/uikit/spacing/height.dart';

/// Test detail screen.
///
/// Contains logic for displaying test info, managing cards.
class TestDetailScreen extends StatefulWidget {
  final bool mixup;
  final int mixupMin;
  final int mixupMax;
  final String? groupId;

  /// Сразу после загрузки открыть импорт карточек.
  final bool openImport;

  const TestDetailScreen({
    this.mixup = false,
    this.mixupMin = 1,
    this.mixupMax = 5,
    this.groupId,
    this.openImport = false,
    super.key,
  });

  @override
  State<TestDetailScreen> createState() => _TestDetailScreenState();
}

class _TestDetailScreenState extends State<TestDetailScreen>
    implements ITestDetailViewModel {
  /// Как показывать карточку в прохождении. Ни на что на этом экране не
  /// влияет — уходит параметром в маршрут теста.
  bool _swapSides = false;
  int _answerIndex = 0;

  /// Импорт по [TestDetailScreen.openImport] открывается один раз.
  bool _isImportOpened = false;

  final _cardRemoval = DeferredRemoval();

  @override
  ValueListenable<Set<String>> get deletedCardIds => _cardRemoval.pending;

  @override
  void dispose() {
    _cardRemoval.dispose();
    super.dispose();
  }

  @override
  StateStreamable<TestDetailState> get testDetailState =>
      context.read<TestDetailBloc>();

  @override
  StateStreamable<CsvImportState> get csvImportState =>
      context.read<CsvImportBloc>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CsvImportBloc, CsvImportState>(
          listenWhen: (previous, current) => previous.result != current.result,
          listener: _onCsvImportResult,
        ),
        if (widget.openImport)
          BlocListener<TestDetailBloc, TestDetailState>(
            listenWhen: (_, current) =>
                !_isImportOpened && current is TestDetailState$Loaded,
            listener: (_, __) {
              _isImportOpened = true;
              _showCsvImportDialog();
            },
          ),
      ],
      child: TestDetailView(viewModel: this),
    );
  }

  @override
  void onBackPressed() {
    Navigator.of(context).pop();
  }


  @override
  void onAddCardPressed() {
    _showAddCardDialog();
  }

  @override
  void onCardTapped(CardEntity card) {
    _showEditCardDialog(card);
  }

  @override
  void onCardDeletePressed(CardEntity card) {
    final bloc = context.read<TestDetailBloc>();
    _cardRemoval.schedule(
      context,
      id: card.id,
      message: context.l10n.testDetailCardDeletedSnack,
      undoLabel: context.l10n.commonUndo,
      commit: () => bloc.add(TestDetailEvent.cardDeleted(cardId: card.id)),
    );
  }

  @override
  void onEditTestPressed() {
    final state = context.read<TestDetailBloc>().state;
    if (state is TestDetailState$Loaded) {
      _showEditTestDialog(state.test.title, state.test.description);
    }
  }

  void _showAddCardDialog() {
    final frontController = TextEditingController();
    final backController = TextEditingController();

    showDialog<void>(
      context: context,
      builder: (dialogContext) => AppDialog(
        title: Text(
          dialogContext.l10n.testDetailNewCardTitle,
          style: Theme.of(
            dialogContext,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Karto4kiTextField(
              controller: frontController,
              labelText: dialogContext.l10n.testDetailCardFrontLabel,
              hintText: dialogContext.l10n.testDetailCardFrontHint,
              autofocus: true,
              maxLines: 2,
            ),
            const Height(16),
            Karto4kiTextField(
              controller: backController,
              labelText: dialogContext.l10n.testDetailCardBackLabel,
              hintText: dialogContext.l10n.testDetailCardBackHint,
              maxLines: 2,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(dialogContext.l10n.commonCancel),
          ),
          TextButton(
            onPressed: () {
              final front = frontController.text.trim();
              final back = backController.text.trim();
              if (front.isNotEmpty && back.isNotEmpty) {
                context.read<TestDetailBloc>().add(
                  TestDetailEvent.cardAdded(front: front, back: back),
                );
                Navigator.of(dialogContext).pop();
              }
            },
            child: Text(dialogContext.l10n.commonCreate),
          ),
        ],
      ),
    );
  }

  void _showEditCardDialog(CardEntity card) {
    final frontController = TextEditingController(text: card.front);
    final backController = TextEditingController(text: card.formattedBack);

    showDialog<void>(
      context: context,
      builder: (dialogContext) => AppDialog(
        title: Text(
          dialogContext.l10n.testDetailEditCardTitle,
          style: Theme.of(
            dialogContext,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Karto4kiTextField(
              controller: frontController,
              labelText: dialogContext.l10n.testDetailCardFrontLabel,
              autofocus: true,
              maxLines: 2,
            ),
            const Height(16),
            Karto4kiTextField(
              controller: backController,
              labelText: dialogContext.l10n.testDetailCardBackLabel,
              maxLines: 2,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(dialogContext.l10n.commonCancel),
          ),
          TextButton(
            onPressed: () {
              final front = frontController.text.trim();
              final back = backController.text.trim();
              if (front.isNotEmpty && back.isNotEmpty) {
                final updatedCard = CardEntity(
                  id: card.id,
                  testId: card.testId,
                  front: front,
                  answers: AnswerParser.parse(back),
                  createdAt: card.createdAt,
                  updatedAt: DateTime.now(),
                );
                context.read<TestDetailBloc>().add(
                  TestDetailEvent.cardUpdated(card: updatedCard),
                );
                Navigator.of(dialogContext).pop();
              }
            },
            child: Text(dialogContext.l10n.commonSave),
          ),
        ],
      ),
    );
  }

  void _showEditTestDialog(String currentTitle, String? currentDescription) {
    final titleController = TextEditingController(text: currentTitle);
    final descriptionController = TextEditingController(
      text: currentDescription ?? '',
    );

    showDialog<void>(
      context: context,
      builder: (dialogContext) => AppDialog(
        title: Text(
          dialogContext.l10n.testDetailEditTestTitle,
          style: Theme.of(
            dialogContext,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Karto4kiTextField(
              controller: titleController,
              labelText: dialogContext.l10n.testDetailTestTitleLabel,
              autofocus: true,
            ),
            const Height(16),
            Karto4kiTextField(
              controller: descriptionController,
              labelText: dialogContext.l10n.testDetailTestDescriptionLabel,
              maxLines: 2,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(dialogContext.l10n.commonCancel),
          ),
          TextButton(
            onPressed: () {
              final title = titleController.text.trim();
              if (title.isNotEmpty) {
                context.read<TestDetailBloc>().add(
                  TestDetailEvent.testUpdated(
                    title: title,
                    description: descriptionController.text.trim().isEmpty
                        ? null
                        : descriptionController.text.trim(),
                  ),
                );
                Navigator.of(dialogContext).pop();
              }
            },
            child: Text(dialogContext.l10n.commonSave),
          ),
        ],
      ),
    );
  }

  @override
  void onStartTestPressed() {
    final state = context.read<TestDetailBloc>().state;
    if (state is! TestDetailState$Loaded) return;

    final test = state.test;
    final testId = test.id;

    switch (test.type) {
      case TestType.tinder:
        context.router.push(
          TinderTestRoute(
            testId: testId,
            swapSides: _swapSides,
            answerIndex: _answerIndex,
            mixup: widget.mixup,
            mixupMin: widget.mixupMin,
            mixupMax: widget.mixupMax,
            groupId: widget.groupId,
          ),
        );
    }
  }

  @override
  void onTestSettingsPressed() {
    final state = context.read<TestDetailBloc>().state;
    if (state is! TestDetailState$Loaded) return;

    final maxVariants = state.cards
        .map((card) => card.answers.length)
        .fold(1, (prev, len) => len > prev ? len : prev);

    showDialog<TestSettingsResult>(
      context: context,
      builder: (_) => TestSettingsDialog(
        swapSides: _swapSides,
        answerIndex: _answerIndex,
        maxAnswerVariants: maxVariants,
      ),
    ).then((result) {
      if (result == null) return;
      // Экран этих значений не показывает, перерисовка не нужна.
      _swapSides = result.swapSides;
      _answerIndex = result.answerIndex;
    });
  }

  @override
  void onImportCsvPressed() {
    _showCsvImportDialog();
  }

  Future<void> _showCsvImportDialog() async {
    final bloc = context.read<CsvImportBloc>()
      ..add(const CsvImportEvent.reset());

    final isConfirmed = await showDialog<bool>(
      context: context,
      builder: (_) => CsvImportDialog(viewModel: this),
    );

    if (isConfirmed ?? false) {
      bloc.add(const CsvImportEvent.importRequested());
    }
  }

  @override
  void onCsvFilesPickPressed() {
    context.read<CsvImportBloc>().add(
      const CsvImportEvent.filesPickRequested(),
    );
  }

  @override
  void onCsvFileRemovePressed(int index) {
    context.read<CsvImportBloc>().add(CsvImportEvent.fileRemoved(index: index));
  }

  @override
  void onCsvDelimiterChanged(String delimiter) {
    context.read<CsvImportBloc>().add(
      CsvImportEvent.delimiterChanged(delimiter: delimiter),
    );
  }

  /// Разбор закончился: добавляем карточки в тест и показываем итог.
  void _onCsvImportResult(BuildContext context, CsvImportState state) {
    final result = state.result?.value;
    if (result == null) return;

    switch (result) {
      case CsvImportSuccess(:final cards):
        context.read<TestDetailBloc>().add(
          TestDetailEvent.cardsImported(cards: cards),
        );
        SnackController.show(
          context,
          context.l10n.csvImportSuccess(cards.length, state.fileCount),
        );
      case CsvImportPartialSuccess(:final cards, :final failedFiles):
        context.read<TestDetailBloc>().add(
          TestDetailEvent.cardsImported(cards: cards),
        );
        SnackController.show(
          context,
          context.l10n.csvImportPartialSuccess(
            cards.length,
            failedFiles.join(', '),
          ),
        );
      case CsvImportCancelled():
        break;
      case CsvImportError(:final type):
        SnackController.showError(context, switch (type) {
          CsvImportErrorType.empty => context.l10n.csvImportErrorEmpty,
          CsvImportErrorType.invalidFormat => context.l10n.csvImportErrorFormat,
          CsvImportErrorType.readError => context.l10n.csvImportErrorRead,
        });
    }
  }
}

/// ViewModel интерфейс для экрана деталки теста.
///
/// Определяет контракт между [TestDetailScreen] и [TestDetailView].
abstract interface class ITestDetailViewModel {
  /// Тест и его карточки.
  StateStreamable<TestDetailState> get testDetailState;

  /// Черновик импорта из CSV: выбранные файлы и разделитель.
  StateStreamable<CsvImportState> get csvImportState;

  void onBackPressed();

  void onAddCardPressed();

  void onCardTapped(CardEntity card);

  /// Удалить карточку с отменой через снек.
  void onCardDeletePressed(CardEntity card);

  /// Удалённые карточки, пока удаление можно отменить: в списке их нет.
  ValueListenable<Set<String>> get deletedCardIds;

  void onEditTestPressed();

  void onStartTestPressed();

  void onImportCsvPressed();

  void onTestSettingsPressed();

  /// Открыть системный выбор CSV-файлов.
  void onCsvFilesPickPressed();

  /// Убрать файл из списка выбранных.
  void onCsvFileRemovePressed(int index);

  /// Изменить разделитель колонок.
  void onCsvDelimiterChanged(String delimiter);
}
