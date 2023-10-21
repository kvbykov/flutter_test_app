import 'package:formz/formz.dart';
import 'package:test_case/utils/string_validator.dart';

enum DateValidationError { empty, invalid }

class Date extends FormzInput<String, DateValidationError> {
  const Date.pure() : super.pure('');
  const Date.dirty([super.value = '']) : super.dirty();

  @override
  DateValidationError? validator(String value) {
    if (value.isEmpty) return DateValidationError.empty;
    if (!isValidDate(value)) return DateValidationError.invalid;
    if (value == '1234') return DateValidationError.invalid;
    return null;
  }
}
