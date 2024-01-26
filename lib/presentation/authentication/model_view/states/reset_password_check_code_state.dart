import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../models/code.dart';

class ResetPasswordCheckCodeState extends Equatable {
  final Code code;
  final FormzSubmissionStatus status;
  final bool isValid;
  final String errorMessage;

  const ResetPasswordCheckCodeState({
    this.code = const Code.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
    this.errorMessage = '',
  });

  ResetPasswordCheckCodeState copyWith({
    Code? code,
    FormzSubmissionStatus? status,
    bool? isValid,
    String? errorMessage,
  }) {
    return ResetPasswordCheckCodeState(
      code: code ?? this.code,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [code, status, isValid, errorMessage];
}
