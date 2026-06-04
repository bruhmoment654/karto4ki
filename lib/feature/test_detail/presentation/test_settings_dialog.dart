import 'package:flutter/material.dart';

import 'package:quizzerg/l10n/app_localizations_x.dart';
import 'package:quizzerg/uikit/dialogs/app_dialog.dart';
import 'package:quizzerg/uikit/spacing/height.dart';
import 'package:quizzerg/uikit/switch/app_switch.dart' show AppSwitch;

class TestSettingsResult {
  final bool swapSides;
  final int answerIndex;

  const TestSettingsResult({
    required this.swapSides,
    required this.answerIndex,
  });
}

class TestSettingsDialog extends StatefulWidget {
  final bool swapSides;
  final int answerIndex;
  final int maxAnswerVariants;

  const TestSettingsDialog({
    required this.swapSides,
    required this.answerIndex,
    required this.maxAnswerVariants,
    super.key,
  });

  @override
  State<TestSettingsDialog> createState() => _TestSettingsDialogState();
}

class _TestSettingsDialogState extends State<TestSettingsDialog> {
  late bool _swapSides;
  late int _answerIndex;

  @override
  void initState() {
    super.initState();
    _swapSides = widget.swapSides;
    _answerIndex = widget.answerIndex;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return AppDialog(
      title: Text(
        context.l10n.testSettingsTitle,
        style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n.testSettingsSwapSides,
                      style: textTheme.titleMedium,
                    ),
                    const Height(2),
                    Text(
                      context.l10n.testSettingsSwapSidesSubtitle,
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 14),
              AppSwitch(
                value: _swapSides,
                onChanged: (value) => setState(() {
                  _swapSides = value;
                  if (!value) _answerIndex = 0;
                }),
              ),
            ],
          ),
          AnimatedCrossFade(
            firstChild: widget.maxAnswerVariants > 1
                ? Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: _AnswerIndexSelector(
                      answerIndex: _answerIndex,
                      maxVariants: widget.maxAnswerVariants,
                      onChanged: (idx) => setState(() => _answerIndex = idx),
                    ),
                  )
                : const SizedBox(width: double.infinity),
            secondChild: const SizedBox(width: double.infinity),
            crossFadeState:
                _swapSides ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            sizeCurve: Curves.fastEaseInToSlowEaseOut,
            duration: const Duration(milliseconds: 200),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(context.l10n.commonCancel),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(
            TestSettingsResult(
              swapSides: _swapSides,
              answerIndex: _answerIndex,
            ),
          ),
          child: Text(context.l10n.testSettingsApply),
        ),
      ],
    );
  }
}

class _AnswerIndexSelector extends StatelessWidget {
  final int answerIndex;
  final int maxVariants;
  final ValueChanged<int> onChanged;

  const _AnswerIndexSelector({
    required this.answerIndex,
    required this.maxVariants,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Expanded(
          child: Text(
            context.l10n.testSettingsAnswerVariant,
            style: textTheme.titleMedium,
          ),
        ),
        const SizedBox(width: 16),
        _StepperButton(
          icon: Icons.remove,
          filled: false,
          onPressed: answerIndex > 0 ? () => onChanged(answerIndex - 1) : null,
        ),
        SizedBox(
          width: 40,
          child: Text(
            '${answerIndex + 1}',
            textAlign: TextAlign.center,
            style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
          ),
        ),
        _StepperButton(
          icon: Icons.add,
          filled: true,
          onPressed: answerIndex < maxVariants - 1
              ? () => onChanged(answerIndex + 1)
              : null,
        ),
      ],
    );
  }
}

/// Круглая кнопка шага для степпера выбора варианта ответа.
class _StepperButton extends StatelessWidget {
  final IconData icon;
  final bool filled;
  final VoidCallback? onPressed;

  const _StepperButton({
    required this.icon,
    required this.filled,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final enabled = onPressed != null;

    final background = filled
        ? colorScheme.primary
        : colorScheme.surfaceContainerHighest;
    final foreground = filled
        ? colorScheme.onPrimary
        : colorScheme.onSurfaceVariant;

    return Material(
      color: enabled ? background : background.withValues(alpha: 0.4),
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onPressed,
        child: SizedBox(
          width: 32,
          height: 32,
          child: Icon(
            icon,
            size: 18,
            color: enabled ? foreground : foreground.withValues(alpha: 0.5),
          ),
        ),
      ),
    );
  }
}
