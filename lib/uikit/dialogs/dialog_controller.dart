import 'package:flutter/material.dart' as material;

class DialogController {
  const DialogController._();

  static Future<T?> showDialog<T>({
    required material.BuildContext context,
    required material.WidgetBuilder builder,
    bool barrierDismissible = true,
  }) {
    return material.showDialog<T>(
      context: context,
      builder: builder,
      barrierDismissible: barrierDismissible,
    );
  }

  /// [useRootNavigator] — по умолчанию шторка открывается в корневом
  /// навигаторе, как диалоги: из вкладки она иначе легла бы под нижнюю
  /// навигацию (у неё `extendBody`), а скрим не закрыл бы панель.
  static Future<T?> showBottomSheet<T>({
    required material.BuildContext context,
    required material.WidgetBuilder builder,
    bool isScrollControlled = false,
    bool useSafeArea = true,
    bool useRootNavigator = true,
    material.ShapeBorder? shape,
    material.Clip? clipBehavior,
    material.Color? backgroundColor,
    bool? showDragHandle,
  }) {
    return material.showModalBottomSheet<T>(
      context: context,
      builder: builder,
      isScrollControlled: isScrollControlled,
      useSafeArea: useSafeArea,
      useRootNavigator: useRootNavigator,
      shape: shape,
      clipBehavior: clipBehavior,
      backgroundColor: backgroundColor,
      showDragHandle: showDragHandle,
    );
  }
}
