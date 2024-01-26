import 'package:equatable/equatable.dart';

abstract class ChangePinEvents extends Equatable {
  const ChangePinEvents();

  @override
  List<Object> get props => [];
}

class OldPinChanged extends ChangePinEvents {
  const OldPinChanged({required this.pinCode});

  final String pinCode;

  @override
  List<Object> get props => [pinCode];
}

class OldPinUnfocused extends ChangePinEvents {}

class NewPinChanged extends ChangePinEvents {
  const NewPinChanged({required this.pinCode});

  final String pinCode;

  @override
  List<Object> get props => [pinCode];
}

class NewPinUnfocused extends ChangePinEvents {}

class ChangePinSubmitted extends ChangePinEvents {}
