import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:extreme_store/presentation/authentication/model_view/events/change_pin_events.dart';
import 'package:extreme_store/presentation/authentication/model_view/models/pin_code.dart';
import 'package:extreme_store/presentation/authentication/model_view/states/change_pin_state.dart';

import '../../../../domain/repositories/auth_repo.dart';

class ChangePinBloc extends Bloc<ChangePinEvents, ChangePinState> {
  final AuthRepo authRepo;

  ChangePinBloc({
    required this.authRepo,
  }) : super(const ChangePinState()) {
    on<OldPinChanged>(_onOldPinChanged);
    on<OldPinUnfocused>(_onOldPinUnfocused);
    on<NewPinChanged>(_onNewPinChanged);
    on<NewPinUnfocused>(_onNewPinUnfocused);
    on<ChangePinSubmitted>(_onFormSubmitted);
  }

  void _onOldPinChanged(OldPinChanged event, Emitter<ChangePinState> emit) {
    final oldPin = PinCode.dirty(event.pinCode);
    emit(
      state.copyWith(
        oldPin: oldPin.isValid ? oldPin : PinCode.pure(event.pinCode),
        isValid: Formz.validate([oldPin, state.newPin]),
      ),
    );
  }

  void _onOldPinUnfocused(OldPinUnfocused event, Emitter<ChangePinState> emit) {
    final oldPin = PinCode.dirty(state.oldPin.value);
    emit(
      state.copyWith(
        oldPin: oldPin,
        isValid: Formz.validate([oldPin, state.newPin]),
      ),
    );
  }

  FutureOr<void> _onNewPinChanged(NewPinChanged event, Emitter<ChangePinState> emit) {
    final newPin = PinCode.dirty(event.pinCode);
    emit(
      state.copyWith(
        newPin: newPin.isValid ? newPin : PinCode.pure(event.pinCode),
        isValid: Formz.validate([state.oldPin, newPin]),
      ),
    );
  }

  FutureOr<void> _onNewPinUnfocused(NewPinUnfocused event, Emitter<ChangePinState> emit) {
    final newPin = PinCode.dirty(state.newPin.value);
    emit(
      state.copyWith(
        newPin: newPin,
        isValid: Formz.validate([state.oldPin, newPin]),
      ),
    );
  }

  Future<void> _onFormSubmitted(
    ChangePinSubmitted event,
    Emitter<ChangePinState> emit,
  ) async {
    final oldPin = PinCode.dirty(state.oldPin.value);
    final newPin = PinCode.dirty(state.newPin.value);
    emit(
      state.copyWith(oldPin: oldPin, newPin: newPin, isValid: Formz.validate([oldPin, newPin])),
    );

    if (state.isValid) {
      await Future.delayed(const Duration(milliseconds: 1));
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

      final res = await authRepo.changePinCode(oldPin:oldPin.value ,newPin: newPin.value);
      res.fold(
        (l) {
          emit(state.copyWith(
            message: l.message,
            status: FormzSubmissionStatus.failure,
          ));
        },
        (r) => emit(state.copyWith(status: FormzSubmissionStatus.success,message: r.message)),
      );
    }
  }
}
