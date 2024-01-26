import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:extreme_store/presentation/authentication/model_view/events/reset_password_check_code_event.dart';
import 'package:extreme_store/presentation/authentication/model_view/states/reset_password_check_code_state.dart';

import '../../../../domain/repositories/auth_repo.dart';
import '../models/code.dart';

class ResetPasswordCheckCodeBloc
    extends Bloc<ResetPasswordCheckCodeEvent, ResetPasswordCheckCodeState> {
  final AuthRepo authRepo;
  final String email;

  ResetPasswordCheckCodeBloc({
    required this.authRepo,
    required this.email,
  }) : super(const ResetPasswordCheckCodeState()) {
    on<CodeChanged>(_onCodeChanged);
    on<CodeUnfocused>(_onCodeUnfocused);
    on<CheckCodeFormSubmitted>(_onFormSubmitted);
  }
  void _onCodeChanged(CodeChanged event, Emitter<ResetPasswordCheckCodeState> emit) {
    final code = Code.dirty(event.code);
    emit(
      state.copyWith(
        code: code.isValid ? code : Code.pure(event.code),
        isValid: Formz.validate([code]),
      ),
    );
  }

  void _onCodeUnfocused(CodeUnfocused event, Emitter<ResetPasswordCheckCodeState> emit) {
    final code = Code.dirty(state.code.value);
    emit(
      state.copyWith(
        code: code,
        isValid: Formz.validate([code]),
      ),
    );
  }

  Future<void> _onFormSubmitted(
    CheckCodeFormSubmitted event,
    Emitter<ResetPasswordCheckCodeState> emit,
  ) async {
    final code = Code.dirty(state.code.value);
    emit(
      state.copyWith(code: code, isValid: Formz.validate([code])),
    );

    if (state.isValid) {
      await Future.delayed(const Duration(milliseconds: 1));
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      final res = await authRepo.checkResetPasswordCode(email: email, code: code.value);
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
