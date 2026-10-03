import 'package:flutter/material.dart';
import 'package:material_3_expressive/material_3_expressive.dart'
    show M3ELoadingIndicator;
import 'package:quizzerg/uikit/m3e/m3e_scope.dart';

/// Неопределённый индикатор загрузки M3 Expressive: морфящийся и
/// вращающийся полигон без подложки.
///
/// Только для процесса, который реально идёт: определённый прогресс —
/// круговой или линейный индикатор.
class AppLoadingIndicator extends StatelessWidget {
  /// Пакет принимает размер только в этом диапазоне (assert).
  static const _minSize = 24.0;
  static const _maxSize = 240.0;

  const AppLoadingIndicator({
    required this.size,
    this.color,
    this.semanticLabel,
    super.key,
  });

  /// Внешний размер. Приводится к допустимому диапазону пакета 24..240.
  final double size;

  /// Цвет фигуры. По умолчанию — `primary`.
  final Color? color;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    return M3EScope(
      child: M3ELoadingIndicator(
        size: size.clamp(_minSize, _maxSize),
        color: color ?? Theme.of(context).colorScheme.primary,
        semanticLabel: semanticLabel,
      ),
    );
  }
}
