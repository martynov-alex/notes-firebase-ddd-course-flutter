import 'package:dartz/dartz.dart';
import 'package:notes_firebase_ddd_course/domain/core/failures.dart';
import 'package:notes_firebase_ddd_course/domain/core/value_objects.dart';
import 'package:notes_firebase_ddd_course/domain/core/value_validators.dart';

class EmailAddress extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory EmailAddress(String input) {
    return EmailAddress._(
      validateEmailAddress(input),
    );
  }

  const EmailAddress._(this.value);
}

class Password extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory Password(String input) {
    return Password._(
      validatePassword(input),
    );
  }

  const Password._(this.value);
}

// void showingTheEmailAddressOrFailure() {
//   final emailAddress = EmailAddress('fsfdss'); // Возвращает Either<ValueFailure<String>, String>
//
//   // Первый вариант работы с Either
//   String emailText1 = emailAddress.value.fold(
//     (left) => 'Failure happened, more precisely: $left',
//     (right) => right,
//   );
//
//   // Второй вариант работы с Either
//   String emailText2 = emailAddress.value.getOrElse(() => 'Some failure happened');
// }
