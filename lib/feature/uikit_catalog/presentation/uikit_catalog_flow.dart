import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:quizzerg/feature/uikit_catalog/presentation/uikit_catalog_view.dart';

/// Точка входа в каталог компонентов UIKit.
///
/// Открывается с дебаг-экрана.
@RoutePage()
class UikitCatalogFlow extends StatelessWidget {
  const UikitCatalogFlow({super.key});

  @override
  Widget build(BuildContext context) {
    return UikitCatalogView(onBackPressed: () => context.router.maybePop());
  }
}
