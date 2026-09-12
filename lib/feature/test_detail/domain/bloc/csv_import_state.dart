part of 'csv_import_bloc.dart';

/// Черновик и результат импорта из CSV.
@freezed
sealed class CsvImportState with _$CsvImportState {
  const CsvImportState._();

  const factory CsvImportState({
    /// Выбранные пути к файлам.
    @Default(<String>[]) List<String> files,

    /// Разделитель колонок.
    @Default(';') String delimiter,

    /// Идёт разбор файлов.
    @Default(false) bool isParsing,

    /// Сколько файлов участвовало в последнем разборе — нужно для сообщения.
    @Default(0) int fileCount,

    /// Одноразовый результат разбора.
    SideEffectValue<CsvImportResult>? result,
  }) = _CsvImportState;

  /// Можно ли запускать разбор.
  bool get canImport => files.isNotEmpty && delimiter.isNotEmpty;
}
