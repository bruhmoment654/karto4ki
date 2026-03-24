import 'package:flutter/material.dart';

import 'package:quizzerg/uikit/pressable/scale_pressable.dart';
import 'package:quizzerg/uikit/theme/app_theme.dart';

class AppDropdown extends StatefulWidget {
  const AppDropdown({
    required this.title,
    required this.child,
    super.key,
  });

  final String title;
  final Widget child;

  @override
  State<AppDropdown> createState() => _AppDropdownState();
}

class _AppDropdownState extends State<AppDropdown> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ScalePressable(
          onTap: () => setState(() => _isExpanded = !_isExpanded),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              height: 56,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title,
                    style: textTheme.bodyLarge?.copyWith(
                      color: colorScheme.foreground,
                    ),
                  ),
                  AnimatedRotation(
                    turns: _isExpanded ? 0.25 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      Icons.chevron_right,
                      size: 20,
                      color: colorScheme.mutedForeground,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: AnimatedCrossFade(
            firstChild: widget.child,
            secondChild: const SizedBox(width: double.infinity),
            firstCurve: Curves.easeOut,
            sizeCurve: Curves.fastEaseInToSlowEaseOut,
            crossFadeState: _isExpanded
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            duration: const Duration(milliseconds: 500),
          ),
        ),
      ],
    );
  }
}
