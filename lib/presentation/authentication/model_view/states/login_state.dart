import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:extreme_store/app/utilities/country_utility.dart';
import '../../../../app/constants/icon_constants.dart';
import '../models/phone_number.dart';

class LoginState extends Equatable {
  const LoginState({
    this.phoneNumber = const PhoneNumber.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
    this.errorMessage = '',
    this.countryDataModel = const CountryDataModel(
      id: 1,
      nameAR: 'الكويت',
      nameEN: 'Kuwait',
      currency: 'KWD',
      code: '+965',
      iconPath: IconsConstants.kuwait,
    ),
  });

  final PhoneNumber phoneNumber;
  final FormzSubmissionStatus status;
  final bool isValid;
  final CountryDataModel countryDataModel;
  final String errorMessage;

  LoginState copyWith({
    PhoneNumber? phoneNumber,
    FormzSubmissionStatus? status,
    bool? isValid,
    String? errorMessage,
    CountryDataModel? countryDataModel,
  }) {
    return LoginState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      countryDataModel: countryDataModel ?? this.countryDataModel,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [
        phoneNumber,
        status,
        isValid,
        countryDataModel,
        errorMessage,
      ];
}
