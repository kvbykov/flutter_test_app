import 'package:formz/formz.dart';
import 'package:test_case/utils/string_validator.dart';

enum UsernameValidationError { empty, invalidSymbols }

class Username extends FormzInput<String, UsernameValidationError> {
  const Username.pure() : super.pure('');
  const Username.dirty([super.value = '']) : super.dirty();

  @override
  UsernameValidationError? validator(String value) {
    if (value.isEmpty) return UsernameValidationError.empty;
    if (!containsOnlyLetters(value)) {
      return UsernameValidationError.invalidSymbols;
    }

    return null;
  }
}
