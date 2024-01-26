import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:extreme_store/presentation/authentication/model_view/events/add_new_password_event.dart';
import 'package:extreme_store/presentation/authentication/model_view/models/password.dart';
import 'package:extreme_store/presentation/authentication/model_view/states/add_new_password_state.dart';

import '../../../../domain/repositories/auth_repo.dart';

class AddNewPasswordBloc extends Bloc<AddNewPasswordEvent, AddNewPasswordState> {
  final AuthRepo authRepo;
  final String email;
  final String code;

  AddNewPasswordBloc({
    required this.authRepo,
    required this.email,
    required this.code,
  }) : super(const AddNewPasswordState()) {
    on<PasswordChanged>(_onPasswordChanged);
    on<PasswordUnfocused>(_onPasswordUnfocused);
    on<AddPasswordFormSubmitted>(_onFormSubmitted);
  }
  void _onPasswordChanged(PasswordChanged event, Emitter<AddNewPasswordState> emit) {
    final password = Password.dirty(event.password);
    emit(
      state.copyWith(
        password: password.isValid ? password : Password.pure(event.password),
        isValid: Formz.validate([password]),
      ),
    );
  }

  void _onPasswordUnfocused(PasswordUnfocused event, Emitter<AddNewPasswordState> emit) {
    final password = Password.dirty(state.password.value);
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([password]),
      ),
    );
  }

  Future<void> _onFormSubmitted(
    AddPasswordFormSubmitted event,
    Emitter<AddNewPasswordState> emit,
  ) async {
    final password = Password.dirty(state.password.value);
    emit(
      state.copyWith(password: password, isValid: Formz.validate([password])),
    );

    if (state.isValid) {
      await Future.delayed(const Duration(milliseconds: 1));
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      final res = await authRepo.addNewPassword(email: email, code: code,password: password.value);
      res.fold(
        (l) {
          emit(state.copyWith(
            errorMessage: l.message,
            status: FormzSubmissionStatus.failure,
          ));
        },
        (r) => emit(state.copyWith(status: FormzSubmissionStatus.success)),
      );
    }
  }
}
