import 'package:material_3_expressive/material_3_expressive.dart';
import 'package:material_ui/material_ui.dart';
import 'package:quizzerg/feature/uikit_catalog/presentation/widgets/catalog_item.dart';
import 'package:quizzerg/uikit/spacing/height.dart';
import 'package:quizzerg/uikit/spacing/width.dart';

/// Действия material_3_expressive: кнопки, FAB, группы и сегменты.
class M3EActionsSection extends StatelessWidget {
  const M3EActionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CatalogItem(
          title: 'M3EButton',
          description: 'Стили: elevated, filled, tonal, outlined, text',
          child: _ButtonStyles(),
        ),
        CatalogItem(
          title: 'M3EButton',
          description: 'Размеры xs, sm, md, lg, xl и форма square',
          child: _ButtonSizes(),
        ),
        CatalogItem(
          title: 'M3EButton',
          description: 'Переключатель isSelected с selectedIcon и disabled',
          child: _ButtonToggles(),
        ),
        CatalogItem(
          title: 'M3EIconButton',
          description: 'Варианты: standard, filled, tonal, outlined',
          child: _IconButtonVariants(),
        ),
        CatalogItem(
          title: 'M3EIconButton',
          description: 'Размеры xs–xl, ширина narrow / wide, форма square',
          child: _IconButtonSizes(),
        ),
        CatalogItem(
          title: 'M3EIconButton',
          description: 'Переключатель isSelected во всех вариантах',
          child: _IconButtonToggles(),
        ),
        CatalogItem(
          title: 'M3EFab',
          description: 'Размеры: small, regular, medium, large',
          child: _FabSizes(),
        ),
        CatalogItem(
          title: 'M3EFab',
          description: 'Цвета M3EFabColor',
          child: _FabColors(),
        ),
        CatalogItem(
          title: 'M3EExtendedFab',
          description: 'Размеры small, medium, large; нажатие сворачивает',
          child: _ExtendedFabs(),
        ),
        CatalogItem(
          title: 'M3EFabMenu',
          description: 'Меню быстрых действий, раскрывается над кнопкой',
          child: _FabMenuDemo(),
        ),
        CatalogItem(
          title: 'M3EButtonGroup',
          description: 'Standard: одиночный выбор, выбор обязателен',
          child: _StandardGroupDemo(),
        ),
        CatalogItem(
          title: 'M3EButtonGroup',
          description: 'Connected: множественный выбор',
          child: _ConnectedGroupDemo(),
        ),
        CatalogItem(
          title: 'M3ESegmentedButton',
          description: 'Одиночный и множественный выбор',
          child: _SegmentedDemo(),
        ),
      ],
    );
  }
}

class _ButtonStyles extends StatelessWidget {
  const _ButtonStyles();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final style in M3EButtonStyle.values)
          M3EButton(style: style, onPressed: () {}, child: Text(style.name)),
        M3EButton(
          icon: const Icon(M3EIcons.add),
          label: const Text('С иконкой'),
          onPressed: () {},
        ),
        const M3EButton(onPressed: null, child: Text('Disabled')),
      ],
    );
  }
}

class _ButtonSizes extends StatelessWidget {
  static const _sizes = [
    M3EButtonSize.xs,
    M3EButtonSize.sm,
    M3EButtonSize.md,
    M3EButtonSize.lg,
    M3EButtonSize.xl,
  ];

  const _ButtonSizes();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            for (final size in _sizes)
              M3EButton(size: size, onPressed: () {}, child: Text(size.name)),
          ],
        ),
        const Height(12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            M3EButton(
              shape: M3EButtonShape.square,
              style: M3EButtonStyle.tonal,
              onPressed: () {},
              child: const Text('square'),
            ),
            M3EButton(
              shape: M3EButtonShape.square,
              style: M3EButtonStyle.outlined,
              onPressed: () {},
              child: const Text('square'),
            ),
          ],
        ),
      ],
    );
  }
}

class _ButtonToggles extends StatefulWidget {
  const _ButtonToggles();

  @override
  State<_ButtonToggles> createState() => _ButtonTogglesState();
}

class _ButtonTogglesState extends State<_ButtonToggles> {
  static const _styles = [
    M3EButtonStyle.filled,
    M3EButtonStyle.tonal,
    M3EButtonStyle.outlined,
    M3EButtonStyle.elevated,
  ];

  final _selected = <M3EButtonStyle>{M3EButtonStyle.filled};

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final style in _styles)
          M3EButton(
            style: style,
            icon: const Icon(M3EIcons.favorite_border),
            selectedIcon: const Icon(M3EIcons.favorite),
            label: Text(style.name),
            isSelected: _selected.contains(style),
            onPressed: () => _toggle(style),
          ),
        const M3EButton(
          icon: Icon(M3EIcons.favorite_border),
          label: Text('Disabled'),
          isSelected: false,
          onPressed: null,
        ),
      ],
    );
  }

  void _toggle(M3EButtonStyle style) {
    setState(() {
      if (!_selected.remove(style)) _selected.add(style);
    });
  }
}

class _IconButtonVariants extends StatelessWidget {
  const _IconButtonVariants();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final variant in M3EIconButtonVariant.values)
          M3EIconButton(
            variant: variant,
            tooltip: variant.name,
            icon: const Icon(M3EIcons.edit),
            onPressed: () {},
          ),
        for (final variant in M3EIconButtonVariant.values)
          M3EIconButton(variant: variant, icon: const Icon(M3EIcons.edit)),
      ],
    );
  }
}

class _IconButtonSizes extends StatelessWidget {
  const _IconButtonSizes();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            for (final size in M3EIconButtonSize.values)
              M3EIconButton(
                size: size,
                variant: M3EIconButtonVariant.tonal,
                icon: const Icon(M3EIcons.star),
                onPressed: () {},
              ),
          ],
        ),
        const Height(12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            for (final width in M3EIconButtonWidth.values)
              M3EIconButton(
                width: width,
                size: M3EIconButtonSize.md,
                icon: const Icon(M3EIcons.star),
                onPressed: () {},
              ),
            M3EIconButton(
              shape: M3EIconButtonShapeVariant.square,
              size: M3EIconButtonSize.md,
              variant: M3EIconButtonVariant.outlined,
              icon: const Icon(M3EIcons.star),
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }
}

class _IconButtonToggles extends StatefulWidget {
  const _IconButtonToggles();

  @override
  State<_IconButtonToggles> createState() => _IconButtonTogglesState();
}

class _IconButtonTogglesState extends State<_IconButtonToggles> {
  final _selected = <M3EIconButtonVariant>{M3EIconButtonVariant.filled};

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final variant in M3EIconButtonVariant.values)
          M3EIconButton(
            variant: variant,
            icon: const Icon(M3EIcons.bookmark_border),
            selectedIcon: const Icon(M3EIcons.bookmark),
            isSelected: _selected.contains(variant),
            onPressed: () => _toggle(variant),
          ),
      ],
    );
  }

  void _toggle(M3EIconButtonVariant variant) {
    setState(() {
      if (!_selected.remove(variant)) _selected.add(variant);
    });
  }
}

class _FabSizes extends StatelessWidget {
  const _FabSizes();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      crossAxisAlignment: WrapCrossAlignment.end,
      children: [
        for (final size in M3EFabSize.values)
          M3EFab(
            size: size,
            tooltip: size.name,
            icon: const Icon(M3EIcons.add),
            onPressed: () {},
          ),
      ],
    );
  }
}

class _FabColors extends StatelessWidget {
  const _FabColors();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        for (final color in M3EFabColor.values)
          M3EFab(
            size: M3EFabSize.regular,
            color: color,
            tooltip: color.name,
            icon: const Icon(M3EIcons.edit),
            onPressed: () {},
          ),
      ],
    );
  }
}

class _ExtendedFabs extends StatefulWidget {
  const _ExtendedFabs();

  @override
  State<_ExtendedFabs> createState() => _ExtendedFabsState();
}

class _ExtendedFabsState extends State<_ExtendedFabs> {
  final _collapsed = <M3EExtendedFabSize>{};

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      crossAxisAlignment: WrapCrossAlignment.end,
      children: [
        for (final size in M3EExtendedFabSize.values)
          M3EExtendedFab(
            size: size,
            label: size.name,
            icon: const Icon(M3EIcons.edit),
            extended: !_collapsed.contains(size),
            onPressed: () => _toggle(size),
          ),
        M3EExtendedFab(
          color: M3EFabColor.tertiaryFilled,
          label: 'Без иконки',
          onPressed: () {},
        ),
      ],
    );
  }

  void _toggle(M3EExtendedFabSize size) {
    setState(() {
      if (!_collapsed.remove(size)) _collapsed.add(size);
    });
  }
}

class _FabMenuDemo extends StatelessWidget {
  const _FabMenuDemo();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Text('Нажмите на кнопку справа')),
        const Width(12),
        M3EFabMenu(
          size: M3EFabSize.regular,
          items: [
            M3EFabMenuItem(
              icon: const Icon(M3EIcons.style),
              label: 'Новая колода',
              onPressed: () {},
            ),
            M3EFabMenuItem(
              icon: const Icon(M3EIcons.note_add),
              label: 'Новая карточка',
              onPressed: () {},
            ),
            M3EFabMenuItem(
              icon: const Icon(M3EIcons.file_upload),
              label: 'Импорт CSV',
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }
}

class _StandardGroupDemo extends StatefulWidget {
  const _StandardGroupDemo();

  @override
  State<_StandardGroupDemo> createState() => _StandardGroupDemoState();
}

class _StandardGroupDemoState extends State<_StandardGroupDemo> {
  int? _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return M3EButtonGroup(
      style: M3EButtonStyle.tonal,
      selectionRequired: true,
      selectedIndex: _selectedIndex,
      onSelectedIndexChanged: (index) => setState(() => _selectedIndex = index),
      actions: const [
        M3EButtonGroupAction(label: Text('День')),
        M3EButtonGroupAction(label: Text('Неделя')),
        M3EButtonGroupAction(label: Text('Месяц')),
      ],
    );
  }
}

class _ConnectedGroupDemo extends StatefulWidget {
  const _ConnectedGroupDemo();

  @override
  State<_ConnectedGroupDemo> createState() => _ConnectedGroupDemoState();
}

class _ConnectedGroupDemoState extends State<_ConnectedGroupDemo> {
  Set<int> _selectedIndices = {0};

  @override
  Widget build(BuildContext context) {
    return M3EButtonGroup(
      type: M3EButtonGroupType.connected,
      multiSelect: true,
      selectedIndices: _selectedIndices,
      onSelectedIndicesChanged: (indices) {
        setState(() => _selectedIndices = indices);
      },
      actions: const [
        M3EButtonGroupAction(
          icon: Icon(M3EIcons.format_bold),
          semanticLabel: 'Жирный',
        ),
        M3EButtonGroupAction(
          icon: Icon(M3EIcons.format_italic),
          semanticLabel: 'Курсив',
        ),
        M3EButtonGroupAction(
          icon: Icon(M3EIcons.format_underlined),
          semanticLabel: 'Подчёркнутый',
        ),
        M3EButtonGroupAction(
          icon: Icon(M3EIcons.format_strikethrough),
          semanticLabel: 'Зачёркнутый',
        ),
      ],
    );
  }
}

class _SegmentedDemo extends StatefulWidget {
  const _SegmentedDemo();

  @override
  State<_SegmentedDemo> createState() => _SegmentedDemoState();
}

class _SegmentedDemoState extends State<_SegmentedDemo> {
  Set<String> _single = {'list'};
  Set<String> _multi = {'new', 'learning'};

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        M3ESegmentedButton<String>(
          segments: const [
            M3ESegment(
              value: 'list',
              label: 'Список',
              icon: Icon(M3EIcons.view_list),
            ),
            M3ESegment(
              value: 'grid',
              label: 'Сетка',
              icon: Icon(M3EIcons.grid_view),
            ),
          ],
          selected: _single,
          onSelectionChanged: (value) => setState(() => _single = value),
        ),
        const Height(12),
        M3ESegmentedButton<String>(
          multiSelect: true,
          segments: const [
            M3ESegment(value: 'new', label: 'Новые'),
            M3ESegment(value: 'learning', label: 'Учу'),
            M3ESegment(value: 'done', label: 'Выучены'),
          ],
          selected: _multi,
          onSelectionChanged: (value) => setState(() => _multi = value),
        ),
      ],
    );
  }
}
