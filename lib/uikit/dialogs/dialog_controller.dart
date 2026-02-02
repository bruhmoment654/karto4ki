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

  static Future<T?> showBottomSheet<T>({
    required material.BuildContext context,
    required material.WidgetBuilder builder,
    bool isScrollControlled = false,
    bool useSafeArea = true,
  }) {
    return material.showModalBottomSheet<T>(
      context: context,
      builder: builder,
      isScrollControlled: isScrollControlled,
      useSafeArea: useSafeArea,
    );
  }
}
