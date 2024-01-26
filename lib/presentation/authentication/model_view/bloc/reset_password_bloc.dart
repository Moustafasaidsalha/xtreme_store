import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:extreme_store/presentation/authentication/model_view/events/reset_password_event.dart';
import 'package:extreme_store/presentation/authentication/model_view/states/reset_password_state.dart';

import '../../../../domain/repositories/auth_repo.dart';
import '../models/email.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  final AuthRepo authRepo;

  ResetPasswordBloc({
    required this.authRepo,
  }) : super(const ResetPasswordState()) {
    on<RestPasswordEmailChanged>(_onEmailChanged);
    on<ResetPasswordEmailUnfocused>(_onEmailUnfocused);
    on<ResetPasswordFormSubmitted>(_onFormSubmitted);
  }
  void _onEmailChanged(RestPasswordEmailChanged event, Emitter<ResetPasswordState> emit) {
    final email = Email.dirty(event.email);
    emit(
      state.copyWith(
        email: email.isValid ? email : Email.pure(event.email),
        isValid: Formz.validate([email]),
      ),
    );
  }

  void _onEmailUnfocused(ResetPasswordEmailUnfocused event, Emitter<ResetPasswordState> emit) {
    final email = Email.dirty(state.email.value);
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([email]),
      ),
    );
  }

  Future<void> _onFormSubmitted(
    ResetPasswordFormSubmitted event,
    Emitter<ResetPasswordState> emit,
  ) async {
    final email = Email.dirty(state.email.value);
    emit(
      state.copyWith(email: email, isValid: Formz.validate([email])),
    );

    if (state.isValid) {
      await Future.delayed(const Duration(milliseconds: 1));
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      final res = await authRepo.resetPassword(email: email.value);
      res.fold(
        (l) {
          emit(state.copyWith(
            errorMessage: l.message,
            status: FormzSubmissionStatus.failure,
          ));
        },
        (r) => emit(state.copyWith(status: FormzSubmissionStatus.success,errorMessage: r.message)),
      );
    }
  }
}
