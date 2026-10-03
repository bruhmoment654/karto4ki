import 'package:flutter/material.dart';
import 'package:quizzerg/uikit/buttons/karto4ki_button.dart';
import 'package:quizzerg/uikit/spacing/height.dart';

/// Демо с кнопкой «Повторить»: пересоздаёт [child], чтобы заново проиграть
/// входную анимацию.
class CatalogReplay extends StatefulWidget {
  final Widget child;

  const CatalogReplay({required this.child, super.key});

  @override
  State<CatalogReplay> createState() => _CatalogReplayState();
}

class _CatalogReplayState extends State<CatalogReplay> {
  int _run = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        KeyedSubtree(key: ValueKey(_run), child: widget.child),
        const Height(8),
        Karto4kiButton(
          label: 'Повторить',
          icon: Icons.replay,
          variant: Karto4kiButtonVariant.ghost,
          onPressed: () => setState(() => _run++),
        ),
      ],
    );
  }
}
