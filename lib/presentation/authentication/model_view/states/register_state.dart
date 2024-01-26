import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:extreme_store/presentation/authentication/model_view/models/name.dart';
import 'package:extreme_store/presentation/authentication/model_view/models/password.dart';
import 'package:extreme_store/presentation/authentication/model_view/models/phone_number.dart';

class RegisterState extends Equatable {
  const RegisterState({
    this.firstName = const Name.pure(),
    this.lastName = const Name.pure(),
    this.email = const PhoneNumber.pure(),
    this.password = const Password.pure(),
    this.phoneNumber = const PhoneNumber.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,

  });

  final Name firstName;
  final Name lastName;
  final PhoneNumber email;
  final Password password;
  final PhoneNumber phoneNumber;
  final FormzSubmissionStatus status;
  final bool isValid;


  RegisterState copyWith({
    Name? firstName,
    Name? lastName,
    PhoneNumber? email,
    Password? password,
    PhoneNumber? phoneNumber,
    FormzSubmissionStatus? status,
    bool? isValid,

  }) {
    return RegisterState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid, ///TODO why not put it in props

    );
  }

  @override
  List<Object> get props => [
        firstName,
        lastName,
        email,
        password,
        phoneNumber,
        status,
      ];
}
