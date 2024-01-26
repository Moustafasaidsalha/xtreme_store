import 'package:equatable/equatable.dart';
import 'package:extreme_store/app/utilities/country_utility.dart';

abstract class SignUpWithPinEvent extends Equatable {
  const SignUpWithPinEvent();

  @override
  List<Object> get props => [];
}

class FirstNameChanged extends SignUpWithPinEvent {
  const FirstNameChanged({required this.firstName});

  final String firstName;

  @override
  List<Object> get props => [firstName];
}

class FirstNameUnfocused extends SignUpWithPinEvent {}

class LastNameChanged extends SignUpWithPinEvent {
  const LastNameChanged({required this.lastName});

  final String lastName;

  @override
  List<Object> get props => [lastName];
}

class LastNameUnfocused extends SignUpWithPinEvent {}

class EmailChanged extends SignUpWithPinEvent {
  const EmailChanged({required this.email});

  final String email;

  @override
  List<Object> get props => [email];
}

class EmailUnfocused extends SignUpWithPinEvent {}

class PhoneNumberChanged extends SignUpWithPinEvent {
  const PhoneNumberChanged({required this.phoneNumber});

  final String phoneNumber;

  @override
  List<Object> get props => [phoneNumber];
}

class PhoneNumberUnfocused extends SignUpWithPinEvent {}

class CountryCodeChanged extends SignUpWithPinEvent {
  const CountryCodeChanged({required this.countryDataModel});

  final CountryDataModel countryDataModel;

  @override
  List<Object> get props => [countryDataModel];
}
class PinCodeChanged extends SignUpWithPinEvent {
  const PinCodeChanged({required this.pinCode});

  final String pinCode;

  @override
  List<Object> get props => [pinCode];
}

class PinCodeUnfocused extends SignUpWithPinEvent {}

class FormSubmitted extends SignUpWithPinEvent {}