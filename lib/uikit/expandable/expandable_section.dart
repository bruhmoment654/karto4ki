import 'package:flutter/material.dart';
import 'package:quizzerg/uikit/motion/app_motion.dart';
import 'package:quizzerg/uikit/spacing/width.dart';

/// Раскрывающийся блок: кликабельная шапка с шевроном и тело под ней.
///
/// Тело остаётся смонтированным и плавно схлопывается по высоте в обе
/// стороны. Свёрнутое тело исключено из семантики и фокуса. Состояние
/// раскрытия локальное.
///
/// reduced-motion ([AppMotion.reduced]): раскрывается без анимации.
class ExpandableSection extends StatefulWidget {
  /// Содержимое шапки. Шеврон справа добавляется автоматически.
  final Widget header;
  final Widget child;
  final bool initiallyExpanded;

  const ExpandableSection({
    required this.header,
    required this.child,
    this.initiallyExpanded = false,
    super.key,
  });

  @override
  State<ExpandableSection> createState() => _ExpandableSectionState();
}

class _ExpandableSectionState extends State<ExpandableSection> {
  late bool _isExpanded = widget.initiallyExpanded;

  void _toggle() => setState(() => _isExpanded = !_isExpanded);

  @override
  Widget build(BuildContext context) {
    final duration =
        AppMotion.reduced(context) ? Duration.zero : AppMotion.medium;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Semantics(
          button: true,
          expanded: _isExpanded,
          child: InkWell(
            onTap: _toggle,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                children: [
                  Expanded(child: widget.header),
                  const Width(8),
                  AnimatedRotation(
                    turns: _isExpanded ? 0.5 : 0,
                    duration: duration,
                    curve: AppMotion.emphasized,
                    child: Icon(
                      Icons.expand_more,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        ClipRect(
          child: AnimatedAlign(
            alignment: Alignment.topCenter,
            heightFactor: _isExpanded ? 1 : 0,
            duration: duration,
            curve: AppMotion.emphasized,
            child: ExcludeFocus(
              excluding: !_isExpanded,
              child: ExcludeSemantics(
                excluding: !_isExpanded,
                child: widget.child,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
