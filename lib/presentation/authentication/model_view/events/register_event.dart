import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class FirstNameChanged extends RegisterEvent {
  const FirstNameChanged({required this.firstName});

  final String firstName;

  @override
  List<Object> get props => [firstName];
}

class FirstNameUnfocused extends RegisterEvent {}

class LastNameChanged extends RegisterEvent {
  const LastNameChanged({required this.lastName});

  final String lastName;

  @override
  List<Object> get props => [lastName];
}

class LastNameUnfocused extends RegisterEvent {}

class EmailChanged extends RegisterEvent {
  const EmailChanged({required this.email});

  final String email;

  @override
  List<Object> get props => [email];
}

class EmailUnfocused extends RegisterEvent {}

class PasswordChanged extends RegisterEvent {
  const PasswordChanged({required this.password});

  final String password;

  @override
  List<Object> get props => [password];
}

class PasswordUnfocused extends RegisterEvent {}

class PhoneNumberChanged extends RegisterEvent {
  const PhoneNumberChanged({required this.phoneNumber});

  final String phoneNumber;

  @override
  List<Object> get props => [phoneNumber];
}

class PhoneNumberUnfocused extends RegisterEvent {}

class FormSubmitted extends RegisterEvent {}

class SignInWithGoogleProvider extends RegisterEvent {}

class SignInWithAppleProvider extends RegisterEvent {}

class EscapeAuth extends RegisterEvent {}
