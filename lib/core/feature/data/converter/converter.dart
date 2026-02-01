import 'package:flutter/cupertino.dart';

/// {@template converter.class}
/// Base class for converter.
/// {@endtemplate}
abstract base class Converter<TResult, TFrom> {
  /// {@macro converter.class}
  const Converter();

  /// Convert TFrom to TResult.
  TResult convert(TFrom? input);

  /// Convert nullable TFrom to nullable TResult.
  TResult? convertNullable(TFrom? input) =>
      input == null ? null : convert(input);

  /// Convert TFrom list to TResult list.
  Iterable<TResult> convertMultiple(Iterable<TFrom?>? inputList) =>
      cast(inputList, 'list').map(convert);

  @protected
  T cast<T>(
    T? data, [
    /// Deprecated field. Can be omitted.
    String? fieldName,
  ]) {
    if (data != null) return data;

    throw const FormatException();
  }
}

/// {@template converter_to_and_from.class}
/// Base class for converter that convert to and from a type.
/// {@endtemplate}
abstract base class ConverterToAndFrom<TResult, TFrom> {
  /// TResult from TFrom converter.
  Converter<TResult, TFrom> get converter;

  /// TFrom from TResult converter.
  Converter<TFrom, TResult> get reverseConverter;

  /// {@macro converter.class}
  const ConverterToAndFrom();

  /// Convert TFrom to TResult.
  TResult convert(TFrom? input) => converter.convert(input);

  /// Convert TResult to TFrom.
  TFrom convertReverse(TResult? input) => reverseConverter.convert(input);
}
