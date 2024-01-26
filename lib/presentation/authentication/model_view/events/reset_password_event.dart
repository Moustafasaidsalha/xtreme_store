import 'package:equatable/equatable.dart';

abstract class ResetPasswordEvent extends Equatable {
  const ResetPasswordEvent();

  @override
  List<Object> get props => [];
}

class RestPasswordEmailChanged extends ResetPasswordEvent {
  const RestPasswordEmailChanged({required this.email});

  final String email;

  @override
  List<Object> get props => [email];
}

class ResetPasswordEmailUnfocused extends ResetPasswordEvent {}

class ResetPasswordFormSubmitted extends ResetPasswordEvent {}