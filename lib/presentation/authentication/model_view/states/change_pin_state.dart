import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:extreme_store/presentation/authentication/model_view/models/pin_code.dart';

class ChangePinState extends Equatable {
  const ChangePinState({
    this.oldPin = const PinCode.pure(),
    this.newPin = const PinCode.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.message = '',
    this.isValid = false,
  });

  final PinCode oldPin;
  final PinCode newPin;
  final FormzSubmissionStatus status;
  final String message;
  final bool isValid;

  ChangePinState copyWith({
    PinCode? oldPin,
    PinCode? newPin,
    FormzSubmissionStatus? status,
    String? message,
    bool? isValid,
  }) {
    return ChangePinState(
      oldPin: oldPin ?? this.oldPin,
      newPin: newPin ?? this.newPin,
      status: status ?? this.status,
      message: message ?? this.message,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object> get props => [
        oldPin,
        newPin,
        status,
        message,
        isValid,
      ];
}
