import 'package:formz/formz.dart';

enum PasswordValidationError { empty, weak }

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('');
  const Password.dirty([super.value = '']) : super.dirty();

  /*
  (?=.{8,}$)         // use positive look ahead to see if at least 8 characters
  (?=.*[a-z])        // use positive look ahead to see if at least one lower case letter exists
  (?=.*[A-Z])        // use positive look ahead to see if at least one upper case letter exists
  (?=.*\W)           // use positive look ahead to see if at least one non-word character exists
  */
  static String pattern = r'(?=.{8,}$)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)';

  @override
  PasswordValidationError? validator(String value) {
    if (value.isEmpty) {
      return PasswordValidationError.empty;
    } else if (!(RegExp(pattern, multiLine: false).hasMatch(value))) {
      return PasswordValidationError.weak;
    } else {
      return null;
    }
  }
}
