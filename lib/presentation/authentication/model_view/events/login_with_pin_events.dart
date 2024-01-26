import 'package:equatable/equatable.dart';
import 'package:extreme_store/app/utilities/country_utility.dart';

abstract class LoginWithPinEvent extends Equatable {
  const LoginWithPinEvent();

  @override
  List<Object> get props => [];
}

class PhoneNumberChanged extends LoginWithPinEvent {
  const PhoneNumberChanged({required this.phoneNumber});

  final String phoneNumber;

  @override
  List<Object> get props => [phoneNumber];
}

class PhoneNumberUnfocused extends LoginWithPinEvent {}

class CountryCodeChanged extends LoginWithPinEvent {
  const CountryCodeChanged({required this.countryDataModel});

  final CountryDataModel countryDataModel;

  @override
  List<Object> get props => [countryDataModel];
}
class PinCodeChanged extends LoginWithPinEvent {
  const PinCodeChanged({required this.pinCode});

  final String pinCode;

  @override
  List<Object> get props => [pinCode];
}

class PinCodeUnfocused extends LoginWithPinEvent {}

class EscapeAuth extends LoginWithPinEvent {}

class FormSubmitted extends LoginWithPinEvent {}