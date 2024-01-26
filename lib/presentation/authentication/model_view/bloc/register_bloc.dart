import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:extreme_store/presentation/authentication/model_view/models/name.dart';
import 'package:extreme_store/presentation/authentication/model_view/models/phone_number.dart';

import '../../../../domain/repositories/auth_repo.dart';
import '../events/register_event.dart';
import '../models/password.dart';
import '../states/register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepo authRepo;

  RegisterBloc({
    required this.authRepo,
  }) : super(const RegisterState()) {
    on<FirstNameChanged>(_onFirstNameChanged);
    on<FirstNameUnfocused>(_onFirstNameUnfocused);
    on<LastNameChanged>(_onLastNameChanged);
    on<LastNameUnfocused>(_onLastNameUnfocused);
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<EmailUnfocused>(_onEmailUnfocused);
    on<PasswordUnfocused>(_onPasswordUnfocused);
    on<PhoneNumberChanged>(_onPhoneNumberChanged);
    on<PhoneNumberUnfocused>(_onPhoneNumberUnfocused);
    on<FormSubmitted>(_onFormSubmitted);
  }

  void _onFirstNameChanged(FirstNameChanged event, Emitter<RegisterState> emit) {
    final firstName = Name.dirty(event.firstName);
    emit(
      state.copyWith(
        firstName: firstName.isValid ? firstName : Name.pure(event.firstName),
        isValid: Formz.validate([
          firstName,
          state.lastName,
          state.email,
          state.password,
          state.phoneNumber,
        ]),
      ),
    );
  }

  void _onFirstNameUnfocused(FirstNameUnfocused event, Emitter<RegisterState> emit) {
    final firstName = Name.dirty(state.firstName.value);
    emit(
      state.copyWith(
        firstName: firstName,
        isValid: Formz.validate([
          firstName,
          state.lastName,
          state.email,
          state.password,
          state.phoneNumber,
        ]),
      ),
    );
  }

  FutureOr<void> _onLastNameChanged(LastNameChanged event, Emitter<RegisterState> emit) {
    final lastName = Name.dirty(event.lastName);
    emit(
      state.copyWith(
        lastName: lastName.isValid ? lastName : Name.pure(event.lastName),
        isValid: Formz.validate([
          state.firstName,
          lastName,
          state.email,
          state.password,
          state.phoneNumber,
        ]),
      ),
    );
  }

  FutureOr<void> _onLastNameUnfocused(LastNameUnfocused event, Emitter<RegisterState> emit) {
    final lastName = Name.dirty(state.lastName.value);
    emit(
      state.copyWith(
        lastName: lastName,
        isValid: Formz.validate([
          state.firstName,
          lastName,
          state.email,
          state.password,
          state.phoneNumber,
        ]),
      ),
    );
  }

  void _onEmailChanged(EmailChanged event, Emitter<RegisterState> emit) {
    final email = PhoneNumber.dirty(event.email);
    emit(
      state.copyWith(
        email: email.isValid ? email : PhoneNumber.pure(event.email),
        isValid: Formz.validate([
          state.firstName,
          state.lastName,
          email,
          state.password,
          state.phoneNumber,
        ]),
      ),
    );
  }

  void _onEmailUnfocused(EmailUnfocused event, Emitter<RegisterState> emit) {
    final email = PhoneNumber.dirty(state.email.value);
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([
          state.firstName,
          state.lastName,
          email,
          state.password,
          state.phoneNumber,
        ]),
      ),
    );
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<RegisterState> emit) {
    final password = Password.dirty(event.password);
    emit(
      state.copyWith(
        password: password.isValid ? password : Password.pure(event.password),
        isValid: Formz.validate([
          state.firstName,
          state.lastName,
          state.email,
          password,
          state.phoneNumber,
        ]),
      ),
    );
  }

  void _onPasswordUnfocused(
    PasswordUnfocused event,
    Emitter<RegisterState> emit,
  ) {
    final password = Password.dirty(state.password.value);
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([
          state.firstName,
          state.lastName,
          state.email,
          password,
          state.phoneNumber,
        ]),
      ),
    );
  }

  FutureOr<void> _onPhoneNumberChanged(PhoneNumberChanged event, Emitter<RegisterState> emit) {
    final phoneNumber = PhoneNumber.dirty(event.phoneNumber);
    emit(
      state.copyWith(
        phoneNumber: phoneNumber.isValid ? phoneNumber : PhoneNumber.pure(event.phoneNumber),
        isValid: Formz.validate([
          state.firstName,
          state.lastName,
          state.email,
          state.password,
          phoneNumber,
        ]),
      ),
    );
  }

  FutureOr<void> _onPhoneNumberUnfocused(PhoneNumberUnfocused event, Emitter<RegisterState> emit) {
    final phoneNumber = PhoneNumber.dirty(state.phoneNumber.value);
    emit(
      state.copyWith(
        phoneNumber: phoneNumber,
        isValid: Formz.validate([
          state.firstName,
          state.lastName,
          state.email,
          state.password,
          phoneNumber,
        ]),
      ),
    );
  }

  Future<void> _onFormSubmitted(
    FormSubmitted event,
    Emitter<RegisterState> emit,
  ) async {
    final firstName = Name.dirty(state.firstName.value);
    final lastname = Name.dirty(state.lastName.value);
    final email = PhoneNumber.dirty(state.email.value);
    final password = Password.dirty(state.password.value);
    final phoneNumber = PhoneNumber.dirty(state.phoneNumber.value);
    emit(
      state.copyWith(
        firstName: firstName,
        lastName: lastname,
        email: email,
        password: password,
        phoneNumber: phoneNumber,
        isValid: Formz.validate([firstName, lastname, email, password, phoneNumber]),
      ),
    );
    if (state.isValid) {
      await Future.delayed(const Duration(milliseconds: 1));
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      // final res = await authRepo.signUp(
      //   firstName: state.firstName.value,
      //   lastName: state.lastName.value,
      //   email: state.email.value,
      //   phoneNumber: state.phoneNumber.value,
      //   password: state.password.value,
      // );
      // res.fold(
      //   (l) {
      //     print(l);
      //     print(l.message);
      //     emit(
      //       state.copyWith(
      //         status: FormzSubmissionStatus.failure,
      //       ),
      //     );
      //   },
      //   (r) async {
      //     print(r);
      //     state.copyWith(
      //       status: FormzSubmissionStatus.success,
      //     );
      //   },
      // );
    }
  }
}
