import 'package:equatable/equatable.dart';

abstract class ResetPasswordCheckCodeEvent extends Equatable {
  const ResetPasswordCheckCodeEvent();

  @override
  List<Object> get props => [];
}

class CodeChanged extends ResetPasswordCheckCodeEvent {
  const CodeChanged({required this.code});

  final String code;

  @override
  List<Object> get props => [code];
}

class CodeUnfocused extends ResetPasswordCheckCodeEvent {}

class CheckCodeFormSubmitted extends ResetPasswordCheckCodeEvent {
  final String email;

  const CheckCodeFormSubmitted({required this.email});
  @override
  List<Object> get props => [email];
}
