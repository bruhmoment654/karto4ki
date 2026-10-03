import 'package:flutter/material.dart';
import 'package:quizzerg/feature/uikit_catalog/presentation/widgets/catalog_item.dart';
import 'package:quizzerg/uikit/dropdown/app_dropdown.dart';
import 'package:quizzerg/uikit/fields/karto4ki_text_field.dart';
import 'package:quizzerg/uikit/slider/app_range_slider.dart';
import 'package:quizzerg/uikit/slider/app_slider.dart';
import 'package:quizzerg/uikit/spacing/height.dart';
import 'package:quizzerg/uikit/switch/app_switch.dart';

/// Поля ввода, переключатели и слайдеры.
class InputsSection extends StatelessWidget {
  const InputsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CatalogItem(
          title: 'Karto4kiTextField',
          description:
              'Подсказка, иконка, ошибка, пароль, многострочное, '
              'disabled',
          child: _TextFields(),
        ),
        CatalogItem(title: 'AppSwitch', child: _SwitchDemo()),
        CatalogItem(
          title: 'AppSlider',
          description: '5 делений с подписью',
          child: _SliderDemo(),
        ),
        CatalogItem(title: 'AppRangeSlider', child: _RangeSliderDemo()),
        CatalogItem(
          title: 'AppDropdown',
          description: 'Им же свёрнуты секции каталога',
          child: AppDropdown(
            title: 'Развернуть',
            leading: Icon(Icons.expand_circle_down_outlined),
            child: Padding(
              padding: EdgeInsets.only(bottom: 12),
              child: Text('Содержимое дропдауна'),
            ),
          ),
        ),
      ],
    );
  }
}

class _TextFields extends StatelessWidget {
  const _TextFields();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Karto4kiTextField(
          labelText: 'Название',
          hintText: 'Например, «Английский»',
          helperText: 'Подсказка под полем',
        ),
        Height(12),
        Karto4kiTextField(hintText: 'Поиск', prefixIcon: Icon(Icons.search)),
        Height(12),
        Karto4kiTextField(
          labelText: 'С ошибкой',
          errorText: 'Поле обязательно',
        ),
        Height(12),
        Karto4kiTextField(labelText: 'Пароль', obscureText: true),
        Height(12),
        Karto4kiTextField(labelText: 'Описание', maxLines: 3),
        Height(12),
        Karto4kiTextField(labelText: 'Disabled', enabled: false),
      ],
    );
  }
}

class _SwitchDemo extends StatefulWidget {
  const _SwitchDemo();

  @override
  State<_SwitchDemo> createState() => _SwitchDemoState();
}

class _SwitchDemoState extends State<_SwitchDemo> {
  bool _value = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppSwitch(
          value: _value,
          onChanged: (value) => setState(() => _value = value),
        ),
        const Spacer(),
        const AppSwitch(value: false, onChanged: null),
      ],
    );
  }
}

class _SliderDemo extends StatefulWidget {
  const _SliderDemo();

  @override
  State<_SliderDemo> createState() => _SliderDemoState();
}

class _SliderDemoState extends State<_SliderDemo> {
  double _value = 0.4;

  @override
  Widget build(BuildContext context) {
    return AppSlider(
      value: _value,
      divisions: 5,
      label: _value.toStringAsFixed(1),
      onChanged: (value) => setState(() => _value = value),
    );
  }
}

class _RangeSliderDemo extends StatefulWidget {
  const _RangeSliderDemo();

  @override
  State<_RangeSliderDemo> createState() => _RangeSliderDemoState();
}

class _RangeSliderDemoState extends State<_RangeSliderDemo> {
  RangeValues _values = const RangeValues(0.2, 0.7);

  @override
  Widget build(BuildContext context) {
    return AppRangeSlider(
      values: _values,
      onChanged: (values) => setState(() => _values = values),
    );
  }
}
