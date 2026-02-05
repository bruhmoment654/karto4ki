import 'dart:io';

import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';

/// Result of CSV import operation.
sealed class CsvImportResult {
  const CsvImportResult();
}

/// Successful import with parsed card data.
final class CsvImportSuccess extends CsvImportResult {
  /// List of parsed cards as (front, back) pairs.
  final List<({String front, String back})> cards;

  const CsvImportSuccess(this.cards);
}

/// Import was cancelled by user.
final class CsvImportCancelled extends CsvImportResult {
  const CsvImportCancelled();
}

/// Import failed with error.
final class CsvImportError extends CsvImportResult {
  final CsvImportErrorType type;
  final String? details;

  const CsvImportError(this.type, [this.details]);
}

/// Types of CSV import errors.
enum CsvImportErrorType {
  /// File is empty or contains no data rows.
  empty,

  /// Invalid CSV format (less than 2 columns).
  invalidFormat,

  /// Could not read the file.
  readError,
}

/// Service for importing cards from CSV files.
abstract interface class ICsvImportService {
  /// Pick a CSV file and parse it into card data.
  ///
  /// Returns [CsvImportSuccess] with parsed cards,
  /// [CsvImportCancelled] if user cancelled file picker,
  /// or [CsvImportError] if parsing failed.
  Future<CsvImportResult> pickAndParseFile();
}

/// Implementation of [ICsvImportService].
class CsvImportService implements ICsvImportService {
  const CsvImportService();

  @override
  Future<CsvImportResult> pickAndParseFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['csv'],
        allowMultiple: false,
      );

      if (result == null || result.files.isEmpty) {
        return const CsvImportCancelled();
      }

      final file = result.files.first;
      final filePath = file.path;

      if (filePath == null) {
        return const CsvImportError(CsvImportErrorType.readError);
      }

      final content = await File(filePath).readAsString();

      if (content.trim().isEmpty) {
        return const CsvImportError(CsvImportErrorType.empty);
      }

      final rows = const CsvToListConverter(
        fieldDelimiter: ';',
        shouldParseNumbers: false,
        allowInvalid: true,
      ).convert(content);

      if (rows.isEmpty) {
        return const CsvImportError(CsvImportErrorType.empty);
      }

      final cards = <({String front, String back})>[];

      for (final row in rows) {
        if (row.length < 2) {
          continue;
        }

        final front = row[0]?.toString().trim() ?? '';
        final back = row[1]?.toString().trim() ?? '';

        if (front.isEmpty && back.isEmpty) {
          continue;
        }

        cards.add((front: front, back: back));
      }

      if (cards.isEmpty) {
        return const CsvImportError(CsvImportErrorType.empty);
      }

      return CsvImportSuccess(cards);
    } on FileSystemException catch (e) {
      return CsvImportError(CsvImportErrorType.readError, e.message);
    } on FormatException catch (e) {
      return CsvImportError(CsvImportErrorType.invalidFormat, e.message);
    } on Object catch (e) {
      return CsvImportError(CsvImportErrorType.readError, e.toString());
    }
  }
}
