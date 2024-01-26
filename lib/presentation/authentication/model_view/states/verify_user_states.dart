import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../models/code.dart';

class VerifyUserState extends Equatable {
  final Code code;
  final FormzSubmissionStatus verifyStatus;
  final bool isValid;
  final String errorMessage;
  final FormzSubmissionStatus resendStatus;

  const VerifyUserState({
    this.code = const Code.pure(),
    this.verifyStatus = FormzSubmissionStatus.initial,
    this.isValid = false,
    this.errorMessage = '',
    this.resendStatus = FormzSubmissionStatus.initial,
  });

  VerifyUserState copyWith({
    Code? code,
    FormzSubmissionStatus? verifyStatus,
    bool? isValid,
    String? errorMessage,
    FormzSubmissionStatus? resendStatus,
  }) {
    return VerifyUserState(
      code: code ?? this.code,
      verifyStatus: verifyStatus ?? this.verifyStatus,
      resendStatus: resendStatus ?? this.resendStatus,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [code, verifyStatus, isValid, errorMessage, resendStatus];
}
