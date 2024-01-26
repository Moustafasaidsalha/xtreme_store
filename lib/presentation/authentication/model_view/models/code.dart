import 'package:formz/formz.dart';

enum CodeValidationError { invalid }

class Code extends FormzInput<String, CodeValidationError> {
  const Code.pure([super.value = '']) : super.pure();
  const Code.dirty([super.value = '']) : super.dirty();

  @override
  CodeValidationError? validator(String? value) {
    return value!.length > 1 ? null : CodeValidationError.invalid;
  }
}
