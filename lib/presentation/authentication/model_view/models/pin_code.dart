import 'package:formz/formz.dart';

enum PinCodeValidationError { invalid }

class PinCode extends FormzInput<String, PinCodeValidationError> {
  const PinCode.pure([super.value = '']) : super.pure();
  const PinCode.dirty([super.value = '']) : super.dirty();

  // static final _passwordRegex =
  //     RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');

  @override
  PinCodeValidationError? validator(String? value) {
    return (value?.length ?? 0) == 4? null : PinCodeValidationError.invalid;
  }
}
