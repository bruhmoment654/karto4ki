import 'package:material_3_expressive/material_3_expressive.dart';
import 'package:material_ui/material_ui.dart';
import 'package:quizzerg/feature/uikit_catalog/presentation/widgets/catalog_item.dart';
import 'package:quizzerg/uikit/spacing/height.dart';
import 'package:quizzerg/uikit/spacing/width.dart';

/// Контейнеры material_3_expressive: карточки, карусели, списки и
/// разделители.
class M3EContainmentSection extends StatelessWidget {
  const M3EContainmentSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CatalogItem(
          title: 'M3ECard',
          description: 'Варианты: elevated, filled, outlined',
          child: _CardVariants(),
        ),
        CatalogItem(
          title: 'M3ECard',
          description: 'С media сверху, subhead и actions',
          child: _MediaCard(),
        ),
        CatalogItem(
          title: 'M3ECarousel',
          description: 'Тип hero',
          child: _CarouselDemo(type: M3ECarouselType.hero),
        ),
        CatalogItem(
          title: 'M3ECarousel',
          description: 'Тип contained (multi-browse)',
          child: _CarouselDemo(type: M3ECarouselType.contained),
        ),
        CatalogItem(
          title: 'M3ECarousel',
          description: 'Тип uncontained',
          child: _CarouselDemo(type: M3ECarouselType.uncontained),
        ),
        CatalogItem(
          title: 'M3EListItem',
          description: 'Одна, две и три строки; leading, trailing, variant',
          child: _ListItems(),
        ),
        CatalogItem(
          title: 'M3EList',
          description:
              'Сегментированный список, выбранная строка отмечена галочкой',
          child: _SegmentedListDemo(),
        ),
        CatalogItem(
          title: 'M3EList',
          description: 'variant: outlined',
          child: _OutlinedListDemo(),
        ),
        CatalogItem(
          title: 'M3EDivider',
          description: 'Горизонтальный: full, inset, middle; вертикальный',
          child: _DividerDemo(),
        ),
      ],
    );
  }
}

class _CardVariants extends StatelessWidget {
  const _CardVariants();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final variant in M3ECardVariant.values) ...[
          M3ECard(
            variant: variant,
            headline: variant.name,
            supportingText: 'Нажимаемая карточка без container transform',
            onPressed: () {},
          ),
          const Height(12),
        ],
      ],
    );
  }
}

class _MediaCard extends StatelessWidget {
  const _MediaCard();

  @override
  Widget build(BuildContext context) {
    return M3ECard(
      variant: M3ECardVariant.outlined,
      vertical: true,
      mediaDecorative: true,
      media: const SizedBox(
        height: 120,
        child: _GradientBox(colors: _Palette.ocean),
      ),
      headline: 'Английский B2',
      subhead: '120 карточек',
      supportingText: 'Колода для ежедневного повторения',
      actions: Align(
        alignment: AlignmentDirectional.centerEnd,
        child: M3EButton(
          style: M3EButtonStyle.tonal,
          onPressed: () {},
          child: const Text('Учить'),
        ),
      ),
      onPressed: () {},
    );
  }
}

class _CarouselDemo extends StatelessWidget {
  static const _slides = [
    ('Утро', _Palette.sunrise),
    ('Океан', _Palette.ocean),
    ('Лес', _Palette.forest),
    ('Закат', _Palette.sunset),
    ('Ночь', _Palette.night),
  ];

  final M3ECarouselType type;

  const _CarouselDemo({required this.type});

  @override
  Widget build(BuildContext context) {
    final titleStyle = M3ETheme.of(
      context,
    ).typeScale.titleMedium.copyWith(color: const Color(0xFFFFFFFF));

    return SizedBox(
      height: 200,
      child: M3ECarousel(
        type: type,
        children: [
          for (final (title, colors) in _slides)
            M3ECarouselItem(
              semanticLabel: title,
              title: Text(title, style: titleStyle),
              image: _GradientBox(colors: colors),
              onTap: () {},
            ),
        ],
      ),
    );
  }
}

class _ListItems extends StatelessWidget {
  const _ListItems();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        M3EListItem(
          headline: 'Одна строка',
          leading: const Icon(M3EIcons.style),
          onTap: () {},
        ),
        M3EListItem(
          headline: 'Две строки',
          supportingText: 'Поддерживающий текст',
          leading: const Icon(M3EIcons.translate),
          trailing: const Icon(M3EIcons.chevron_right),
          onTap: () {},
        ),
        M3EListItem(
          overline: 'Overline',
          headline: 'Три строки',
          supportingText: 'Поддерживающий текст, который занимает две строки',
          trailingText: '42',
          leading: const Icon(M3EIcons.school),
          onTap: () {},
        ),
        const Height(8),
        M3EListItem(
          headline: 'Отдельная строка variant: filled',
          leading: const Icon(M3EIcons.star),
          variant: M3ECardVariant.filled,
          onTap: () {},
        ),
        const Height(8),
        const M3EListItem(
          headline: 'Disabled',
          leading: Icon(M3EIcons.block),
          enabled: false,
        ),
      ],
    );
  }
}

class _SegmentedListDemo extends StatefulWidget {
  const _SegmentedListDemo();

  @override
  State<_SegmentedListDemo> createState() => _SegmentedListDemoState();
}

class _SegmentedListDemoState extends State<_SegmentedListDemo> {
  static const _rows = [
    ('Входящие', M3EIcons.inbox),
    ('Избранное', M3EIcons.star_border),
    ('Архив', M3EIcons.archive),
    ('Корзина', M3EIcons.delete_outline),
  ];

  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    return M3EList(
      itemCount: _rows.length,
      onTap: (index) => setState(() => _selected = index),
      itemBuilder: (context, index) {
        final (title, icon) = _rows[index];

        final isSelected = index == _selected;

        return M3EListItem(
          headline: title,
          leading: Icon(icon),
          trailing: isSelected ? const Icon(M3EIcons.check) : null,
          selected: isSelected,
        );
      },
    );
  }
}

class _OutlinedListDemo extends StatelessWidget {
  const _OutlinedListDemo();

  @override
  Widget build(BuildContext context) {
    return M3EList(
      variant: M3ECardVariant.outlined,
      itemCount: 3,
      onTap: (_) {},
      itemBuilder: (context, index) => M3EListItem(
        headline: 'Колода ${index + 1}',
        supportingText: '${(index + 1) * 25} карточек',
        leading: const Icon(M3EIcons.style),
      ),
    );
  }
}

class _DividerDemo extends StatelessWidget {
  const _DividerDemo();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('full'),
        Height(8),
        M3EDivider(),
        Height(12),
        Text('inset'),
        Height(8),
        M3EDivider(inset: M3EDividerInset.inset),
        Height(12),
        Text('middle'),
        Height(8),
        M3EDivider(inset: M3EDividerInset.middle),
        Height(12),
        SizedBox(
          height: 40,
          child: Row(
            children: [
              Text('Слева'),
              Width(12),
              M3EDivider(axis: M3EDividerAxis.vertical),
              Width(12),
              Text('Справа'),
            ],
          ),
        ),
      ],
    );
  }
}

class _GradientBox extends StatelessWidget {
  final List<Color> colors;

  const _GradientBox({required this.colors});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors,
        ),
      ),
      child: const SizedBox.expand(),
    );
  }
}

/// Градиенты-заглушки вместо картинок.
abstract final class _Palette {
  static const sunrise = [Color(0xFFFFB74D), Color(0xFFE57373)];
  static const ocean = [Color(0xFF4FC3F7), Color(0xFF1A237E)];
  static const forest = [Color(0xFF81C784), Color(0xFF1B5E20)];
  static const sunset = [Color(0xFFBA68C8), Color(0xFFFF7043)];
  static const night = [Color(0xFF5C6BC0), Color(0xFF121858)];
}
