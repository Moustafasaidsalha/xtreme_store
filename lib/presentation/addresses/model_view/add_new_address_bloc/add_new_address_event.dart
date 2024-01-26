import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:extreme_store/data/models/area_model.dart';
import 'package:extreme_store/data/models/phone_number_response_model.dart';

import '../../../../data/models/addresses_response_model.dart';

abstract class AddNewAddressEvent extends Equatable {
  const AddNewAddressEvent();

  @override
  List<Object> get props => [];
}

class GetCurrentAddress extends AddNewAddressEvent {
  final LatLng currentLatLng;

  const GetCurrentAddress({required this.currentLatLng});
  @override
  List<Object> get props => [currentLatLng];
}

class ChangeCountry extends AddNewAddressEvent {
  final int countryID;

  const ChangeCountry({required this.countryID});
  @override
  List<Object> get props => [countryID];
}

class GetAreas extends AddNewAddressEvent {
  final int countryId;

  const GetAreas({required this.countryId});
  @override
  List<Object> get props => [countryId];
}

class SelectAreaEvent extends AddNewAddressEvent {
  final AreaModel areaModel;

  const SelectAreaEvent({required this.areaModel});
  @override
  List<Object> get props => [areaModel];
}

class SearchAreaEvent extends AddNewAddressEvent {
  final String searchKeyWord;

  const SearchAreaEvent({required this.searchKeyWord});
  @override
  List<Object> get props => [searchKeyWord];
}

class ChangeAddressName extends AddNewAddressEvent {
  final String addressName;

  const ChangeAddressName({required this.addressName});
  @override
  List<Object> get props => [addressName];
}

class ChangeAddressType extends AddNewAddressEvent {
  final String addressType;

  const ChangeAddressType({required this.addressType});
  @override
  List<Object> get props => [addressType];
}

class SaveNewAddress extends AddNewAddressEvent {
  final AddAddressModel addAddressModel;

  const SaveNewAddress({required this.addAddressModel});
  @override
  List<Object> get props => [addAddressModel];
}

class GetUserPhoneNumbers extends AddNewAddressEvent {}

class SelectUserPhoneNumbers extends AddNewAddressEvent {
  final PhoneNumberModel phoneNumberModel;

  const SelectUserPhoneNumbers({required this.phoneNumberModel});
  @override
  List<Object> get props => [phoneNumberModel];
}

class AddUserPhoneNumbers extends AddNewAddressEvent {
  final String phoneNumber;
  final String countryCode;

  const AddUserPhoneNumbers({
    required this.phoneNumber,
    required this.countryCode,
  });
  @override
  List<Object> get props => [
        phoneNumber,
        countryCode,
      ];
}

class VerifyUserPhoneNumbers extends AddNewAddressEvent {
  final String phoneNumber;
  final String countryCode;
  final String code;

  const VerifyUserPhoneNumbers({
    required this.phoneNumber,
    required this.countryCode,
    required this.code,
  });
  @override
  List<Object> get props => [phoneNumber, countryCode, code];
}
