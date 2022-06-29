import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:notes_firebase_ddd_course/domain/core/errors.dart';
import 'package:notes_firebase_ddd_course/domain/core/failures.dart';

@immutable
abstract class ValueObject<T> {
  Either<ValueFailure<T>, T> get value;

  @override
  int get hashCode => value.hashCode;

  const ValueObject();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ValueObject<T> && other.value == value;
  }

  @override
  String toString() => 'Value($value)';

  bool isValid() => value.isRight();

  /// Кидает [UnexpectedValueError] содержащую [ValueFailure]
  T getOrCrash() => value.fold((f) => throw UnexpectedValueError(f), id); // id это аналог функции (r) => r;
}
