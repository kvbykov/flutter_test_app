import 'package:formz/formz.dart';

enum ProfileImageValidationError { empty, invalid }

class ProfileImage extends FormzInput<List<int>, ProfileImageValidationError> {
  const ProfileImage.pure() : super.pure(const <int>[]);
  const ProfileImage.dirty([super.value = const <int>[]]) : super.dirty();

  @override
  ProfileImageValidationError? validator(List<int> value) {
    // if (value.isEmpty) return ProfileImageValidationError.empty;
    return null;

    //TODO: is image validation needed?
  }
}
