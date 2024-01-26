import 'package:equatable/equatable.dart';
import 'package:extreme_store/app/utilities/country_utility.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class PhoneNumberChanged extends LoginEvent {
  const PhoneNumberChanged({required this.phoneNumber});

  final String phoneNumber;

  @override
  List<Object> get props => [phoneNumber];
}
class CountryChanged extends LoginEvent {
  const CountryChanged({required this.countryDataModel});

  final CountryDataModel countryDataModel;

  @override
  List<Object> get props => [countryDataModel];
}

class PhoneNumberUnfocused extends LoginEvent {}

class FormSubmitted extends LoginEvent {}

class EscapeAuth extends LoginEvent {}
