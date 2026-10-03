import 'package:flutter/material.dart';
import 'package:quizzerg/feature/uikit_catalog/presentation/widgets/catalog_group_title.dart';
import 'package:quizzerg/feature/uikit_catalog/presentation/widgets/catalog_section.dart';
import 'package:quizzerg/uikit/spacing/height.dart';
import 'package:quizzerg/uikit/spacing/sliver_height.dart';

/// Сливер с заголовком библиотеки компонентов и списком её секций.
class CatalogSliverGroup extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<CatalogSection> sections;

  const CatalogSliverGroup({
    required this.title,
    required this.subtitle,
    required this.sections,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverMainAxisGroup(
        slivers: [
          SliverToBoxAdapter(
            child: CatalogGroupTitle(title: title, subtitle: subtitle),
          ),
          const SliverHeight(12),
          SliverList.separated(
            itemCount: sections.length,
            itemBuilder: (_, index) => sections[index],
            separatorBuilder: (_, _) => const Height(12),
          ),
        ],
      ),
    );
  }
}
