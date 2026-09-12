part of 'csv_import_bloc.dart';

/// События импорта карточек из CSV.
@freezed
sealed class CsvImportEvent with _$CsvImportEvent {
  /// Сбросить черновик перед новым открытием диалога.
  const factory CsvImportEvent.reset() = _CsvImportEvent$Reset;

  /// Открыть системный выбор файлов.
  const factory CsvImportEvent.filesPickRequested() =
      _CsvImportEvent$FilesPickRequested;

  /// Убрать файл из списка.
  const factory CsvImportEvent.fileRemoved({
    required int index,
  }) = _CsvImportEvent$FileRemoved;

  /// Изменить разделитель колонок.
  const factory CsvImportEvent.delimiterChanged({
    required String delimiter,
  }) = _CsvImportEvent$DelimiterChanged;

  /// Разобрать выбранные файлы.
  const factory CsvImportEvent.importRequested() =
      _CsvImportEvent$ImportRequested;
}
