import 'package:formz/formz.dart';

enum PasswordValidator { empty }

class Password extends FormzInput<String, PasswordValidator> {
  const Password.pure() : super.pure('');
  const Password.dirty([String value = '']) : super.dirty(value);

  @override
  PasswordValidator validator(String value) {
    return value.isEmpty ? PasswordValidator.empty : null;
  }
}
