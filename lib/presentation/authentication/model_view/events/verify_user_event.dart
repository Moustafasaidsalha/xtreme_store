import 'package:equatable/equatable.dart';

abstract class VerifyUserEvent extends Equatable {
  const VerifyUserEvent();

  @override
  List<Object> get props => [];
}

class CodeChanged extends VerifyUserEvent {
  const CodeChanged({required this.code});

  final String code;

  @override
  List<Object> get props => [code];
}

class CodeUnfocused extends VerifyUserEvent {}

class VerifyUserFormSubmitted extends VerifyUserEvent {}

class ResendCode extends VerifyUserEvent {}
