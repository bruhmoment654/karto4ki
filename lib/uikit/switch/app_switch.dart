import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:quizzerg/uikit/theme/app_theme.dart';

class AppSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;

  const AppSwitch({
    required this.value,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: 48,
      height: 28,
      child: CupertinoSwitch(
        value: value,
        onChanged: onChanged,
        activeTrackColor: colorScheme.primary,
        inactiveTrackColor: colorScheme.muted,
        thumbColor: Colors.white,
      ),
    );
  }
}
