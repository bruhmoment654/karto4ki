import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quizzerg/feature/uikit_catalog/presentation/widgets/catalog_item.dart';
import 'package:quizzerg/uikit/buttons/karto4ki_button.dart';
import 'package:quizzerg/uikit/dialogs/app_dialog.dart';
import 'package:quizzerg/uikit/dialogs/app_dialog_action.dart';
import 'package:quizzerg/uikit/dialogs/dialog_controller.dart';
import 'package:quizzerg/uikit/snackbars/snack_controller.dart';

/// Диалоги, шторки и снекбары.
class FeedbackSection extends StatelessWidget {
  const FeedbackSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CatalogItem(
          title: 'AppDialog + AppDialogAction',
          child: _DialogButtons(),
        ),
        CatalogItem(
          title: 'DialogController',
          description: 'Обёртки над showDialog и showModalBottomSheet',
          child: _ControllerButtons(),
        ),
        CatalogItem(title: 'SnackController', child: _SnackButtons()),
      ],
    );
  }
}

class _DialogButtons extends StatelessWidget {
  const _DialogButtons();

  Future<void> _showConfirm(BuildContext context) async {
    final isConfirmed = await AppDialog.confirm(
      context: context,
      title: 'Удалить тест?',
      message: 'Действие нельзя отменить.',
      cancelLabel: 'Отмена',
      confirmLabel: 'Удалить',
    );
    if (!context.mounted) return;
    SnackController.show(context, 'Результат: $isConfirmed');
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        Karto4kiButton(
          label: 'AppDialog',
          variant: Karto4kiButtonVariant.secondary,
          onPressed: () => showDialog<void>(
            context: context,
            builder: (_) => const AppDialog(
              title: Text('Заголовок'),
              content: Text('Произвольный контент диалога.'),
              actions: [AppDialogAction<void>(label: 'Понятно')],
            ),
          ),
        ),
        Karto4kiButton(
          label: 'AppDialog.confirm',
          variant: Karto4kiButtonVariant.secondary,
          onPressed: () => unawaited(_showConfirm(context)),
        ),
      ],
    );
  }
}

class _ControllerButtons extends StatelessWidget {
  const _ControllerButtons();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        Karto4kiButton(
          label: 'showDialog',
          variant: Karto4kiButtonVariant.outline,
          onPressed: () => DialogController.showDialog<void>(
            context: context,
            builder: (_) => const AppDialog(
              title: Text('DialogController'),
              actions: [AppDialogAction<void>(label: 'Ок')],
            ),
          ),
        ),
        Karto4kiButton(
          label: 'showBottomSheet',
          variant: Karto4kiButtonVariant.outline,
          onPressed: () => DialogController.showBottomSheet<void>(
            context: context,
            builder: (_) => const Padding(
              padding: EdgeInsets.all(32),
              child: Text('Шторка DialogController.showBottomSheet'),
            ),
          ),
        ),
      ],
    );
  }
}

class _SnackButtons extends StatelessWidget {
  const _SnackButtons();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        Karto4kiButton(
          label: 'show',
          variant: Karto4kiButtonVariant.ghost,
          onPressed: () => SnackController.show(context, 'Обычный снекбар'),
        ),
        Karto4kiButton(
          label: 'showError',
          variant: Karto4kiButtonVariant.destructive,
          onPressed: () => SnackController.showError(context, 'Ошибка'),
        ),
        Karto4kiButton(
          label: 'hide',
          variant: Karto4kiButtonVariant.ghost,
          onPressed: () => SnackController.hide(context),
        ),
      ],
    );
  }
}
