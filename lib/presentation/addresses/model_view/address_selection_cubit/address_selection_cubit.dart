import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:extreme_store/app/constants/strings_constants.dart';
import 'package:extreme_store/app/failure/failure.dart';
import 'package:extreme_store/app/use_case/use_case.dart';
import 'package:extreme_store/domain/repositories/user_preference_repo.dart';
import 'package:extreme_store/domain/uses_cases/address/get_addresses.dart';
import 'package:extreme_store/presentation/addresses/model_view/address_selection_cubit/address_selection_states.dart';

import '../../../../app/enums/state_status.dart';
import '../../../../domain/repositories/base_repository.dart';
import '../add_new_address_bloc/add_new_address_bloc.dart';

class AddressSelectionCubit extends Cubit<AddressSelectionStates> {
  AddressSelectionCubit({
    required this.userPreferenceRepo,
    required this.getAddressesUseCase,
    required this.baseRepository,
    required this.addNewAddressBloc,
  }) : super(InitAddressSelection()) {
    streamSubscription = addNewAddressBloc.stream.listen((event) {
      if (event.submitStatus == StateStatus.success) {
        getAddresses();
      }
    });
  }

  final UserPreferenceRepo userPreferenceRepo;
  final GetAddressesUseCase getAddressesUseCase;
  final BaseRepository baseRepository;
  final AddNewAddressBloc addNewAddressBloc;

  late StreamSubscription streamSubscription;

  int x = 0;
  Future<void> getAddresses() async {
    if (kDebugMode) {
      print(" in get address ${++x}");
    }
    final userToken = userPreferenceRepo.getAccessToken();
    if (userToken.isNotEmpty) {
      if (state is InitAddressSelection) {
        emit(LoadingAddressSelection());
      }
      final res = await getAddressesUseCase(NoParams());
      return res.fold((l) {
        emit(FailureAddressSelection(
          message: l is ServerFailure ? l.message : StringsConstants.someThingWrong,
        ));
      }, (r) {
        emit(SuccessAddressSelection(listOfAddresses: r));
      });
    } else {
      return emit(NoUserFoundAddressSelection());
    }
  }

  Future<void> deleteAddress({required int addressID}) async {
    final res = await baseRepository.deleteAddress(addressID: addressID);
    res.fold((l) {
      emit(FailureAddressSelection(message: l.message));
    }, (r) async {
      await getAddresses();
    });
  }

  Future<void> changeDefaultAddress({required int addressID}) async {
    final res = await baseRepository.putDefaultAddress(addressID: addressID);
    res.fold((l) {
      emit(FailureAddressSelection(message: l.message));
    }, (r) async {
      await getAddresses();
    });
  }

  @override
  Future<void> close() async {
    await streamSubscription.cancel();
    return super.close();
  }
}
