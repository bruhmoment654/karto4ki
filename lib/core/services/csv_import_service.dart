import 'dart:io';

import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';

/// CSV import result.
sealed class CsvImportResult {
  const CsvImportResult();
}

/// Successful import.
final class CsvImportSuccess extends CsvImportResult {
  final List<({String front, String back})> cards;

  const CsvImportSuccess(this.cards);
}

/// Partial success — some files could not be processed.
final class CsvImportPartialSuccess extends CsvImportResult {
  final List<({String front, String back})> cards;
  final List<String> failedFiles;

  const CsvImportPartialSuccess(this.cards, this.failedFiles);
}

/// Import cancelled by user.
final class CsvImportCancelled extends CsvImportResult {
  const CsvImportCancelled();
}

/// Import error.
final class CsvImportError extends CsvImportResult {
  final CsvImportErrorType type;
  final String? details;

  const CsvImportError(this.type, [this.details]);
}

/// CSV import error types.
enum CsvImportErrorType {
  empty,
  invalidFormat,
  readError,
}

/// Card import service from CSV files.
abstract interface class ICsvImportService {
  /// Pick one or more CSV files.
  /// Returns a list of paths or null if cancelled.
  Future<List<String>?> pickFiles();

  /// Parses a list of files with the given delimiter.
  /// Merges cards from all files into a single list.
  Future<CsvImportResult> parseFiles(
    List<String> filePaths,
    String delimiter,
  );
}

/// [ICsvImportService] implementation.
class CsvImportService implements ICsvImportService {
  const CsvImportService();

  @override
  Future<List<String>?> pickFiles() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv', 'txt', 'tsv'],
      allowMultiple: true,
    );

    if (result == null || result.files.isEmpty) {
      return null;
    }

    return result.files
        .where((f) => f.path != null)
        .map((f) => f.path!)
        .toList();
  }

  @override
  Future<CsvImportResult> parseFiles(
    List<String> filePaths,
    String delimiter,
  ) async {
    final allCards = <({String front, String back})>[];
    final failedFiles = <String>[];

    for (final filePath in filePaths) {
      try {
        final content = await File(filePath).readAsString();

        if (content.trim().isEmpty) {
          failedFiles.add(_baseName(filePath));
          continue;
        }

        final rows = CsvToListConverter(
          fieldDelimiter: delimiter,
          shouldParseNumbers: false,
          allowInvalid: true,
        ).convert(content);

        if (rows.isEmpty) {
          failedFiles.add(_baseName(filePath));
          continue;
        }

        var hasValidRows = false;
        for (final row in rows) {
          if (row.length < 2) continue;

          final front = row[0]?.toString().trim() ?? '';
          final back = row[1]?.toString().trim() ?? '';

          if (front.isEmpty && back.isEmpty) continue;

          allCards.add((front: front, back: back));
          hasValidRows = true;
        }

        if (!hasValidRows) {
          failedFiles.add(_baseName(filePath));
        }
      } on Object {
        failedFiles.add(_baseName(filePath));
      }
    }

    if (allCards.isEmpty) {
      if (failedFiles.isNotEmpty) {
        return const CsvImportError(CsvImportErrorType.empty);
      }
      return const CsvImportError(CsvImportErrorType.empty);
    }

    if (failedFiles.isNotEmpty) {
      return CsvImportPartialSuccess(allCards, failedFiles);
    }

    return CsvImportSuccess(allCards);
  }

  String _baseName(String path) {
    final separator = path.contains(r'\') ? r'\' : '/';
    return path.split(separator).last;
  }
}
