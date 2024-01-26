import 'dart:async';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:extreme_store/presentation/authentication/model_view/states/login_with_pin_state.dart';

import '../../../../app/use_case/use_case.dart';
import '../../../../domain/repositories/auth_repo.dart';
import '../../../../domain/repositories/user_preference_repo.dart';
import '../../../../domain/uses_cases/cart/migrate_local_cart_t_online.dart';
import '../events/login_with_pin_events.dart';
import '../models/phone_number.dart';
import '../models/pin_code.dart';

class LoginWithPinBloc extends Bloc<LoginWithPinEvent, LoginWithPinState> {
  final AuthRepo authRepo;
  final UserPreferenceRepo userPreferenceRepo;
  final MigrateLocalCartToOnline migrateLocalCartToOnline;

  LoginWithPinBloc({
    required this.authRepo,
    required this.userPreferenceRepo,
    required this.migrateLocalCartToOnline,
  }) : super(const LoginWithPinState()) {
    on<PhoneNumberChanged>(_onPhoneNumberChanged);
    on<PhoneNumberUnfocused>(_onPhoneNumberUnfocused);
    on<CountryCodeChanged>(_onCountryCodeChanged);
    on<PinCodeChanged>(_onPinCodeChanged);
    on<PinCodeUnfocused>(_onPinCodeUnfocused);
    on<FormSubmitted>(_onFormSubmitted);
    on<EscapeAuth>(_onEscapeAuth);
  }



  void _onPinCodeChanged(PinCodeChanged event, Emitter<LoginWithPinState> emit) {
    final pinCode = PinCode.dirty(event.pinCode);
    emit(
      state.copyWith(
        pinCode: pinCode.isValid ? pinCode : PinCode.pure(event.pinCode),
        isValid: Formz.validate([
          pinCode,
          state.phoneNumber,
        ]),
      ),
    );
  }

  void _onPinCodeUnfocused(
      PinCodeUnfocused event,
      Emitter<LoginWithPinState> emit,
      ) {
    final pinCode = PinCode.dirty(state.pinCode.value);
    emit(
      state.copyWith(
        pinCode: pinCode,
        isValid: Formz.validate([
          pinCode,
          state.phoneNumber,
        ]),
      ),
    );
  }

  FutureOr<void> _onPhoneNumberChanged(PhoneNumberChanged event, Emitter<LoginWithPinState> emit) {
    final phoneNumber = PhoneNumber.dirty(event.phoneNumber);
    emit(
      state.copyWith(
        phoneNumber: phoneNumber.isValid ? phoneNumber : PhoneNumber.pure(event.phoneNumber),
        isValid: Formz.validate([
          state.pinCode,
          phoneNumber,
        ]),
      ),
    );
  }

  FutureOr<void> _onPhoneNumberUnfocused(PhoneNumberUnfocused event, Emitter<LoginWithPinState> emit) {
    final phoneNumber = PhoneNumber.dirty(state.phoneNumber.value);
    emit(
      state.copyWith(
        phoneNumber: phoneNumber,
        isValid: Formz.validate([
          state.pinCode,
          phoneNumber,
        ]),
      ),
    );
  }

  FutureOr<void> _onCountryCodeChanged(CountryCodeChanged event, Emitter<LoginWithPinState> emit) {
    emit(state.copyWith(countryDataModel: event.countryDataModel));
  }

  Future<void> _onFormSubmitted(
      FormSubmitted event,
      Emitter<LoginWithPinState> emit,
      ) async {
    final pinCode = PinCode.dirty(state.pinCode.value);
    final phoneNumber = PhoneNumber.dirty(state.phoneNumber.value);
    emit(
      state.copyWith(
        pinCode: pinCode,
        phoneNumber: phoneNumber,
        isValid: Formz.validate([pinCode, phoneNumber]),
      ),
    );
    if (state.isValid) {
      log("State $state");
      await Future.delayed(const Duration(milliseconds: 1));
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      final res = await authRepo.login(
        phoneNumber: state.phoneNumber.value,
        countryCode: state.countryDataModel.code,
        pin: state.pinCode.value,
      );
      res.fold(
            (l) {
          log("Login Left $l");
          log("Login Left ${l.message}");
          emit(state.copyWith(status: FormzSubmissionStatus.failure,message: l.message));
        },
            (r) async {
          log("Login Right $r");
          log("Login Left ${r.message}");
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

  FutureOr<void> _onEscapeAuth(EscapeAuth event, Emitter<LoginWithPinState> emit) async {
    await userPreferenceRepo.insertHideOnBoarding(value: true);
    emit(state.copyWith(status: FormzSubmissionStatus.canceled));
  }

}
