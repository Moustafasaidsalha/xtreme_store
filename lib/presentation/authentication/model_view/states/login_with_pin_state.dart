import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:extreme_store/app/utilities/country_utility.dart';
import 'package:extreme_store/presentation/authentication/model_view/models/phone_number.dart';
import 'package:extreme_store/presentation/authentication/model_view/models/pin_code.dart';

import '../../../../app/constants/icon_constants.dart';

class LoginWithPinState extends Equatable {
  const LoginWithPinState({
    this.phoneNumber = const PhoneNumber.pure(),
    this.countryDataModel =const CountryDataModel(
      id: 1,
      nameAR: 'الكويت',
      nameEN: 'Kuwait',
      currency: 'KWD',
      code: '+965',
      iconPath: IconsConstants.kuwait,
    ),
    this.pinCode = const PinCode.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
    this.message = '',
  });

  final PhoneNumber phoneNumber;
  final CountryDataModel countryDataModel;
  final PinCode pinCode;
  final FormzSubmissionStatus status;
  final bool isValid;
  final String message;


  LoginWithPinState copyWith({
    PhoneNumber? phoneNumber,
    CountryDataModel? countryDataModel,
    PinCode? pinCode,
    FormzSubmissionStatus? status,
    bool? isValid,
    String? message,
  }) {
    return LoginWithPinState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      countryDataModel: countryDataModel ?? this.countryDataModel,
      pinCode: pinCode ?? this.pinCode,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [
    phoneNumber,
    countryDataModel,
    pinCode,
    status,
    isValid,
    message,
  ];
}
