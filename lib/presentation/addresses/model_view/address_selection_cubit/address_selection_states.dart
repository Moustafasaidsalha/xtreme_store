import 'package:equatable/equatable.dart';

import '../../../../data/models/addresses_response_model.dart';

abstract class AddressSelectionStates extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitAddressSelection extends AddressSelectionStates {}

class LoadingAddressSelection extends AddressSelectionStates {}

class FailureAddressSelection extends AddressSelectionStates {
  final String message;

  FailureAddressSelection({required this.message});
  @override
  List<Object?> get props => [message];
}

class NoUserFoundAddressSelection extends AddressSelectionStates {}

class SuccessAddressSelection extends AddressSelectionStates {
  final List<AddressModel> listOfAddresses;

  SuccessAddressSelection({required this.listOfAddresses});
  @override
  List<Object?> get props => [listOfAddresses];
}
