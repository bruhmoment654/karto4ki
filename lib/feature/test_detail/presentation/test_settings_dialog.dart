import 'package:flutter/material.dart';

import 'package:quizzerg/uikit/dialogs/app_dialog.dart';
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
    return AppDialog(
      title: const Text('Настройка теста'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Инвертировать стороны',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              AppSwitch(
                value: _swapSides,
                onChanged: (value) => setState(() {
                  _swapSides = value;
                  if (!value) _answerIndex = 0;
                }),
              ),
            ],
          ),
          if (_swapSides && widget.maxAnswerVariants > 1) ...[
            const SizedBox(height: 12),
            _AnswerIndexSelector(
              answerIndex: _answerIndex,
              maxVariants: widget.maxAnswerVariants,
              onChanged: (idx) => setState(() => _answerIndex = idx),
            ),
          ],
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Отмена'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(
            TestSettingsResult(
              swapSides: _swapSides,
              answerIndex: _answerIndex,
            ),
          ),
          child: const Text('Применить'),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Вариант для вопроса',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        PopupMenuButton<int>(
          initialValue: answerIndex,
          onSelected: onChanged,
          itemBuilder: (_) => [
            for (var i = 0; i < maxVariants; i++)
              PopupMenuItem(value: i, child: Text('${i + 1}')),
          ],
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).colorScheme.outline,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '${answerIndex + 1}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ),
      ],
    );
  }
}
