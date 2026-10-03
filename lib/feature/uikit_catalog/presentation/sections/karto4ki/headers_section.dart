import 'package:flutter/material.dart';
import 'package:quizzerg/feature/uikit_catalog/presentation/widgets/catalog_item.dart';
import 'package:quizzerg/uikit/app_radii.dart';
import 'package:quizzerg/uikit/appbar/app_page_header.dart';
import 'package:quizzerg/uikit/appbar/karto4ki_app_bar.dart';
import 'package:quizzerg/uikit/snackbars/snack_controller.dart';

/// Шапки экранов.
class HeadersSection extends StatelessWidget {
  const HeadersSection({super.key});

  void _showPressed(BuildContext context) =>
      SnackController.show(context, 'Нажато');

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CatalogItem(
          title: 'DefaultAppBar',
          description: 'По умолчанию leading — SkeletonGif',
          child: _Frame(child: DefaultAppBar(title: Text('Заголовок'))),
        ),
        CatalogItem(
          title: 'DefaultAppBar.withBack',
          description: 'С actions',
          child: _Frame(
            child: DefaultAppBar.withBack(
              title: const Text('Назад'),
              onBackPressed: () => _showPressed(context),
              actions: [
                IconButton(
                  icon: const Icon(Icons.share),
                  onPressed: () => _showPressed(context),
                ),
              ],
            ),
          ),
        ),
        const CatalogItem(
          title: 'DefaultAppBar.expanded',
          description: 'Высота тулбара +32',
          child: _Frame(
            child: DefaultAppBar.expanded(
              title: Text('Расширенный'),
              leading: Icon(Icons.menu),
            ),
          ),
        ),
        CatalogItem(
          title: 'AppPageHeader',
          description: 'Заголовок, подзаголовок и action',
          child: _Frame(
            child: AppPageHeader(
              title: 'Группы',
              subtitle: '12 тестов',
              onTitlePressed: () => _showPressed(context),
              action: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => _showPressed(context),
              ),
            ),
          ),
        ),
        CatalogItem(
          title: 'AppPageHeader.withBack',
          child: _Frame(
            child: AppPageHeader.withBack(
              title: 'Английский',
              subtitle: 'Подзаголовок',
              onBackPressed: () => _showPressed(context),
            ),
          ),
        ),
      ],
    );
  }
}

/// Подложка, чтобы были видны границы прозрачных шапок.
class _Frame extends StatelessWidget {
  final Widget child;

  const _Frame({required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppDimens.radius16),
      child: ColoredBox(
        color: Theme.of(context).colorScheme.surface,
        child: child,
      ),
    );
  }
}
