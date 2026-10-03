import 'package:material_3_expressive/material_3_expressive.dart';
import 'package:material_ui/material_ui.dart';
import 'package:quizzerg/feature/uikit_catalog/presentation/widgets/catalog_item.dart';
import 'package:quizzerg/uikit/spacing/height.dart';
import 'package:quizzerg/uikit/spacing/width.dart';

/// Индикаторы и ввод material_3_expressive: бейджи, прогресс, загрузка,
/// подсказки, текстовые поля и строка поиска.
class M3EFeedbackSection extends StatelessWidget {
  const M3EFeedbackSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CatalogItem(
          title: 'M3EBadge',
          description: 'Точка, счётчик, ограничение 999+ и текст',
          child: _BadgesDemo(),
        ),
        CatalogItem(
          title: 'M3EProgressIndicator',
          description: 'Circular и circularWavy: indeterminate и determinate',
          child: _CircularProgressDemo(),
        ),
        CatalogItem(
          title: 'M3EProgressIndicator',
          description: 'Linear и linearWavy: indeterminate и determinate',
          child: _LinearProgressDemo(),
        ),
        CatalogItem(
          title: 'M3ELoadingIndicator',
          description: 'Обычный, contained и увеличенный',
          child: _LoadingIndicatorDemo(),
        ),
        CatalogItem(
          title: 'M3ETooltip',
          description: 'Plain: долгое нажатие; rich persistent: тап',
          child: _TooltipDemo(),
        ),
        CatalogItem(
          title: 'M3ETextField',
          description: 'Filled и outlined, пароль, ошибка, счётчик, disabled',
          child: _TextFieldsDemo(),
        ),
        CatalogItem(
          title: 'M3ESearchBar',
          description: 'Строка поиска без перехода на экран результатов',
          child: _SearchBarDemo(),
        ),
      ],
    );
  }
}

class _BadgesDemo extends StatelessWidget {
  const _BadgesDemo();

  @override
  Widget build(BuildContext context) {
    return const Wrap(
      spacing: 32,
      runSpacing: 16,
      children: [
        M3EBadge(showDot: true, child: Icon(M3EIcons.notifications_none)),
        M3EBadge(count: 3, child: Icon(M3EIcons.mail_outline)),
        M3EBadge(count: 1200, child: Icon(M3EIcons.chat_bubble_outline)),
        M3EBadge(label: 'NEW', child: Icon(M3EIcons.style)),
      ],
    );
  }
}

class _CircularProgressDemo extends StatefulWidget {
  const _CircularProgressDemo();

  @override
  State<_CircularProgressDemo> createState() => _CircularProgressDemoState();
}

class _CircularProgressDemoState extends State<_CircularProgressDemo> {
  double _value = 0.6;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 24,
          runSpacing: 16,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            const M3EProgressIndicator.circular(),
            const M3EProgressIndicator.circularWavy(),
            M3EProgressIndicator.circular(value: _value),
            M3EProgressIndicator.circularWavy(value: _value),
            M3EProgressIndicator.circular(value: _value, showTrack: false),
          ],
        ),
        const Height(12),
        _ProgressValueSlider(
          value: _value,
          onChanged: (value) => setState(() => _value = value),
        ),
      ],
    );
  }
}

class _LinearProgressDemo extends StatefulWidget {
  const _LinearProgressDemo();

  @override
  State<_LinearProgressDemo> createState() => _LinearProgressDemoState();
}

class _LinearProgressDemoState extends State<_LinearProgressDemo> {
  double _value = 0.4;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const M3EProgressIndicator.linear(),
        const Height(16),
        const M3EProgressIndicator.linearWavy(),
        const Height(16),
        M3EProgressIndicator.linear(value: _value),
        const Height(16),
        M3EProgressIndicator.linearWavy(value: _value),
        const Height(16),
        M3EProgressIndicator.linear(
          value: _value,
          linearSize: M3EProgressIndicatorSize.s,
        ),
        const Height(12),
        _ProgressValueSlider(
          value: _value,
          onChanged: (value) => setState(() => _value = value),
        ),
      ],
    );
  }
}

class _ProgressValueSlider extends StatelessWidget {
  final double value;
  final ValueChanged<double> onChanged;

  const _ProgressValueSlider({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Width(48, child: Text('${(value * 100).round()}%')),
        Expanded(
          child: M3ESlider(
            value: value,
            semanticLabel: 'Прогресс',
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}

class _LoadingIndicatorDemo extends StatelessWidget {
  const _LoadingIndicatorDemo();

  @override
  Widget build(BuildContext context) {
    return const Wrap(
      spacing: 24,
      runSpacing: 16,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        M3ELoadingIndicator(),
        M3ELoadingIndicator(variant: M3ELoadingIndicatorVariant.contained),
        M3ELoadingIndicator(
          variant: M3ELoadingIndicatorVariant.contained,
          size: 96,
        ),
      ],
    );
  }
}

class _TooltipDemo extends StatelessWidget {
  const _TooltipDemo();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        M3ETooltip(
          message: 'Редактировать колоду',
          child: M3EIconButton(
            variant: M3EIconButtonVariant.tonal,
            icon: const Icon(M3EIcons.edit),
            onPressed: () {},
          ),
        ),
        const Width(24),
        M3ETooltip(
          persistent: true,
          richTitle: 'Интервальные повторения',
          richMessage:
              'Карточки возвращаются тем реже, чем лучше вы их '
              'помните.',
          actions: [
            M3EButton(
              style: M3EButtonStyle.text,
              onPressed: () {},
              child: const Text('Подробнее'),
            ),
          ],
          child: M3EIconButton(
            variant: M3EIconButtonVariant.outlined,
            icon: const Icon(M3EIcons.info_outline),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}

class _TextFieldsDemo extends StatefulWidget {
  const _TextFieldsDemo();

  @override
  State<_TextFieldsDemo> createState() => _TextFieldsDemoState();
}

class _TextFieldsDemoState extends State<_TextFieldsDemo> {
  String? _emailError;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const M3ETextField(
          label: 'Название колоды',
          supportingText: 'Filled, с кнопкой очистки',
          showClearButton: true,
        ),
        const Height(16),
        const M3ETextField(
          variant: M3ETextFieldVariant.outlined,
          label: 'Поиск',
          leading: Icon(M3EIcons.search),
          supportingText: 'Outlined с иконкой',
        ),
        const Height(16),
        const M3ETextField(
          variant: M3ETextFieldVariant.outlined,
          label: 'Пароль',
          obscureText: true,
          showPasswordToggle: true,
        ),
        const Height(16),
        M3ETextField(
          label: 'Email',
          isRequired: true,
          keyboardType: TextInputType.emailAddress,
          supportingText: 'Ошибка, пока нет символа @',
          errorText: _emailError,
          onChanged: _validateEmail,
        ),
        const Height(16),
        const M3ETextField(
          variant: M3ETextFieldVariant.outlined,
          label: 'Цена',
          prefixText: '₽ ',
          suffixText: 'в месяц',
          keyboardType: TextInputType.number,
        ),
        const Height(16),
        const M3ETextField(
          label: 'Заметка',
          maxLength: 40,
          showCounter: true,
          maxLines: 3,
          minLines: 2,
        ),
        const Height(16),
        const M3ETextField(label: 'Disabled', enabled: false),
      ],
    );
  }

  void _validateEmail(String value) {
    final error = value.isEmpty || value.contains('@')
        ? null
        : 'Введите корректный email';
    if (error != _emailError) setState(() => _emailError = error);
  }
}

class _SearchBarDemo extends StatelessWidget {
  const _SearchBarDemo();

  @override
  Widget build(BuildContext context) {
    return M3ESearchBar(
      hintText: 'Поиск по карточкам',
      showClearButton: true,
      leading: const Icon(M3EIcons.search),
      trailing: [
        M3EIconButton(
          variant: M3EIconButtonVariant.standard,
          icon: const Icon(M3EIcons.mic_none),
          onPressed: () {},
        ),
      ],
    );
  }
}
