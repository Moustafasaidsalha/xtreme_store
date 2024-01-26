import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:extreme_store/app/enums/state_status.dart';
import 'package:extreme_store/presentation/addresses/model_view/map_cubit/map_states.dart';

import '../../../../app/helper/location_helper.dart';
import '../../../../domain/repositories/user_preference_repo.dart';

class MapCubit extends Cubit<MapStates> {
  final UserPreferenceRepo userPreferenceRepo;
  MapCubit({required this.userPreferenceRepo}) : super(const MapStates());

  Future<void> getCurrentPosition() async {
    emit(state.copyWith(
      mapStates: StateStatus.loading,
      buttonStatus: FormzSubmissionStatus.initial,
    ));
    try {
      var position = await LocationHelper.getCurrentLocation();
      emit(state.copyWith(
          mapStates: StateStatus.success,
          currentLatLang: LatLng(
            position.latitude,
            position.longitude,
          ),
          buttonStatus: FormzSubmissionStatus.success));
    } on Exception catch (_) {
      emit(state.copyWith(mapStates: StateStatus.failure));
    }
  }

  void setNewMarker({required LatLng latLng}) {
    emit(state.copyWith(buttonStatus: FormzSubmissionStatus.inProgress));

    Set<Marker> newMarkers = {};
    newMarkers.add(
      Marker(
        markerId: MarkerId(latLng.toString()),
        position: latLng,
        icon: BitmapDescriptor.defaultMarker,
      ),
    );
    emit(state.copyWith(
      markers: newMarkers,
      currentLatLang: latLng,
      buttonStatus: FormzSubmissionStatus.success,
    ));
  }

  void confirmLocation({required double lat, required double long}) {
    emit(state.copyWith(buttonStatus: FormzSubmissionStatus.inProgress));
    userPreferenceRepo.insertLat(value: lat);
    userPreferenceRepo.insertLong(value: long);
    emit(state.copyWith(buttonStatus: FormzSubmissionStatus.success));
  }
}
