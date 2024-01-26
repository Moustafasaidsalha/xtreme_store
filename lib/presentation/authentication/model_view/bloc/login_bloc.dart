import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:extreme_store/domain/repositories/auth_repo.dart';
import 'package:extreme_store/presentation/authentication/model_view/events/login_events.dart';
import 'package:extreme_store/presentation/authentication/model_view/states/login_state.dart';
import '../../../../domain/repositories/user_preference_repo.dart';
import '../models/phone_number.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepo authRepo;
  final UserPreferenceRepo userPreferenceRepo;

  LoginBloc({
    required this.authRepo,
    required this.userPreferenceRepo,

  }) : super(const LoginState()) {
    on<PhoneNumberChanged>(_onPhoneNumberChanged);
    on<PhoneNumberUnfocused>(_onPhoneNumberUnfocused);
    on<FormSubmitted>(_onFormSubmitted);
    on<CountryChanged>(_onCountryChanged);
    on<EscapeAuth>(_onEscapeAuth);
  }

  void _onPhoneNumberChanged(PhoneNumberChanged event, Emitter<LoginState> emit) {
    final phoneNumber = PhoneNumber.dirty(event.phoneNumber);
    emit(
      state.copyWith(
        phoneNumber: phoneNumber.isValid ? phoneNumber : PhoneNumber.pure(event.phoneNumber),
        isValid: Formz.validate([phoneNumber]),
      ),
    );
  }

  void _onPhoneNumberUnfocused(PhoneNumberUnfocused event, Emitter<LoginState> emit) {
    final phoneNumber = PhoneNumber.dirty(state.phoneNumber.value);
    emit(
      state.copyWith(
        phoneNumber: phoneNumber,
        isValid: Formz.validate([phoneNumber]),
      ),
    );
  }

  Future<void> _onFormSubmitted(
    FormSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    final phoneNumber = PhoneNumber.dirty(state.phoneNumber.value);
    emit(
      state.copyWith(
        phoneNumber: phoneNumber,
        isValid: Formz.validate([phoneNumber]),
      ),
    );
    if (state.isValid) {
      await Future.delayed(const Duration(milliseconds: 1));
      emit(state.copyWith(
        status: FormzSubmissionStatus.inProgress,
      ));

      final res = await authRepo.login(
        phoneNumber: state.phoneNumber.value,
        // countryCode: state.countryDataModel.code,
        countryCode: "+20",
        pin: '',
      );

      res.fold((l) {
        emit(state.copyWith(
          status: FormzSubmissionStatus.failure,
          errorMessage: l.message,
        ));
      }, (r) {
        emit(state.copyWith(
          status: FormzSubmissionStatus.success,
        ));
      });
    }
  }

  FutureOr<void> _onCountryChanged(
    CountryChanged event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(countryDataModel: event.countryDataModel));

  }

  FutureOr<void> _onEscapeAuth(EscapeAuth event, Emitter<LoginState> emit) async {
    await userPreferenceRepo.insertHideOnBoarding(value: true);
    emit(state.copyWith(status: FormzSubmissionStatus.canceled));
  }

}
