import 'package:flutter/material.dart';
import 'package:quizzerg/feature/developer/presentation/developer_debug_screen.dart';
import 'package:quizzerg/uikit/app_radii.dart';
import 'package:quizzerg/uikit/appbar/karto4ki_app_bar.dart';
import 'package:quizzerg/uikit/buttons/karto4ki_button.dart';
import 'package:quizzerg/uikit/content_card/content_card.dart';
import 'package:quizzerg/uikit/fields/karto4ki_text_field.dart';
import 'package:quizzerg/uikit/scaffold/app_scaffold.dart';
import 'package:quizzerg/uikit/spacing/height.dart';

/// UI дебаг-экрана. Строки не локализуются — экран только для разработки.
class DeveloperDebugView extends StatelessWidget {
  final IDeveloperDebugViewModel viewModel;

  const DeveloperDebugView({required this.viewModel, super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: DefaultAppBar.withBack(
        title: const Text('Дебаг'),
        onBackPressed: viewModel.onBackPressed,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        children: [
          _EnvironmentCard(baseUrl: viewModel.baseUrl),
          const Height(16),
          _ProxyCard(viewModel: viewModel),
        ],
      ),
    );
  }
}

/// Текущее окружение — чтобы не гадать, куда именно уходят запросы.
class _EnvironmentCard extends StatelessWidget {
  final String baseUrl;

  const _EnvironmentCard({required this.baseUrl});

  @override
  Widget build(BuildContext context) {
    return _DebugCard(
      icon: Icons.dns_outlined,
      title: 'Окружение',
      children: [
        SelectableText(baseUrl, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}

class _ProxyCard extends StatelessWidget {
  final IDeveloperDebugViewModel viewModel;

  const _ProxyCard({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final savedProxyUrl = viewModel.savedProxyUrl;

    return _DebugCard(
      icon: Icons.swap_horiz,
      title: 'Прокси',
      fadeInDelay: const Duration(milliseconds: 80),
      children: [
        Text(
          'Адрес снифера в формате host:port. Уже открытые соединения берутся '
          'из пула — после смены прокси надёжнее перезапустить приложение.',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const Height(16),
        Karto4kiTextField(
          controller: viewModel.proxyController,
          labelText: 'Прокси',
          hintText: '192.168.0.2:8888',
          keyboardType: TextInputType.url,
          textInputAction: TextInputAction.done,
          onEditingComplete: viewModel.onApplyProxyPressed,
        ),
        const Height(16),
        Karto4kiButton(
          label: 'Подключить',
          icon: Icons.check,
          isExpanded: true,
          onPressed: viewModel.onApplyProxyPressed,
        ),
        const Height(8),
        Karto4kiButton(
          label: 'Выключить',
          icon: Icons.close,
          isExpanded: true,
          variant: Karto4kiButtonVariant.ghost,
          onPressed: viewModel.onClearProxyPressed,
        ),
        const Height(12),
        Text(
          savedProxyUrl == null
              ? 'Сейчас: прокси выключен'
              : 'Сейчас: $savedProxyUrl',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

/// Карточка-блок дебаг-экрана: иконка, заголовок и содержимое.
class _DebugCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final List<Widget> children;
  final Duration fadeInDelay;

  const _DebugCard({
    required this.icon,
    required this.title,
    required this.children,
    this.fadeInDelay = Duration.zero,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ContentCard(
      fadeIn: true,
      fadeInDelay: fadeInDelay,
      borderRadius: BorderRadius.circular(AppDimens.radius28),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: theme.colorScheme.primary),
              const SizedBox(width: 12),
              Text(title, style: theme.textTheme.titleMedium),
            ],
          ),
          const Height(16),
          ...children,
        ],
      ),
    );
  }
}
