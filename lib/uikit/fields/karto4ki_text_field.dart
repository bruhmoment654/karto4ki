import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show TextInputFormatter;

import 'package:quizzerg/uikit/app_radii.dart';

/// Стандартное текстовое поле приложения (M3 Expressive «pill»).
///
/// Тональная заливка без обводки, скругление-стадион для однострочного поля и
/// r28 для многострочного; при фокусе заливка подсвечивается
/// `secondaryContainer`. Лейбл уезжает мелкой подписью наверх, поддержаны
/// иконки, helper/error и обводка-ошибка.
class Karto4kiTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final String? helperText;
  final String? errorText;
  final bool obscureText;
  final int maxLines;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool enabled;
  final bool autofocus;
  final List<TextInputFormatter>? inputFormatters;

  /// Цвет заливки в покое. По умолчанию `surfaceContainerHighest`.
  /// Задавайте, если поле сливается с фоном (например, на диалогах).
  final Color? fillColor;

  /// Отступы контента (для компактных вариантов поля).
  final EdgeInsetsGeometry? contentPadding;

  /// Стиль текста (для компактных вариантов поля).
  final TextStyle? textStyle;
  final TextAlign textAlign;
  final TapRegionCallback? onTapOutside;

  const Karto4kiTextField({
    this.controller,
    this.labelText,
    this.hintText,
    this.helperText,
    this.errorText,
    this.obscureText = false,
    this.maxLines = 1,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.onEditingComplete,
    this.prefixIcon,
    this.suffixIcon,
    this.enabled = true,
    this.autofocus = false,
    this.inputFormatters,
    this.fillColor,
    this.contentPadding,
    this.textStyle,
    this.textAlign = TextAlign.start,
    this.onTapOutside,
    super.key,
  });

  @override
  State<Karto4kiTextField> createState() => _Karto4kiTextFieldState();
}

class _Karto4kiTextFieldState extends State<Karto4kiTextField> {
  final _focusNode = FocusNode();
  bool _focused = false;

  bool get _multiline => widget.maxLines > 1;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(
      () => setState(() => _focused = _focusNode.hasFocus),
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final hasError = widget.errorText != null;

    final baseFill = widget.fillColor ?? cs.surfaceContainerHighest;
    final fill = _focused ? cs.secondaryContainer : baseFill;
    final radius = _multiline
        ? BorderRadius.circular(AppDimens.radius28)
        : BorderRadius.circular(999);
    final accent =
        hasError ? cs.error : (_focused ? cs.primary : cs.onSurfaceVariant);

    OutlineInputBorder pill(Color color, double width) => OutlineInputBorder(
          borderRadius: radius,
          borderSide: color == Colors.transparent
              ? BorderSide.none
              : BorderSide(color: color, width: width),
        );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeOutCubic,
          decoration: BoxDecoration(color: fill, borderRadius: radius),
          child: TextField(
            controller: widget.controller,
            focusNode: _focusNode,
            obscureText: widget.obscureText,
            maxLines: widget.maxLines,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            onChanged: widget.onChanged,
            onEditingComplete: widget.onEditingComplete,
            enabled: widget.enabled,
            autofocus: widget.autofocus,
            inputFormatters: widget.inputFormatters,
            textAlign: widget.textAlign,
            onTapOutside: widget.onTapOutside,
            style: widget.textStyle ??
                TextStyle(color: cs.onSurface, fontSize: 16),
            cursorColor: cs.primary,
            decoration: InputDecoration(
              labelText: widget.labelText,
              hintText: widget.hintText,
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.suffixIcon,
              prefixIconColor: accent,
              suffixIconColor: cs.onSurfaceVariant,
              floatingLabelStyle: TextStyle(
                color: accent,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
              labelStyle: TextStyle(color: cs.onSurfaceVariant, fontSize: 16),
              hintStyle: TextStyle(
                color: cs.onSurfaceVariant.withValues(alpha: 0.6),
              ),
              // Заливку рисует AnimatedContainer (её можно анимировать).
              filled: false,
              isDense: widget.contentPadding != null,
              contentPadding: widget.contentPadding ??
                  EdgeInsets.symmetric(
                    horizontal: 22,
                    vertical: _multiline ? 16 : 18,
                  ),
              border: pill(Colors.transparent, 0),
              enabledBorder: pill(Colors.transparent, 0),
              focusedBorder: pill(Colors.transparent, 0),
              errorBorder: pill(cs.error, 2),
              focusedErrorBorder: pill(cs.error, 2),
              // Текст ошибки рисуем сами ниже.
              errorStyle: const TextStyle(height: 0),
            ),
          ),
        ),
        if (widget.errorText != null || widget.helperText != null)
          Padding(
            padding: const EdgeInsets.fromLTRB(22, 4, 22, 0),
            child: Row(
              children: [
                if (hasError) ...[
                  Icon(Icons.error_outline, size: 14, color: cs.error),
                  const SizedBox(width: 4),
                ],
                Expanded(
                  child: Text(
                    widget.errorText ?? widget.helperText!,
                    style: TextStyle(
                      fontSize: 12,
                      color: hasError ? cs.error : cs.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
