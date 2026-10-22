import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizzerg/core/bloc/state_streamable_builder.dart';
import 'package:quizzerg/feature/mixup/domain/bloc/mixup_bloc.dart';
import 'package:quizzerg/feature/tinder_test/domain/mixup/mixup_algorithm.dart';
import 'package:quizzerg/l10n/app_localizations_x.dart';
import 'package:quizzerg/uikit/app_radii.dart';
import 'package:quizzerg/uikit/dropdown/app_dropdown.dart';
import 'package:quizzerg/uikit/fields/karto4ki_text_field.dart';
import 'package:quizzerg/uikit/slider/app_range_slider.dart';
import 'package:quizzerg/uikit/spacing/height.dart';
import 'package:quizzerg/uikit/spacing/width.dart';
import 'package:quizzerg/uikit/switch/app_switch.dart';

/// Шторка настроек подмешивания вопросов.
///
/// Настройки глобальные (`MixupBloc` → настройки приложения), а не на
/// группу. `MixupBloc` должен быть выше по дереву шторки — её маршрут
/// открывается поверх экрана, поэтому блок передаётся через
/// `BlocProvider.value`.
class GroupMixupSheet extends StatefulWidget {
  const GroupMixupSheet({super.key});

  @override
  State<GroupMixupSheet> createState() => _GroupMixupSheetState();
}

class _GroupMixupSheetState extends State<GroupMixupSheet> {
  static const _defaultStreakValue = 0.35;
  static const _resizeDuration = Duration(milliseconds: 500);

  late final TextEditingController _negativeBonusController;
  late final TextEditingController _positivePenaltyController;

  MixupBloc get _bloc => context.read<MixupBloc>();

  @override
  void initState() {
    super.initState();
    final state = _bloc.state;
    _negativeBonusController = TextEditingController(
      text: state.streakNegativeBonus.toStringAsFixed(2),
    );
    _positivePenaltyController = TextEditingController(
      text: state.streakPositivePenalty.toStringAsFixed(2),
    );
  }

  @override
  void dispose() {
    _negativeBonusController.dispose();
    _positivePenaltyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(
        left: 8,
        right: 8,
        // Клавиатура или системная навигация: padding обнуляется, когда
        // клавиатура перекрывает её зону, поэтому сумма не двоится.
        bottom: MediaQuery.viewInsetsOf(context).bottom +
            MediaQuery.paddingOf(context).bottom +
            24,
      ),
      child: SingleChildScrollView(
        child: StateStreamableBuilder<MixupState>(
          bloc: _bloc,
          builder: (context, state) {
            final showStreak =
                state.enabled && state.algorithm == MixupAlgorithm.scoring;

            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    context.l10n.groupDetailSettingsSheetTitle,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Height(4),
                _MixupToggle(
                  value: state.enabled,
                  onChanged: (value) =>
                      _bloc.add(MixupEvent.toggled(enabled: value)),
                ),
                AnimatedSize(
                  duration: _resizeDuration,
                  curve: Curves.fastEaseInToSlowEaseOut,
                  alignment: Alignment.topCenter,
                  child: state.enabled
                      ? Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const _SheetDivider(),
                            _MixupAlgorithmSelector(
                              algorithm: state.algorithm,
                              onChanged: (algorithm) => _bloc.add(
                                MixupEvent.algorithmChanged(
                                  algorithm: algorithm,
                                ),
                              ),
                            ),
                            const _SheetDivider(),
                            _MixupCountSlider(
                              min: state.mixupMin,
                              max: state.mixupMax,
                              onChanged: ({required min, required max}) =>
                                  _bloc.add(
                                    MixupEvent.rangeChanged(min: min, max: max),
                                  ),
                            ),
                          ],
                        )
                      : const SizedBox(width: double.infinity),
                ),
                AnimatedSize(
                  duration: _resizeDuration,
                  curve: Curves.fastEaseInToSlowEaseOut,
                  alignment: Alignment.topCenter,
                  child: showStreak
                      ? Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const _SheetDivider(),
                            _StreakCoefficientsEditor(
                              negativeBonusController: _negativeBonusController,
                              positivePenaltyController:
                                  _positivePenaltyController,
                              onSubmitted: _onStreakSubmitted,
                              onReset: _onStreakReset,
                            ),
                          ],
                        )
                      : const SizedBox(width: double.infinity),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _onStreakSubmitted() {
    final negative =
        double.tryParse(_negativeBonusController.text) ?? _defaultStreakValue;
    final positive =
        double.tryParse(_positivePenaltyController.text) ?? _defaultStreakValue;
    _bloc.add(
      MixupEvent.streakCoefficientsChanged(
        negativeBonus: negative.clamp(0.0, 1.0),
        positivePenalty: positive.clamp(0.0, 1.0),
      ),
    );
  }

  void _onStreakReset() {
    final text = _defaultStreakValue.toStringAsFixed(2);
    _negativeBonusController.text = text;
    _positivePenaltyController.text = text;
    _bloc.add(
      const MixupEvent.streakCoefficientsChanged(
        negativeBonus: _defaultStreakValue,
        positivePenalty: _defaultStreakValue,
      ),
    );
  }
}

class _SheetDivider extends StatelessWidget {
  const _SheetDivider();

  @override
  Widget build(BuildContext context) =>
      const Divider(height: 1, indent: 16, endIndent: 16);
}

class _MixupCountSlider extends StatelessWidget {
  final int min;
  final int max;
  final void Function({required int min, required int max}) onChanged;

  const _MixupCountSlider({
    required this.min,
    required this.max,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.l10n.groupDetailMixupCountLabel,
                style: theme.textTheme.titleMedium,
              ),
              Text(
                '$min–$max',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.primary,
                ),
              ),
            ],
          ),
          AppRangeSlider(
            values: RangeValues(min.toDouble(), max.toDouble()),
            min: 1,
            max: 20,
            divisions: 19,
            labels: RangeLabels('$min', '$max'),
            onChanged: (values) {
              onChanged(min: values.start.round(), max: values.end.round());
            },
          ),
        ],
      ),
    );
  }
}

class _MixupAlgorithmSelector extends StatelessWidget {
  final MixupAlgorithm algorithm;
  final ValueChanged<MixupAlgorithm> onChanged;

  const _MixupAlgorithmSelector({
    required this.algorithm,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final classicText = context.l10n.groupDetailMixupAlgorithmClassic;
    final scoringText = context.l10n.groupDetailMixupAlgorithmScoring;
    final currentText = algorithm == MixupAlgorithm.classic
        ? classicText
        : scoringText;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              context.l10n.groupDetailMixupAlgorithm,
              style: theme.textTheme.titleMedium,
            ),
          ),
          PopupMenuButton<MixupAlgorithm>(
            initialValue: algorithm,
            onSelected: onChanged,
            position: PopupMenuPosition.under,
            itemBuilder: (_) => [
              PopupMenuItem(
                value: MixupAlgorithm.classic,
                child: Text(classicText),
              ),
              PopupMenuItem(
                value: MixupAlgorithm.scoring,
                child: Text(scoringText),
              ),
            ],
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(AppDimens.radius8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    currentText,
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    size: 20,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StreakCoefficientsEditor extends StatelessWidget {
  final TextEditingController negativeBonusController;
  final TextEditingController positivePenaltyController;
  final VoidCallback onSubmitted;
  final VoidCallback onReset;

  const _StreakCoefficientsEditor({
    required this.negativeBonusController,
    required this.positivePenaltyController,
    required this.onSubmitted,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final labelStyle = Theme.of(
      context,
    ).textTheme.bodySmall?.copyWith(color: colorScheme.onSurfaceVariant);
    return AppDropdown(
      title: context.l10n.groupDetailStreakCoefficients,
      leading: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: colorScheme.tertiaryContainer,
          borderRadius: BorderRadius.circular(AppDimens.radius12),
        ),
        child: Icon(
          Icons.local_fire_department,
          size: 22,
          color: colorScheme.onTertiaryContainer,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10n.groupDetailStreakNegativeBonus,
                  style: labelStyle,
                ),
                const Height(4),
                SizedBox(
                  width: 56,
                  child: Karto4kiTextField(
                    controller: negativeBonusController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    textAlign: TextAlign.center,
                    textStyle: Theme.of(context).textTheme.bodyMedium,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    onEditingComplete: onSubmitted,
                    onTapOutside: (_) {
                      FocusScope.of(context).unfocus();
                      onSubmitted();
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10n.groupDetailStreakPositivePenalty,
                  style: labelStyle,
                ),
                const Height(4),
                SizedBox(
                  width: 56,
                  child: Karto4kiTextField(
                    controller: positivePenaltyController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    textAlign: TextAlign.center,
                    textStyle: Theme.of(context).textTheme.bodyMedium,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    onEditingComplete: onSubmitted,
                    onTapOutside: (_) {
                      FocusScope.of(context).unfocus();
                      onSubmitted();
                    },
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onReset,
            icon: const Icon(Icons.restart_alt, size: 20),
            tooltip: context.l10n.groupDetailStreakReset,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
          ),
        ],
      ),
    );
  }
}

class _MixupToggle extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const _MixupToggle({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10n.groupDetailMixup,
                  style: theme.textTheme.titleMedium,
                ),
                const Height(3),
                Text(
                  context.l10n.groupDetailMixupDescription,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const Width(14),
          AppSwitch(value: value, onChanged: onChanged),
        ],
      ),
    );
  }
}
