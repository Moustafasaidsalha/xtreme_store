import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:extreme_store/app/enums/state_status.dart';
import 'package:extreme_store/data/models/area_model.dart';
import 'package:extreme_store/data/models/phone_number_response_model.dart';

class AddNewAddressState extends Equatable {
  final LatLng currentLatLang;
  final String fullAddress;
  final String addressType;
  final String message;
  final StateStatus addressFullNameStatus;
  final StateStatus submitStatus;
  final StateStatus areaStatus;
  final AreaModel selectedAreaModel;
  final List<AreaModel> areas;
  final StateStatus phoneNumberStatus;
  final List<PhoneNumberModel> userPhoneNumbers;
  final PhoneNumberModel selectedPhoneNumber;
  final bool isLoadingOTP;
  final int currentCountryID;
  final String addPhoneMessage;

  const AddNewAddressState({
    this.currentLatLang = const LatLng(0, 0),
    this.fullAddress = '',
    this.addressType = 'house',
    this.message = '',
    this.addressFullNameStatus = StateStatus.initial,
    this.submitStatus = StateStatus.initial,
    this.areaStatus = StateStatus.initial,
    this.areas = const [],
    this.selectedAreaModel = const AreaModel(),
    this.phoneNumberStatus = StateStatus.initial,
    this.userPhoneNumbers = const [],
    this.selectedPhoneNumber = const PhoneNumberModel(),
    this.isLoadingOTP = false,
    this.currentCountryID = 1,
    this.addPhoneMessage = '',
  });
  AddNewAddressState copyWith({
    LatLng? currentLatLang,
    String? fullAddress,
    String? addressType,
    String? message,
    StateStatus? addressFullNameStatus,
    StateStatus? submitStatus,
    StateStatus? areaStatus,
    List<AreaModel>? areas,
    AreaModel? selectedAreaModel,
    StateStatus? phoneNumberStatus,
    List<PhoneNumberModel>? userPhoneNumbers,
    PhoneNumberModel? selectedPhoneNumber,
    bool? isLoadingOTP,
    int? currentCountryID,
    String? addPhoneMessage,
  }) {
    return AddNewAddressState(
      currentLatLang: currentLatLang ?? this.currentLatLang,
      fullAddress: fullAddress ?? this.fullAddress,
      addressFullNameStatus: addressFullNameStatus ?? this.addressFullNameStatus,
      submitStatus: submitStatus ?? this.submitStatus,
      areaStatus: areaStatus ?? this.areaStatus,
      areas: areas ?? this.areas,
      selectedAreaModel: selectedAreaModel ?? this.selectedAreaModel,
      addressType: addressType ?? this.addressType,
      message: message ?? this.message,
      phoneNumberStatus: phoneNumberStatus ?? this.phoneNumberStatus,
      userPhoneNumbers: userPhoneNumbers ?? this.userPhoneNumbers,
      selectedPhoneNumber: selectedPhoneNumber ?? this.selectedPhoneNumber,
      isLoadingOTP: isLoadingOTP ?? this.isLoadingOTP,
      currentCountryID: currentCountryID ?? this.currentCountryID,
      addPhoneMessage: addPhoneMessage ?? this.addPhoneMessage,
    );
  }

  @override
  List<Object?> get props => [
        currentLatLang,
        fullAddress,
        addressFullNameStatus,
        submitStatus,
        areaStatus,
        areas,
        selectedAreaModel,
        addressType,
        message,
        phoneNumberStatus,
        userPhoneNumbers,
        selectedPhoneNumber,
        isLoadingOTP,
        currentCountryID,
        addPhoneMessage,
      ];
}
