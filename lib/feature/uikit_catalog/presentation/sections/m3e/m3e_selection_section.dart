import 'package:material_3_expressive/material_3_expressive.dart';
import 'package:material_ui/material_ui.dart';
import 'package:quizzerg/feature/uikit_catalog/presentation/widgets/catalog_item.dart';
import 'package:quizzerg/uikit/spacing/height.dart';
import 'package:quizzerg/uikit/spacing/width.dart';

/// Элементы выбора material_3_expressive: чекбоксы, радио, свитчи, чипы,
/// слайдеры и выпадающие меню.
class M3ESelectionSection extends StatelessWidget {
  const M3ESelectionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CatalogItem(
          title: 'M3ECheckbox',
          description: 'Обычный, tristate, error и disabled',
          child: _CheckboxDemo(),
        ),
        CatalogItem(
          title: 'M3ERadio + M3ERadioGroup',
          description: 'Группа со стрелками на клавиатуре, error и disabled',
          child: _RadioDemo(),
        ),
        CatalogItem(
          title: 'M3ESwitch',
          description: 'Без иконки, с иконками и disabled',
          child: _SwitchDemo(),
        ),
        CatalogItem(
          title: 'M3EChip',
          description: 'Assist: обычный, elevated и disabled',
          child: _AssistChips(),
        ),
        CatalogItem(
          title: 'M3EChip',
          description: 'Filter: множественный выбор',
          child: _FilterChips(),
        ),
        CatalogItem(
          title: 'M3EChip',
          description: 'Input: удаление по крестику',
          child: _InputChips(),
        ),
        CatalogItem(
          title: 'M3EChip',
          description: 'Suggestion: подсказки',
          child: _SuggestionChips(),
        ),
        CatalogItem(
          title: 'M3ESlider',
          description: 'Размеры xs, s, m, l, xl',
          child: _SliderSizes(),
        ),
        CatalogItem(
          title: 'M3ESlider',
          description: 'divisions + label, centered, wavy, vertical',
          child: _SliderVariants(),
        ),
        CatalogItem(
          title: 'M3ERangeSlider',
          description: 'Обычный с divisions и wavy',
          child: _RangeSliderDemo(),
        ),
        CatalogItem(
          title: 'M3EDropdownMenu',
          description: 'Одиночный выбор и множественный с поиском',
          child: _DropdownDemo(),
        ),
      ],
    );
  }
}

class _CheckboxDemo extends StatefulWidget {
  const _CheckboxDemo();

  @override
  State<_CheckboxDemo> createState() => _CheckboxDemoState();
}

class _CheckboxDemoState extends State<_CheckboxDemo> {
  bool _checked = true;
  bool? _tristate;
  bool _error = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        M3ECheckbox(
          value: _checked,
          label: const Text('Обычный'),
          onChanged: (value) => setState(() => _checked = value ?? false),
        ),
        M3ECheckbox(
          value: _tristate,
          tristate: true,
          label: const Text('Tristate: null → true → false'),
          onChanged: (value) => setState(() => _tristate = value),
        ),
        M3ECheckbox(
          value: _error,
          error: true,
          label: const Text('С ошибкой'),
          onChanged: (value) => setState(() => _error = value ?? false),
        ),
        const M3ECheckbox(
          value: true,
          label: Text('Disabled'),
          onChanged: null,
        ),
      ],
    );
  }
}

class _RadioDemo extends StatefulWidget {
  const _RadioDemo();

  @override
  State<_RadioDemo> createState() => _RadioDemoState();
}

class _RadioDemoState extends State<_RadioDemo> {
  static const _options = ['Легко', 'Нормально', 'Сложно'];

  String? _value = _options.first;

  @override
  Widget build(BuildContext context) {
    return M3ERadioGroup<String>(
      groupValue: _value,
      groupLabel: 'Сложность',
      onChanged: _select,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final option in _options)
            M3ERadio<String>(
              value: option,
              groupValue: _value,
              label: Text(option),
              onChanged: _select,
            ),
          M3ERadio<String>(
            value: 'error',
            groupValue: _value,
            error: true,
            label: const Text('С ошибкой'),
            onChanged: _select,
          ),
          M3ERadio<String>(
            value: 'disabled',
            groupValue: _value,
            label: const Text('Disabled'),
            onChanged: null,
          ),
        ],
      ),
    );
  }

  void _select(String value) => setState(() => _value = value);
}

class _SwitchDemo extends StatefulWidget {
  const _SwitchDemo();

  @override
  State<_SwitchDemo> createState() => _SwitchDemoState();
}

class _SwitchDemoState extends State<_SwitchDemo> {
  bool _plain = true;
  bool _withIcon = false;
  bool _withBothIcons = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SwitchRow(
          label: 'Без иконки',
          child: M3ESwitch(
            value: _plain,
            onChanged: (value) => setState(() => _plain = value),
          ),
        ),
        _SwitchRow(
          label: 'selectedIcon',
          child: M3ESwitch(
            value: _withIcon,
            selectedIcon: const Icon(M3EIcons.check),
            onChanged: (value) => setState(() => _withIcon = value),
          ),
        ),
        _SwitchRow(
          label: 'selectedIcon + unselectedIcon',
          child: M3ESwitch(
            value: _withBothIcons,
            selectedIcon: const Icon(M3EIcons.check),
            unselectedIcon: const Icon(M3EIcons.close),
            onChanged: (value) => setState(() => _withBothIcons = value),
          ),
        ),
        const _SwitchRow(
          label: 'Disabled',
          child: M3ESwitch(value: true, onChanged: null),
        ),
      ],
    );
  }
}

class _SwitchRow extends StatelessWidget {
  final String label;
  final Widget child;

  const _SwitchRow({required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          child,
          const Width(12),
          Expanded(child: Text(label)),
        ],
      ),
    );
  }
}

class _AssistChips extends StatelessWidget {
  const _AssistChips();

  @override
  Widget build(BuildContext context) {
    return M3EChipGroup(
      groupLabel: 'Assist',
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          M3EChip(
            label: 'Поделиться',
            leading: const Icon(M3EIcons.share),
            onPressed: () {},
          ),
          M3EChip(
            label: 'Elevated',
            leading: const Icon(M3EIcons.event),
            elevated: true,
            onPressed: () {},
          ),
          const M3EChip(label: 'Disabled', leading: Icon(M3EIcons.block)),
        ],
      ),
    );
  }
}

class _FilterChips extends StatefulWidget {
  const _FilterChips();

  @override
  State<_FilterChips> createState() => _FilterChipsState();
}

class _FilterChipsState extends State<_FilterChips> {
  static const _filters = ['Новые', 'На повторение', 'Сложные', 'Избранные'];

  final _selected = <String>{'Новые'};

  @override
  Widget build(BuildContext context) {
    return M3EChipGroup(
      groupLabel: 'Filter',
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          for (final filter in _filters)
            M3EChip(
              label: filter,
              type: M3EChipType.filter,
              selected: _selected.contains(filter),
              onPressed: () => _toggle(filter),
            ),
        ],
      ),
    );
  }

  void _toggle(String filter) {
    setState(() {
      if (!_selected.remove(filter)) _selected.add(filter);
    });
  }
}

class _InputChips extends StatefulWidget {
  const _InputChips();

  @override
  State<_InputChips> createState() => _InputChipsState();
}

class _InputChipsState extends State<_InputChips> {
  static const _initial = ['английский', 'испанский', 'немецкий'];

  final _tags = [..._initial];

  @override
  Widget build(BuildContext context) {
    return M3EChipGroup(
      groupLabel: 'Input',
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          for (final tag in _tags)
            M3EChip(
              label: tag,
              type: M3EChipType.input,
              leading: const Icon(M3EIcons.label_outline),
              onPressed: () {},
              onDeleted: () => setState(() => _tags.remove(tag)),
            ),
          M3EChip(
            label: 'С аватаром',
            type: M3EChipType.input,
            avatar: const _ChipAvatar(),
            selected: true,
            onPressed: () {},
          ),
          if (_tags.length < _initial.length)
            M3EChip(
              label: 'Вернуть',
              leading: const Icon(M3EIcons.undo),
              onPressed: _reset,
            ),
        ],
      ),
    );
  }

  void _reset() {
    setState(() {
      _tags
        ..clear()
        ..addAll(_initial);
    });
  }
}

class _ChipAvatar extends StatelessWidget {
  const _ChipAvatar();

  @override
  Widget build(BuildContext context) {
    final colorScheme = M3ETheme.of(context).colorScheme;

    return ColoredBox(
      color: colorScheme.tertiary,
      child: Center(
        child: Text(
          'А',
          style: TextStyle(fontSize: 12, color: colorScheme.onTertiary),
        ),
      ),
    );
  }
}

class _SuggestionChips extends StatelessWidget {
  const _SuggestionChips();

  @override
  Widget build(BuildContext context) {
    return M3EChipGroup(
      groupLabel: 'Suggestion',
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          for (final text in ['Учить 10 минут', 'Повторить вчерашнее'])
            M3EChip(
              label: text,
              type: M3EChipType.suggestion,
              onPressed: () {},
            ),
          M3EChip(
            label: 'Elevated',
            type: M3EChipType.suggestion,
            elevated: true,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class _SliderSizes extends StatefulWidget {
  const _SliderSizes();

  @override
  State<_SliderSizes> createState() => _SliderSizesState();
}

class _SliderSizesState extends State<_SliderSizes> {
  double _value = 0.4;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final size in M3ESliderSize.values) ...[
          Text(size.name),
          M3ESlider(
            value: _value,
            size: size,
            semanticLabel: size.name,
            onChanged: (value) => setState(() => _value = value),
          ),
          const Height(8),
        ],
      ],
    );
  }
}

class _SliderVariants extends StatefulWidget {
  const _SliderVariants();

  @override
  State<_SliderVariants> createState() => _SliderVariantsState();
}

class _SliderVariantsState extends State<_SliderVariants> {
  double _stepped = 0.6;
  double _centered = 0;
  double _wavy = 0.5;
  double _vertical = 0.7;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('divisions: 5 + label'),
        M3ESlider(
          value: _stepped,
          divisions: 5,
          label: '${(_stepped * 100).round()}%',
          onChanged: (value) => setState(() => _stepped = value),
        ),
        const Height(8),
        const Text('centered: от −1 до 1'),
        M3ESlider.centered(
          value: _centered,
          min: -1,
          onChanged: (value) => setState(() => _centered = value),
        ),
        const Height(8),
        const Text('wavy'),
        M3ESlider.wavy(
          value: _wavy,
          onChanged: (value) => setState(() => _wavy = value),
        ),
        const Height(8),
        const Text('vertical'),
        const Height(8),
        SizedBox(
          height: 180,
          child: M3ESlider.vertical(
            value: _vertical,
            onChanged: (value) => setState(() => _vertical = value),
          ),
        ),
      ],
    );
  }
}

class _RangeSliderDemo extends StatefulWidget {
  const _RangeSliderDemo();

  @override
  State<_RangeSliderDemo> createState() => _RangeSliderDemoState();
}

class _RangeSliderDemoState extends State<_RangeSliderDemo> {
  M3ESliderRange _range = const M3ESliderRange(0.2, 0.6);
  M3ESliderRange _wavyRange = const M3ESliderRange(0.3, 0.8);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        M3ERangeSlider(
          values: _range,
          divisions: 10,
          onChanged: (value) => setState(() => _range = value),
        ),
        const Height(8),
        M3ERangeSlider.wavy(
          values: _wavyRange,
          onChanged: (value) => setState(() => _wavyRange = value),
        ),
      ],
    );
  }
}

class _DropdownDemo extends StatelessWidget {
  static const _languages = [
    M3EDropdownItem(label: 'Английский', value: 'en'),
    M3EDropdownItem(label: 'Испанский', value: 'es'),
    M3EDropdownItem(label: 'Немецкий', value: 'de'),
    M3EDropdownItem(label: 'Французский', value: 'fr'),
    M3EDropdownItem(label: 'Японский', value: 'ja', disabled: true),
  ];

  const _DropdownDemo();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        M3EDropdownMenu<String>(
          singleSelect: true,
          items: _languages,
          fieldStyle: M3EDropdownFieldStyle(hintText: 'Язык карточек'),
        ),
        Height(12),
        M3EDropdownMenu<String>(
          searchEnabled: true,
          limit: 3,
          items: _languages,
          fieldStyle: M3EDropdownFieldStyle(hintText: 'До трёх языков'),
          searchStyle: M3EDropdownSearchStyle(hintText: 'Поиск'),
        ),
      ],
    );
  }
}
