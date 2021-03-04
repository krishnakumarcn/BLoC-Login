import 'package:formz/formz.dart';

enum UsernameValidationError { empty, lessthaneight }

class Username extends FormzInput<String, UsernameValidationError> {
  const Username.pure() : super.pure('');
  const Username.dirty([String value = '']) : super.dirty(value);

  @override
  UsernameValidationError validator(String value) {
    if (value.isEmpty) return UsernameValidationError.empty;
    if (value.length < 8) return UsernameValidationError.lessthaneight;
    return null;
  }
}
