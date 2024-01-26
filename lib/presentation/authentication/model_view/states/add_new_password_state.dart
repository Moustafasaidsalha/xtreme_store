import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../models/password.dart';

class AddNewPasswordState extends Equatable {
  const AddNewPasswordState({
    this.password = const Password.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.errorMessage = '',
    this.isValid = false,
  });

  final Password password;
  final FormzSubmissionStatus status;
  final bool isValid;
  final String errorMessage;

  AddNewPasswordState copyWith({
    Password? password,
    FormzSubmissionStatus? status,
    String? errorMessage,
    bool? isValid,
  }) {
    return AddNewPasswordState(
      password: password ?? this.password,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object> get props => [
        password,
        status,
        errorMessage,
        isValid,
      ];
}
