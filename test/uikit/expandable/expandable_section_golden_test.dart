import 'package:flutter/material.dart';
import 'package:quizzerg/uikit/expandable/expandable_section.dart';
import 'package:quizzerg/uikit/spacing/height.dart';
import 'package:quizzerg/uikit/spacing/width.dart';
import 'package:zoloto/zoloto.dart';

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            'Размер шрифта на карточке',
            style: theme.textTheme.labelLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        const Width(8),
        Text(
          '96 px',
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.primary,
          ),
        ),
      ],
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}

/// Свёрнутое и раскрытое состояние: шеврон повёрнут, тело видно целиком.
void main() {
  Zoloto.zolotoTest(
    'expandable_section_states',
    widgetBuilder: (context, tester, testCase) => ColoredBox(
      color: Theme.of(context).colorScheme.surfaceContainer,
      child: const Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ExpandableSection(header: _Header(), child: _Body()),
            Height(24),
            ExpandableSection(
              header: _Header(),
              initiallyExpanded: true,
              child: _Body(),
            ),
          ],
        ),
      ),
    ),
    testHeight: const TestHeight$BasedOnContent(),
  );
}
