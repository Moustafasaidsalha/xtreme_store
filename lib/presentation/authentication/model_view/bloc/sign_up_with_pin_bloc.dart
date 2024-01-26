import 'dart:async';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../app/use_case/use_case.dart';
import '../../../../domain/repositories/auth_repo.dart';
import '../../../../domain/repositories/user_preference_repo.dart';
import '../../../../domain/uses_cases/cart/migrate_local_cart_t_online.dart';
import '../events/sign_up_with_pin_events.dart';
import '../models/email.dart';
import '../models/name.dart';
import '../models/phone_number.dart';
import '../models/pin_code.dart';
import '../states/sign_up_with_pin_state.dart';

class SignUpWithPinBloc extends Bloc<SignUpWithPinEvent, SignUpWithPinState> {
  final AuthRepo authRepo;
  final UserPreferenceRepo userPreferenceRepo;
  final MigrateLocalCartToOnline migrateLocalCartToOnline;

  SignUpWithPinBloc({
    required this.authRepo,
    required this.userPreferenceRepo,
    required this.migrateLocalCartToOnline,
  }) : super(const SignUpWithPinState()) {
    on<FirstNameChanged>(_onFirstNameChanged);
    on<FirstNameUnfocused>(_onFirstNameUnfocused);
    on<LastNameChanged>(_onLastNameChanged);
    on<LastNameUnfocused>(_onLastNameUnfocused);
    on<EmailChanged>(_onEmailChanged);
    on<EmailUnfocused>(_onEmailUnfocused);
    on<PhoneNumberChanged>(_onPhoneNumberChanged);
    on<PhoneNumberUnfocused>(_onPhoneNumberUnfocused);
    on<CountryCodeChanged>(_onCountryCodeChanged);
    on<PinCodeChanged>(_onPinCodeChanged);
    on<PinCodeUnfocused>(_onPinCodeUnfocused);
    on<FormSubmitted>(_onFormSubmitted);
  }

  void _onFirstNameChanged(FirstNameChanged event, Emitter<SignUpWithPinState> emit) {
    final firstName = Name.dirty(event.firstName);
    emit(
      state.copyWith(
        firstName: firstName.isValid ? firstName : Name.pure(event.firstName),
        isValid: Formz.validate([
          firstName,
          state.lastName,
          state.email,
          state.phoneNumber,
          state.pinCode,
        ]),
      ),
    );
  }

  void _onFirstNameUnfocused(FirstNameUnfocused event, Emitter<SignUpWithPinState> emit) {
    final firstName = Name.dirty(state.firstName.value);
    emit(
      state.copyWith(
        firstName: firstName,
        isValid: Formz.validate([
          firstName,
          state.lastName,
          state.email,
          state.pinCode,
          state.phoneNumber,
        ]),
      ),
    );
  }

  FutureOr<void> _onLastNameChanged(LastNameChanged event, Emitter<SignUpWithPinState> emit) {
    final lastName = Name.dirty(event.lastName);
    emit(
      state.copyWith(
        lastName: lastName.isValid ? lastName : Name.pure(event.lastName),
        isValid: Formz.validate([
          state.firstName,
          lastName,
          state.email,
          state.pinCode,
          state.phoneNumber,
        ]),
      ),
    );
  }

  FutureOr<void> _onLastNameUnfocused(LastNameUnfocused event, Emitter<SignUpWithPinState> emit) {
    final lastName = Name.dirty(state.lastName.value);
    emit(
      state.copyWith(
        lastName: lastName,
        isValid: Formz.validate([
          state.firstName,
          lastName,
          state.email,
          state.pinCode,
          state.phoneNumber,
        ]),
      ),
    );
  }

  void _onEmailChanged(EmailChanged event, Emitter<SignUpWithPinState> emit) {
    final email = Email.dirty(event.email);
    emit(
      state.copyWith(
        email: email.isValid ? email : Email.pure(event.email),
        isValid: Formz.validate([
          state.firstName,
          state.lastName,
          email,
          state.pinCode,
          state.phoneNumber,
        ]),
      ),
    );
  }

  void _onEmailUnfocused(EmailUnfocused event, Emitter<SignUpWithPinState> emit) {
    final email = Email.dirty(state.email.value);
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([
          state.firstName,
          state.lastName,
          email,
          state.pinCode,
          state.phoneNumber,
        ]),
      ),
    );
  }

  void _onPinCodeChanged(PinCodeChanged event, Emitter<SignUpWithPinState> emit) {
    final pinCode = PinCode.dirty(event.pinCode);
    emit(
      state.copyWith(
        pinCode: pinCode.isValid ? pinCode : PinCode.pure(event.pinCode),
        isValid: Formz.validate([
          state.firstName,
          state.lastName,
          state.email,
          pinCode,
          state.phoneNumber,
        ]),
      ),
    );
  }

  void _onPinCodeUnfocused(
    PinCodeUnfocused event,
    Emitter<SignUpWithPinState> emit,
  ) {
    final pinCode = PinCode.dirty(state.pinCode.value);
    emit(
      state.copyWith(
        pinCode: pinCode,
        isValid: Formz.validate([
          state.firstName,
          state.lastName,
          state.email,
          pinCode,
          state.phoneNumber,
        ]),
      ),
    );
  }

  FutureOr<void> _onPhoneNumberChanged(PhoneNumberChanged event, Emitter<SignUpWithPinState> emit) {
    final phoneNumber = PhoneNumber.dirty(event.phoneNumber);
    emit(
      state.copyWith(
        phoneNumber: phoneNumber.isValid ? phoneNumber : PhoneNumber.pure(event.phoneNumber),
        isValid: Formz.validate([
          state.firstName,
          state.lastName,
          state.email,
          state.pinCode,
          phoneNumber,
        ]),
      ),
    );
  }

  FutureOr<void> _onPhoneNumberUnfocused(PhoneNumberUnfocused event, Emitter<SignUpWithPinState> emit) {
    final phoneNumber = PhoneNumber.dirty(state.phoneNumber.value);
    emit(
      state.copyWith(
        phoneNumber: phoneNumber,
        isValid: Formz.validate([
          state.firstName,
          state.lastName,
          state.email,
          state.pinCode,
          phoneNumber,
        ]),
      ),
    );
  }

  FutureOr<void> _onCountryCodeChanged(CountryCodeChanged event, Emitter<SignUpWithPinState> emit) {
    emit(state.copyWith(countryDataModel: event.countryDataModel));
  }

  Future<void> _onFormSubmitted(
    FormSubmitted event,
    Emitter<SignUpWithPinState> emit,
  ) async {
    final firstName = Name.dirty(state.firstName.value);
    final lastname = Name.dirty(state.lastName.value);
    final email = Email.dirty(state.email.value);
    final pinCode = PinCode.dirty(state.pinCode.value);
    final phoneNumber = PhoneNumber.dirty(state.phoneNumber.value);
    emit(
      state.copyWith(
        firstName: firstName,
        lastName: lastname,
        email: email,
        pinCode: pinCode,
        phoneNumber: phoneNumber,
        isValid: Formz.validate([firstName, lastname, email, pinCode, phoneNumber]),
      ),
    );
    if (state.isValid) {
      log("State $state");
      await Future.delayed(const Duration(milliseconds: 1));
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      final res = await authRepo.signUp(
        firstName: state.firstName.value,
        lastName: state.lastName.value,
        email: state.email.value,
        phoneNumber: state.phoneNumber.value,
        countryCode: state.countryDataModel.code,
        pin: state.pinCode.value,
      );
      res.fold(
        (l) {
          log("Sign Up Left $l");
          log("Sign Up Left ${l.message}");
          emit(state.copyWith(status: FormzSubmissionStatus.failure,message: l.message));
        },
        (r) async {
          log("Sign Up Right $r");
          log("Sign Up Left ${r.message}");
          userPreferenceRepo.insertHideOnBoarding(value: true);
          userPreferenceRepo.insertAccessToken(value: r.accessToken ?? '');
        },
      );
      if(res.isRight()){
        await migrateLocalCartToOnline(NoParams());
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      }
    }
  }
}
