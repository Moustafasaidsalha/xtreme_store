import 'package:equatable/equatable.dart';

abstract class AddNewPasswordEvent extends Equatable {
  const AddNewPasswordEvent();

  @override
  List<Object> get props => [];
}

class PasswordChanged extends AddNewPasswordEvent {
  const PasswordChanged({required this.password});

  final String password;

  @override
  List<Object> get props => [password];
}

class PasswordUnfocused extends AddNewPasswordEvent {}

class AddPasswordFormSubmitted extends AddNewPasswordEvent {}
