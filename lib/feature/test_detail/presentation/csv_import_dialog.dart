import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:quizzerg/core/services/csv_import_service.dart';
import 'package:quizzerg/l10n/app_localizations_x.dart';
import 'package:quizzerg/uikit/dialogs/app_dialog.dart';

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
      title: Text(l10n.csvImportDialogTitle),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.csvImportDialogDescription),
            const SizedBox(height: 16),
            TextField(
              controller: _delimiterController,
              decoration: InputDecoration(
                labelText: l10n.csvImportDelimiterLabel,
                hintText: l10n.csvImportDelimiterHint,
              ),
              inputFormatters: [LengthLimitingTextInputFormatter(2)],
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 16),
            Text(
              l10n.csvImportFilesTitle,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            if (_selectedFiles.isEmpty)
              Text(
                l10n.csvImportNoFiles,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              )
            else
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 150),
                child: ListView.builder(
                  shrinkWrap: true,
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
              ),
            const SizedBox(height: 8),
            TextButton.icon(
              onPressed: _onAddFiles,
              icon: const Icon(Icons.add, size: 18),
              label: Text(l10n.csvImportAddFiles),
            ),
          ],
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
