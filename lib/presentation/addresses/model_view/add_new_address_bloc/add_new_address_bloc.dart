import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:extreme_store/app/enums/state_status.dart';
import 'package:extreme_store/data/models/area_model.dart';
import 'package:extreme_store/presentation/addresses/model_view/add_new_address_bloc/add_new_address_event.dart';
import 'package:extreme_store/presentation/addresses/model_view/add_new_address_bloc/add_new_address_state.dart';

import '../../../../domain/repositories/base_repository.dart';
import '../../../../domain/repositories/user_preference_repo.dart';
import '../../../../domain/uses_cases/address/get_area.dart';

enum AddressType { house, office, building }

class AddNewAddressBloc extends Bloc<AddNewAddressEvent, AddNewAddressState> {
  final BaseRepository baseRepository;
  final GetArea getArea;
  final UserPreferenceRepo userPreferenceRepo;
  AddNewAddressBloc({
    required this.baseRepository,
    required this.getArea,
    required this.userPreferenceRepo,
  }) : super(const AddNewAddressState()) {
    on<GetCurrentAddress>(_onGetCurrentAddress);
    on<SaveNewAddress>(_onSaveNewAddress);
    on<GetAreas>(_onGetAreas);
    on<SelectAreaEvent>(_onSelectArea);
    on<SearchAreaEvent>(_onSearchArea);
    on<ChangeAddressName>(_onChangeAddressName);
    on<ChangeAddressType>(_onChangeAddressType);
    on<GetUserPhoneNumbers>(_onGetUerPhoneNumbers);
    on<SelectUserPhoneNumbers>(_onSelectUserPhoneNumbers);
    on<AddUserPhoneNumbers>(_onAddUserPhoneNumbers);
    on<VerifyUserPhoneNumbers>(_onVerifyUserPhoneNumbers);
    on<ChangeCountry>(_onChangeCountry);
  }

  List<AreaModel> tempArea = [];
  FutureOr<void> _onGetCurrentAddress(
    GetCurrentAddress event,
    Emitter<AddNewAddressState> emit,
  ) async {
    String address = ''; //ZERO_RESULTS
    emit(state.copyWith(addressFullNameStatus: StateStatus.loading));
    var r = await baseRepository.getFullAddress(
      latLong: "${event.currentLatLng.latitude},${event.currentLatLng.longitude}",
      language: userPreferenceRepo.getLanguage(),
    );
    r.fold(
      (l) => emit(state.copyWith(
        addressFullNameStatus: StateStatus.failure,
        fullAddress: '',
        currentLatLang: event.currentLatLng,
      )),
      (r) {
        if ((r.status ?? '') == 'OK') {
          address = r.results?.first.formattedAddress ?? '';
          emit(state.copyWith(
            addressFullNameStatus: StateStatus.success,
            fullAddress: address,
            currentLatLang: event.currentLatLng,
          ));
        } else {
          emit(state.copyWith(
            addressFullNameStatus: StateStatus.failure,
            fullAddress: '',
            currentLatLang: event.currentLatLng,
          ));
        }
      },
    );
  }

  FutureOr<void> _onSaveNewAddress(
    SaveNewAddress event,
    Emitter<AddNewAddressState> emit,
  ) async {
    emit(state.copyWith(submitStatus: StateStatus.loading));
    if (event.addAddressModel.type == AddressType.house.name &&
        (event.addAddressModel.houseNumber?.isEmpty ?? true)) {
      emit(state.copyWith(
        submitStatus: StateStatus.failure,
        message: "need to add house number",
      ));
    } else if (event.addAddressModel.type == AddressType.office.name &&
        (event.addAddressModel.buildingNumber?.isEmpty ?? true)) {
      emit(state.copyWith(
        submitStatus: StateStatus.failure,
        message: "need to add office number",
      ));
    } else if (event.addAddressModel.type == AddressType.building.name &&
        (event.addAddressModel.houseNumber?.isEmpty ?? true)) {
      emit(state.copyWith(
        submitStatus: StateStatus.failure,
        message: "need to add build number",
      ));
    } else {
      final res = await baseRepository.addAddresses(
        addAddressModel: state.addressType == AddressType.house.name
            ? event.addAddressModel.houseToJson()
            : state.addressType == AddressType.office.name
                ? event.addAddressModel.officeToJson()
                : event.addAddressModel.buildingToJson(),
      );
      res.fold((l) {
        emit(state.copyWith(
          submitStatus: StateStatus.failure,
          message: l.message,
        ));
      }, (r) {
        emit(state.copyWith(
          submitStatus: StateStatus.success,
          message: r.message,
        ));
      });
    }
  }

  FutureOr<void> _onGetAreas(
    GetAreas event,
    Emitter<AddNewAddressState> emit,
  ) async {
    emit(state.copyWith(areaStatus: StateStatus.loading));
    final res = await getArea(GetAreaParams(countryID: event.countryId));
    res.fold((l) {
      emit(state.copyWith(areaStatus: StateStatus.failure));
    }, (r) {
      tempArea = r;
      emit(state.copyWith(areaStatus: StateStatus.success, areas: r));
    });
  }

  FutureOr<void> _onSelectArea(SelectAreaEvent event, Emitter<AddNewAddressState> emit) {
    emit(state.copyWith(selectedAreaModel: event.areaModel));
  }

  FutureOr<void> _onSearchArea(
    SearchAreaEvent event,
    Emitter<AddNewAddressState> emit,
  ) {
    if (state.areaStatus == StateStatus.success && state.areas.isNotEmpty) {
      if (event.searchKeyWord.isNotEmpty) {
        List<AreaModel> filteredList = state.areas
            .where(
              (obj) =>
                  (obj.areaNameEN?.contains(event.searchKeyWord) ?? false) ||
                  (obj.areaNameAR?.contains(event.searchKeyWord) ?? false),
            )
            .toList();

        emit(state.copyWith(areas: filteredList));
      } else {
        emit(state.copyWith(areas: List.from(tempArea)));
      }
    }
  }

  FutureOr<void> _onChangeAddressName(
    ChangeAddressName event,
    Emitter<AddNewAddressState> emit,
  ) {
    emit(state.copyWith(fullAddress: event.addressName));
  }

  FutureOr<void> _onChangeAddressType(
    ChangeAddressType event,
    Emitter<AddNewAddressState> emit,
  ) {
    emit(state.copyWith(addressType: event.addressType));
  }

  FutureOr<void> _onGetUerPhoneNumbers(
    GetUserPhoneNumbers event,
    Emitter<AddNewAddressState> emit,
  ) async {
    emit(state.copyWith(phoneNumberStatus: StateStatus.loading));
    final res = await baseRepository.getUserPhoneNumber();
    res.fold(
      (l) {
        emit(state.copyWith(phoneNumberStatus: StateStatus.failure));
      },
      (r) {
        emit(state.copyWith(
          phoneNumberStatus: StateStatus.success,
          userPhoneNumbers: r.phoneNumbers,
          selectedPhoneNumber: r.phoneNumbers?.first,
        ));
      },
    );
  }

  FutureOr<void> _onSelectUserPhoneNumbers(
    SelectUserPhoneNumbers event,
    Emitter<AddNewAddressState> emit,
  ) {
    emit(state.copyWith(selectedPhoneNumber: event.phoneNumberModel));
  }

  FutureOr<void> _onAddUserPhoneNumbers(
    AddUserPhoneNumbers event,
    Emitter<AddNewAddressState> emit,
  ) async {
    final res = await baseRepository.addUSerPhoneNumber(
      phoneNumber: event.phoneNumber,
      countryCode: event.countryCode,
    );
    res.fold(
      (l) {
        if (kDebugMode) {
          print(l);
        }
        emit(state.copyWith(
          addPhoneMessage: l.message,
        ));
      },
      (r) {
        emit(state.copyWith(
          isLoadingOTP: true,
          addPhoneMessage: '',
        ));
      },
    );
  }

  FutureOr<void> _onVerifyUserPhoneNumbers(
    VerifyUserPhoneNumbers event,
    Emitter<AddNewAddressState> emit,
  ) async {
    bool isSuccess = false;
    final res = await baseRepository.verifyUserNumber(
      phoneNumber: event.phoneNumber,
      countryCode: event.countryCode,
      code: event.code,
    );
    res.fold(
      (l) {
        emit(state.copyWith(
          addPhoneMessage: l.message,
        ));
      },
      (r) {
        isSuccess = true;
        emit(state.copyWith(
          addPhoneMessage: r.message,
          isLoadingOTP: false,
        ));
      },
    );
    if (isSuccess) {
      final res = await baseRepository.getUserPhoneNumber();
      res.fold(
        (l) {
          emit(state.copyWith(phoneNumberStatus: StateStatus.failure));
        },
        (r) {
          emit(state.copyWith(
            addPhoneMessage: '',
            phoneNumberStatus: StateStatus.success,
            userPhoneNumbers: r.phoneNumbers,
            selectedPhoneNumber: r.phoneNumbers?.first,
          ));
        },
      );
    }
  }

  FutureOr<void> _onChangeCountry(ChangeCountry event, Emitter<AddNewAddressState> emit) {
    emit(state.copyWith(currentCountryID: event.countryID));
  }
}
