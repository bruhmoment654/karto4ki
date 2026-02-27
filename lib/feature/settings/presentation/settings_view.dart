import 'package:flutter/material.dart';
import 'package:quizzerg/feature/settings/presentation/settings_screen.dart';
import 'package:quizzerg/l10n/app_localizations_x.dart';
import 'package:quizzerg/uikit/appbar/karto4ki_app_bar.dart';
import 'package:quizzerg/uikit/content_card/content_card.dart';
import 'package:quizzerg/uikit/content_card/content_card_type.dart';
import 'package:quizzerg/uikit/scaffold/app_scaffold.dart';
import 'package:quizzerg/uikit/slider/app_slider.dart';
import 'package:quizzerg/uikit/switch/app_switch.dart';

class SettingsView extends StatelessWidget {
  final ISettingsViewModel viewModel;

  const SettingsView({required this.viewModel, super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: DefaultAppBar(title: context.l10n.settingsTitle),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        children: [
          _ShaderAnimationCard(viewModel: viewModel),
          const SizedBox(height: 12),
          _AccentColorCard(viewModel: viewModel),
          const SizedBox(height: 12),
          _AnimationSpeedCard(viewModel: viewModel),
        ],
      ),
    );
  }
}

class _AccentColorCard extends StatelessWidget {
  final ISettingsViewModel viewModel;

  const _AccentColorCard({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ContentCard(
      elevation: 5,
      type: ContentCardType.smallWide,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.profileAccentColorTitle,
            style: theme.textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          _HueSlider(
            hue: viewModel.accentColorHue,
            previewColor: viewModel.previewAccentColor,
            onChanged: viewModel.onAccentColorHueChanged,
          ),
        ],
      ),
    );
  }
}

class _HueSlider extends StatelessWidget {
  final double hue;
  final Color previewColor;
  final ValueChanged<double> onChanged;

  const _HueSlider({
    required this.hue,
    required this.previewColor,
    required this.onChanged,
  });

  static const _thumbPadding = 20.0;
  static const _previewSize = 28.0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final trackWidth = constraints.maxWidth - 2 * _thumbPadding;
        final thumbX = _thumbPadding + (hue / 360) * trackWidth;

        return Column(
          children: [
            SizedBox(
              height: _previewSize + 4,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    left: thumbX - _previewSize / 2,
                    child: _ColorPreview(color: previewColor),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            Container(
              height: 12,
              margin: const EdgeInsets.symmetric(horizontal: _thumbPadding),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                gradient: LinearGradient(
                  colors: List.generate(
                    7,
                    (i) => HSLColor.fromAHSL(1, i * 60.0, 1, 0.57).toColor(),
                  ),
                ),
              ),
            ),
            AppSlider(
              value: hue,
              max: 360,
              onChanged: onChanged,
            ),
          ],
        );
      },
    );
  }
}

class _ColorPreview extends StatelessWidget {
  final Color color;

  const _ColorPreview({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _HueSlider._previewSize,
      height: _HueSlider._previewSize,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white24,
          width: 1.5,
        ),
      ),
    );
  }
}

class _ShaderAnimationCard extends StatelessWidget {
  final ISettingsViewModel viewModel;

  const _ShaderAnimationCard({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ContentCard(
      elevation: 5,
      type: ContentCardType.smallWide,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              context.l10n.profileShaderAnimationTitle,
              style: theme.textTheme.titleMedium,
            ),
          ),
          AppSwitch(
            value: viewModel.shaderAnimationEnabled,
            onChanged: (value) => viewModel.onShaderAnimationToggled(value: value),
          ),
        ],
      ),
    );
  }
}

class _AnimationSpeedCard extends StatelessWidget {
  final ISettingsViewModel viewModel;

  const _AnimationSpeedCard({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ContentCard(
      elevation: 5,
      type: ContentCardType.smallWide,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.profileAnimationSpeedTitle,
            style: theme.textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          AppSlider(
            value: viewModel.animationDurationMs.toDouble(),
            max: 1000,
            divisions: 10,
            onChanged: viewModel.onAnimationDurationChanged,
          ),
          const SizedBox(height: 4),
          Center(
            child: Text(
              context.l10n.profileAnimationDurationLabel(
                viewModel.animationDurationMs,
              ),
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
