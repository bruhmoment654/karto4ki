import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:quizzerg/uikit/snackbars/snack_controller.dart';

/// Удаление с отменой: элемент сразу пропадает из списка, снек «Отменить»
/// возвращает его, а само удаление выполняется, только когда снек закрылся
/// без отмены (по таймеру или его сменил другой снек) или экран закрылся.
///
/// Так в базу и синхронизацию не уходит пара «удалить → восстановить».
/// Список на экране фильтрует элементы по [pending]. Владелец обязан
/// вызвать [dispose] — несохранённые удаления выполняются в нём.
class DeferredRemoval {
  final ValueNotifier<Set<String>> _pending = ValueNotifier(const {});
  final Map<String, VoidCallback> _commits = {};
  ScaffoldMessengerState? _messenger;
  bool _isDisposed = false;

  /// Id элементов, удаление которых ещё можно отменить.
  ValueListenable<Set<String>> get pending => _pending;

  /// Прячет элемент [id] и показывает снек [message] с [undoLabel].
  /// [commit] — само удаление, выполняется не больше одного раза.
  void schedule(
    BuildContext context, {
    required String id,
    required String message,
    required String undoLabel,
    required VoidCallback commit,
  }) {
    _commits[id] = commit;
    _pending.value = {..._pending.value, id};
    _messenger = ScaffoldMessenger.of(context);

    // Предыдущий снек закроется с причиной hide — его удаление выполнится.
    SnackController.showUndo(
      context,
      message,
      undoLabel: undoLabel,
    ).closed.then((reason) {
      if (reason == SnackBarClosedReason.action) {
        _undo(id);
      } else {
        _commit(id);
      }
    });
  }

  /// Выполняет все отложенные удаления и гасит снек: на экране, которого
  /// больше нет, «Отменить» уже ничего не вернёт.
  void dispose() {
    _commits.keys.toList().forEach(_commit);
    _isDisposed = true;
    _messenger?.hideCurrentSnackBar();
    _pending.dispose();
  }

  /// Id остаётся в [pending]: удаление уходит в блок асинхронно, и до
  /// перезагрузки списка элемент иначе мелькнул бы снова.
  void _commit(String id) => _commits.remove(id)?.call();

  void _undo(String id) {
    if (_commits.remove(id) == null || _isDisposed) return;
    _pending.value = {..._pending.value}..remove(id);
  }
}
