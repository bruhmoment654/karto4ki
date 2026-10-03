import 'package:flutter/material.dart';
import 'package:quizzerg/feature/uikit_catalog/presentation/widgets/catalog_item.dart';
import 'package:quizzerg/uikit/app_radii.dart';
import 'package:quizzerg/uikit/buttons/app_fab.dart';
import 'package:quizzerg/uikit/buttons/app_glow_button.dart';
import 'package:quizzerg/uikit/buttons/karto4ki_button.dart';
import 'package:quizzerg/uikit/pressable/scale_pressable.dart';
import 'package:quizzerg/uikit/snackbars/snack_controller.dart';
import 'package:quizzerg/uikit/spacing/height.dart';

/// Кнопки и нажимаемые поверхности.
class ButtonsSection extends StatelessWidget {
  const ButtonsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CatalogItem(
          title: 'Karto4kiButton',
          description: 'Все варианты Karto4kiButtonVariant',
          child: _ButtonVariants(),
        ),
        const CatalogItem(
          title: 'Karto4kiButton',
          description: 'С иконкой, загрузка, disabled, isExpanded',
          child: _ButtonStates(),
        ),
        CatalogItem(
          title: 'AppGlowButton',
          description: 'Кнопка со свечением',
          child: AppGlowButton(
            onPressed: () => SnackController.show(context, 'AppGlowButton'),
            child: const Text('Светится'),
          ),
        ),
        CatalogItem(
          title: 'AppFloatingActionButton',
          description: 'Пружинно появляется через 250 мс',
          child: AppFloatingActionButton(
            label: 'Создать',
            onPressed: () => SnackController.show(context, 'FAB'),
          ),
        ),
        const CatalogItem(
          title: 'ScalePressable',
          description: 'Сжимается при нажатии',
          child: _PressableDemo(),
        ),
      ],
    );
  }
}

class _ButtonVariants extends StatelessWidget {
  const _ButtonVariants();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final variant in Karto4kiButtonVariant.values)
          Karto4kiButton(
            label: variant.name,
            variant: variant,
            onPressed: () => SnackController.show(context, variant.name),
          ),
      ],
    );
  }
}

class _ButtonStates extends StatelessWidget {
  const _ButtonStates();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            Karto4kiButton(
              label: 'С иконкой',
              icon: Icons.add,
              onPressed: () {},
            ),
            Karto4kiButton(
              label: 'Загрузка',
              isLoading: true,
              onPressed: () {},
            ),
            const Karto4kiButton(label: 'Disabled'),
          ],
        ),
        const Height(8),
        Karto4kiButton(
          label: 'isExpanded',
          isExpanded: true,
          variant: Karto4kiButtonVariant.outline,
          onPressed: () {},
        ),
      ],
    );
  }
}

class _PressableDemo extends StatefulWidget {
  const _PressableDemo();

  @override
  State<_PressableDemo> createState() => _PressableDemoState();
}

class _PressableDemoState extends State<_PressableDemo> {
  int _taps = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ScalePressable(
      onTap: () => setState(() => _taps++),
      onLongPress: () => setState(() => _taps = 0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: theme.colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(AppDimens.radius20),
        ),
        child: Text(
          'Нажатий: $_taps · лонг-тап сбрасывает',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onPrimaryContainer,
          ),
        ),
      ),
    );
  }
}
