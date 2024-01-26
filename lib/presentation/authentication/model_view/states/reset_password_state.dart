import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../models/email.dart';

class ResetPasswordState extends Equatable {
  final Email email;
  final FormzSubmissionStatus status;
  final bool isValid;
  final String errorMessage;

  const ResetPasswordState({
    this.email = const Email.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
    this.errorMessage = '',
  });

  ResetPasswordState copyWith({
    Email? email,
    FormzSubmissionStatus? status,
    bool? isValid,
    String? errorMessage,
  }) {
    return ResetPasswordState(
      email: email ?? this.email,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [email, status, isValid, errorMessage];
}
