import 'package:flutter/material.dart';
import 'package:quizzerg/feature/uikit_catalog/presentation/sections/karto4ki/buttons_section.dart';
import 'package:quizzerg/feature/uikit_catalog/presentation/sections/karto4ki/cards_section.dart';
import 'package:quizzerg/feature/uikit_catalog/presentation/sections/karto4ki/feedback_section.dart';
import 'package:quizzerg/feature/uikit_catalog/presentation/sections/karto4ki/foundation_section.dart';
import 'package:quizzerg/feature/uikit_catalog/presentation/sections/karto4ki/headers_section.dart';
import 'package:quizzerg/feature/uikit_catalog/presentation/sections/karto4ki/inputs_section.dart';
import 'package:quizzerg/feature/uikit_catalog/presentation/sections/karto4ki/motion_section.dart';
import 'package:quizzerg/feature/uikit_catalog/presentation/sections/karto4ki/progress_section.dart';
import 'package:quizzerg/feature/uikit_catalog/presentation/sections/karto4ki/skeletons_section.dart';
import 'package:quizzerg/feature/uikit_catalog/presentation/sections/m3e/m3e_actions_section.dart';
import 'package:quizzerg/feature/uikit_catalog/presentation/sections/m3e/m3e_containment_section.dart';
import 'package:quizzerg/feature/uikit_catalog/presentation/sections/m3e/m3e_feedback_section.dart';
import 'package:quizzerg/feature/uikit_catalog/presentation/sections/m3e/m3e_navigation_section.dart';
import 'package:quizzerg/feature/uikit_catalog/presentation/sections/m3e/m3e_selection_section.dart';
import 'package:quizzerg/feature/uikit_catalog/presentation/widgets/catalog_section.dart';
import 'package:quizzerg/feature/uikit_catalog/presentation/widgets/catalog_sliver_group.dart';
import 'package:quizzerg/feature/uikit_catalog/presentation/widgets/m3e_sandbox.dart';
import 'package:quizzerg/uikit/appbar/karto4ki_app_bar.dart';
import 'package:quizzerg/uikit/scaffold/app_scaffold.dart';
import 'package:quizzerg/uikit/spacing/sliver_height.dart';

/// UI каталога компонентов. Строки не локализуются — экран только для
/// разработки.
class UikitCatalogView extends StatelessWidget {
  final VoidCallback onBackPressed;

  const UikitCatalogView({required this.onBackPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: DefaultAppBar.withBack(
        title: const Text('UIKit'),
        onBackPressed: onBackPressed,
      ),
      body: const CustomScrollView(
        slivers: [
          SliverHeight(24),
          CatalogSliverGroup(
            title: 'Karto4ki',
            subtitle: 'Компоненты lib/uikit',
            sections: _karto4kiSections,
          ),
          SliverHeight(32),
          CatalogSliverGroup(
            title: 'Material 3 Expressive',
            subtitle: 'material_3_expressive — без диалогов и шторок',
            sections: _m3eSections,
          ),
          SliverHeight(24),
        ],
      ),
    );
  }
}

const _karto4kiSections = [
  CatalogSection(
    icon: Icons.palette_outlined,
    title: 'Основа',
    child: FoundationSection(),
  ),
  CatalogSection(
    icon: Icons.smart_button_outlined,
    title: 'Кнопки',
    child: ButtonsSection(),
  ),
  CatalogSection(
    icon: Icons.tune,
    title: 'Поля и переключатели',
    child: InputsSection(),
  ),
  CatalogSection(
    icon: Icons.style_outlined,
    title: 'Карточки',
    child: CardsSection(),
  ),
  CatalogSection(
    icon: Icons.donut_large,
    title: 'Прогресс',
    child: ProgressSection(),
  ),
  CatalogSection(
    icon: Icons.hourglass_empty,
    title: 'Скелетоны',
    child: SkeletonsSection(),
  ),
  CatalogSection(
    icon: Icons.web_asset,
    title: 'Шапки',
    child: HeadersSection(),
  ),
  CatalogSection(
    icon: Icons.chat_bubble_outline,
    title: 'Диалоги и снекбары',
    child: FeedbackSection(),
  ),
  CatalogSection(
    icon: Icons.animation,
    title: 'Анимации',
    child: MotionSection(),
  ),
];

const _m3eSections = [
  CatalogSection(
    icon: Icons.touch_app_outlined,
    title: 'Действия',
    child: M3ESandbox(child: M3EActionsSection()),
  ),
  CatalogSection(
    icon: Icons.check_box_outlined,
    title: 'Выбор',
    child: M3ESandbox(child: M3ESelectionSection()),
  ),
  CatalogSection(
    icon: Icons.view_agenda_outlined,
    title: 'Контейнеры',
    child: M3ESandbox(child: M3EContainmentSection()),
  ),
  CatalogSection(
    icon: Icons.explore_outlined,
    title: 'Навигация',
    child: M3ESandbox(child: M3ENavigationSection()),
  ),
  CatalogSection(
    icon: Icons.notifications_none,
    title: 'Индикаторы и ввод',
    child: M3ESandbox(child: M3EFeedbackSection()),
  ),
];
