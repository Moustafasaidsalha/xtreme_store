import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:extreme_store/app/use_case/use_case.dart';
import 'package:extreme_store/domain/repositories/user_preference_repo.dart';

import '../../../../domain/repositories/auth_repo.dart';
import '../../../../domain/uses_cases/cart/migrate_local_cart_t_online.dart';
import '../events/verify_user_event.dart';
import '../models/code.dart';
import '../states/verify_user_states.dart';

class VerifyUserBloc extends Bloc<VerifyUserEvent, VerifyUserState> {
  final AuthRepo authRepo;
  final UserPreferenceRepo userPreferenceRepo;
  final String phoneNumber;
  final String countryCode;
  final String type;
  final MigrateLocalCartToOnline migrateLocalCartToOnline;

  VerifyUserBloc({
    required this.phoneNumber,
    required this.countryCode,
    required this.authRepo,
    required this.userPreferenceRepo,
    required this.type,
    required this.migrateLocalCartToOnline,
  }) : super(const VerifyUserState()) {
    on<CodeChanged>(_onCodeChanged);
    on<CodeUnfocused>(_onCodeUnfocused);
    on<VerifyUserFormSubmitted>(_onFormSubmitted);
    on<ResendCode>(_onResendCode);
  }

  void _onCodeChanged(CodeChanged event, Emitter<VerifyUserState> emit) {
    final code = Code.dirty(event.code);
    emit(
      state.copyWith(
        code: code.isValid ? code : Code.pure(event.code),
        isValid: Formz.validate([code]),
      ),
    );
  }

  void _onCodeUnfocused(CodeUnfocused event, Emitter<VerifyUserState> emit) {
    final code = Code.dirty(state.code.value);
    emit(
      state.copyWith(
        code: code,
        isValid: Formz.validate([code]),
      ),
    );
  }

  Future<void> _onFormSubmitted(
    VerifyUserFormSubmitted event,
    Emitter<VerifyUserState> emit,
  ) async {
    final code = Code.dirty(state.code.value);
    emit(
      state.copyWith(code: code, isValid: Formz.validate([code])),
    );

    if (state.isValid) {
      await Future.delayed(const Duration(milliseconds: 1));
      emit(state.copyWith(verifyStatus: FormzSubmissionStatus.inProgress));

      final res = await authRepo.verifyUser(
        phoneNumber: phoneNumber,
        // countryCode: countryCode,
        countryCode: "+20",
        code: code.value,
        type: type,
      );

      res.fold(
        (l) {
          emit(state.copyWith(
            errorMessage: l.message,
            verifyStatus: FormzSubmissionStatus.failure,
          ));
        },
        (r) {
          userPreferenceRepo.insertHideOnBoarding(value: true);
          userPreferenceRepo.insertAccessToken(value: r.accessToken);
          // emit(state.copyWith(verifyStatus: FormzSubmissionStatus.success));
        },
      );

      if(res.isRight()){
        await migrateLocalCartToOnline(NoParams());
        emit(state.copyWith(verifyStatus: FormzSubmissionStatus.success));

      }

    }
  }

  FutureOr<void> _onResendCode(
    ResendCode event,
    Emitter<VerifyUserState> emit,
  ) async {
    emit(state.copyWith(resendStatus: FormzSubmissionStatus.inProgress));
    if (type == 'signup') {
      final res = await authRepo.signUp(
        phoneNumber: phoneNumber,
        countryCode: countryCode, firstName: '', lastName: '', email: '', pin: '',
      );
      res.fold(
        (l) {
          emit(state.copyWith(
            errorMessage: l.message,
            resendStatus: FormzSubmissionStatus.failure,
          ));
        },
        (r) {
          emit(state.copyWith(
            resendStatus: FormzSubmissionStatus.success,
            errorMessage: r.message,
          ));
        },
      );
    } else {
      final res = await authRepo.login(
        phoneNumber: phoneNumber,
        countryCode: countryCode, pin: '',
      );
      res.fold(
        (l) {
          emit(state.copyWith(
            errorMessage: l.message,
            resendStatus: FormzSubmissionStatus.failure,
          ));
        },
        (r) {
          emit(state.copyWith(
            resendStatus: FormzSubmissionStatus.success,
            errorMessage: r.message,
          ));
        },
      );
    }
  }
}
