import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quizzerg/uikit/snackbars/deferred_removal.dart';
import 'package:quizzerg/uikit/snackbars/snack_controller.dart';

void main() {
  late DeferredRemoval removal;
  late List<String> committed;

  Future<BuildContext> pumpHost(WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: SizedBox.expand())),
    );
    return tester.element(find.byType(SizedBox).last);
  }

  void schedule(BuildContext context, String id) => removal.schedule(
    context,
    id: id,
    message: 'Удалено $id',
    undoLabel: 'Отменить',
    commit: () => committed.add(id),
  );

  setUp(() {
    removal = DeferredRemoval();
    committed = [];
  });

  testWidgets('«Отменить» возвращает элемент и не удаляет его', (tester) async {
    final context = await pumpHost(tester);
    schedule(context, 'a');
    await tester.pumpAndSettle();
    expect(removal.pending.value, {'a'});

    await tester.tap(find.text('Отменить'));
    await tester.pumpAndSettle();

    expect(removal.pending.value, isEmpty);
    expect(committed, isEmpty);
    removal.dispose();
  });

  testWidgets('без отмены удаление выполняется, когда снек ушёл', (
    tester,
  ) async {
    final context = await pumpHost(tester);
    schedule(context, 'a');
    await tester.pumpAndSettle();

    await tester.pump(SnackController.defaultDuration);
    await tester.pumpAndSettle();

    expect(committed, ['a']);
    // До перезагрузки списка элемент остаётся скрытым.
    expect(removal.pending.value, {'a'});
    removal.dispose();
  });

  testWidgets('новый снек подтверждает предыдущее удаление', (tester) async {
    final context = await pumpHost(tester);
    schedule(context, 'a');
    await tester.pumpAndSettle();
    schedule(context, 'b');
    await tester.pumpAndSettle();

    expect(committed, ['a']);
    expect(removal.pending.value, {'a', 'b'});
    removal.dispose();
  });

  testWidgets('dispose выполняет отложенные удаления ровно один раз', (
    tester,
  ) async {
    final context = await pumpHost(tester);
    schedule(context, 'a');
    await tester.pumpAndSettle();

    removal.dispose();
    await tester.pumpAndSettle();

    expect(committed, ['a']);
  });
}
