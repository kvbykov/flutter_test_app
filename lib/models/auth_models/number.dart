import 'package:formz/formz.dart';
import 'package:test_case/utils/string_validator.dart';

enum NumberValidationError { empty, invalid }

class Number extends FormzInput<String, NumberValidationError> {
  const Number.pure() : super.pure('');
  const Number.dirty([super.value = '']) : super.dirty();

  @override
  NumberValidationError? validator(String value) {
    if (value.isEmpty) return NumberValidationError.empty;
    if (!containsOnlyDigits(value)) return NumberValidationError.invalid;

    return null;
  }
}
