import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:quizzerg/core/services/csv_import_service.dart';
import 'package:quizzerg/l10n/app_localizations_x.dart';
import 'package:quizzerg/uikit/app_radii.dart';
import 'package:quizzerg/uikit/dialogs/app_dialog.dart';
import 'package:quizzerg/uikit/fields/karto4ki_text_field.dart';
import 'package:quizzerg/uikit/spacing/height.dart';

/// CSV import dialog result.
typedef CsvImportDialogResult = ({List<String> files, String delimiter});

/// File and delimiter picker dialog for CSV import.
class CsvImportDialog extends StatefulWidget {
  final ICsvImportService csvImportService;

  const CsvImportDialog({
    required this.csvImportService,
    super.key,
  });

  @override
  State<CsvImportDialog> createState() => _CsvImportDialogState();
}

class _CsvImportDialogState extends State<CsvImportDialog> {
  final _delimiterController = TextEditingController(text: ';');
  final _selectedFiles = <String>[];

  @override
  void dispose() {
    _delimiterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final canImport =
        _selectedFiles.isNotEmpty && _delimiterController.text.isNotEmpty;

    return AppDialog(
      title: _DialogTitle(text: l10n.csvImportDialogTitle),
      content: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Text(
                  l10n.csvImportDialogDescription,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
                const Height(14),
                _ExampleBlock(text: l10n.csvImportDialogExample),
                const Height(16),
                Karto4kiTextField(
                  controller: _delimiterController,
                  labelText: l10n.csvImportDelimiterLabel,
                  hintText: l10n.csvImportDelimiterHint,
                  inputFormatters: [LengthLimitingTextInputFormatter(2)],
                  onChanged: (_) => setState(() {}),
                ),
                if (_selectedFiles.isNotEmpty) ...[
                  const Height(12),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _selectedFiles.length,
                    itemBuilder: (context, index) {
                      final path = _selectedFiles[index];
                      return _FileListItem(
                        fileName: _baseName(path),
                        onRemove: () => setState(
                          () => _selectedFiles.removeAt(index),
                        ),
                      );
                    },
                  ),
                ],
                const Height(16),
                _FileDropZone(
                  hasFiles: _selectedFiles.isNotEmpty,
                  onAddFiles: _onAddFiles,
                ),
              ],
            ),
          ),
        ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.csvImportDialogCancel),
        ),
        TextButton(
          onPressed: canImport
              ? () => Navigator.of(context).pop(
                    (
                      files: List<String>.of(_selectedFiles),
                      delimiter: _delimiterController.text,
                    ),
                  )
              : null,
          child: Text(l10n.csvImportDialogContinue),
        ),
      ],
    );
  }

  Future<void> _onAddFiles() async {
    final paths = await widget.csvImportService.pickFiles();
    if (paths == null || paths.isEmpty) return;

    setState(() {
      for (final path in paths) {
        if (!_selectedFiles.contains(path)) {
          _selectedFiles.add(path);
        }
      }
    });
  }

  String _baseName(String path) {
    final separator = path.contains(r'\') ? r'\' : '/';
    return path.split(separator).last;
  }
}

class _ExampleBlock extends StatelessWidget {
  final String text;

  const _ExampleBlock({required this.text});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppDimens.radius12),
      ),
      child: Text(
        text,
        style: theme.textTheme.bodySmall?.copyWith(
          fontFamily: 'monospace',
          height: 1.6,
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}

/// Заголовок диалога импорта: плашка-иконка + текст в две строки.
class _DialogTitle extends StatelessWidget {
  final String text;

  const _DialogTitle({required this.text});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(AppDimens.radius12),
          ),
          child: Icon(
            Icons.upload_file,
            size: 24,
            color: colorScheme.onPrimaryContainer,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
      ],
    );
  }
}

/// Пунктирная зона выбора файлов с outlined-кнопкой.
class _FileDropZone extends StatelessWidget {
  final bool hasFiles;
  final VoidCallback onAddFiles;

  const _FileDropZone({
    required this.hasFiles,
    required this.onAddFiles,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = context.l10n;

    return SizedBox(
      width: double.infinity,
      child: CustomPaint(
        painter: _DashedBorderPainter(
          color: colorScheme.outline,
          radius: AppDimens.radius12,
        ),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
            Icon(Icons.add_circle, size: 28, color: colorScheme.primary),
            const Height(10),
            if (!hasFiles) ...[
              Text(
                l10n.csvImportNoFiles,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
              ),
              const Height(10),
            ],
            OutlinedButton.icon(
              onPressed: onAddFiles,
              icon: const Icon(Icons.attach_file, size: 18),
              label: Text(l10n.csvImportAddFiles),
            ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Рисует пунктирную рамку со скруглёнными углами.
class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double radius;

  const _DashedBorderPainter({
    required this.color,
    required this.radius,
  });

  static const _dashWidth = 6.0;
  static const _dashGap = 4.0;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final rrect = RRect.fromRectAndRadius(
      Offset.zero & size,
      Radius.circular(radius),
    );
    final path = Path()..addRRect(rrect);

    for (final metric in path.computeMetrics()) {
      var distance = 0.0;
      while (distance < metric.length) {
        final end = distance + _dashWidth;
        canvas.drawPath(
          metric.extractPath(distance, end.clamp(0, metric.length)),
          paint,
        );
        distance = end + _dashGap;
      }
    }
  }

  @override
  bool shouldRepaint(_DashedBorderPainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.radius != radius;
}

class _FileListItem extends StatelessWidget {
  final String fileName;
  final VoidCallback onRemove;

  const _FileListItem({
    required this.fileName,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.insert_drive_file_outlined, size: 16),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            fileName,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        IconButton(
          onPressed: onRemove,
          icon: const Icon(Icons.close, size: 16),
          constraints: const BoxConstraints(),
          padding: const EdgeInsets.all(4),
        ),
      ],
    );
  }
}
