import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:extreme_store/domain/repositories/auth_repo.dart';
import 'package:extreme_store/presentation/authentication/model_view/events/phone_sign_up_events.dart';
import 'package:extreme_store/presentation/authentication/model_view/states/phone_sign_up_states.dart';
import '../models/phone_number.dart';

class PhoneSignUpBloc extends Bloc<PhoneSignUpEvent, PhoneSignUpState> {
  final AuthRepo authRepo;

  PhoneSignUpBloc({
    required this.authRepo,
  }) : super(const PhoneSignUpState()) {
    on<PhoneNumberChanged>(_onPhoneNumberChanged);
    on<PhoneNumberUnfocused>(_onPhoneNumberUnfocused);
    on<FormSubmitted>(_onFormSubmitted);
    on<CountryChanged>(_onCountryChanged);
  }

  void _onPhoneNumberChanged(PhoneNumberChanged event, Emitter<PhoneSignUpState> emit) {
    final phoneNumber = PhoneNumber.dirty(event.phoneNumber);
    emit(
      state.copyWith(
        phoneNumber: phoneNumber.isValid ? phoneNumber : PhoneNumber.pure(event.phoneNumber),
        isValid: Formz.validate([phoneNumber]),
      ),
    );
  }

  void _onPhoneNumberUnfocused(PhoneNumberUnfocused event, Emitter<PhoneSignUpState> emit) {
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
    Emitter<PhoneSignUpState> emit,
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

      final res = await authRepo.signUp(
        phoneNumber: state.phoneNumber.value,
        countryCode: state.countryDataModel.code, firstName: '', lastName: '', email: '', pin: '',
        // countryCode: '+20',
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
    Emitter<PhoneSignUpState> emit,
  ) {
    emit(state.copyWith(countryDataModel: event.countryDataModel));
  }
}
