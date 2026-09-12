import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quizzerg/core/bloc/side_effect_value.dart';
import 'package:quizzerg/core/services/csv_import_service.dart';

part 'csv_import_bloc.freezed.dart';
part 'csv_import_event.dart';
part 'csv_import_state.dart';

/// BLoC импорта карточек из CSV.
///
/// Владеет черновиком диалога (выбранные файлы и разделитель) и единственный
/// разговаривает с [ICsvImportService] — UI только шлёт события.
final class CsvImportBloc extends Bloc<CsvImportEvent, CsvImportState> {
  final ICsvImportService _csvImportService;

  CsvImportBloc({required ICsvImportService csvImportService})
      : _csvImportService = csvImportService,
        super(const CsvImportState()) {
    on<CsvImportEvent>(
      (event, emit) => switch (event) {
        _CsvImportEvent$Reset() => _onReset(event, emit),
        _CsvImportEvent$FilesPickRequested() =>
          _onFilesPickRequested(event, emit),
        _CsvImportEvent$FileRemoved() => _onFileRemoved(event, emit),
        _CsvImportEvent$DelimiterChanged() => _onDelimiterChanged(event, emit),
        _CsvImportEvent$ImportRequested() => _onImportRequested(event, emit),
      },
    );
  }

  void _onReset(_CsvImportEvent$Reset event, Emitter<CsvImportState> emit) {
    emit(const CsvImportState());
  }

  Future<void> _onFilesPickRequested(
    _CsvImportEvent$FilesPickRequested event,
    Emitter<CsvImportState> emit,
  ) async {
    final paths = await _csvImportService.pickFiles();
    if (paths == null || paths.isEmpty) return;

    final files = List<String>.of(state.files);
    for (final path in paths) {
      if (!files.contains(path)) files.add(path);
    }
    emit(state.copyWith(files: files));
  }

  void _onFileRemoved(
    _CsvImportEvent$FileRemoved event,
    Emitter<CsvImportState> emit,
  ) {
    if (event.index < 0 || event.index >= state.files.length) return;

    emit(state.copyWith(
      files: List<String>.of(state.files)..removeAt(event.index),
    ));
  }

  void _onDelimiterChanged(
    _CsvImportEvent$DelimiterChanged event,
    Emitter<CsvImportState> emit,
  ) {
    emit(state.copyWith(delimiter: event.delimiter));
  }

  Future<void> _onImportRequested(
    _CsvImportEvent$ImportRequested event,
    Emitter<CsvImportState> emit,
  ) async {
    if (!state.canImport || state.isParsing) return;

    emit(state.copyWith(isParsing: true));
    final result = await _csvImportService.parseFiles(
      state.files,
      state.delimiter,
    );
    emit(state.copyWith(
      isParsing: false,
      fileCount: state.files.length,
      result: SideEffectValue(result),
    ));
  }
}
