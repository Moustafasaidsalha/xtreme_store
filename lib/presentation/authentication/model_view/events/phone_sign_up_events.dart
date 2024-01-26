import 'package:equatable/equatable.dart';
import 'package:extreme_store/app/utilities/country_utility.dart';

abstract class PhoneSignUpEvent extends Equatable {
  const PhoneSignUpEvent();

  @override
  List<Object> get props => [];
}

class PhoneNumberChanged extends PhoneSignUpEvent {
  const PhoneNumberChanged({required this.phoneNumber});

  final String phoneNumber;

  @override
  List<Object> get props => [phoneNumber];
}
class CountryChanged extends PhoneSignUpEvent {
  const CountryChanged({required this.countryDataModel});

  final CountryDataModel countryDataModel;

  @override
  List<Object> get props => [countryDataModel];
}

class PhoneNumberUnfocused extends PhoneSignUpEvent {}

class FormSubmitted extends PhoneSignUpEvent {}

