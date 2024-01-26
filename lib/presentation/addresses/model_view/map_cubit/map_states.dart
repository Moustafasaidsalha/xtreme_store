import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:extreme_store/app/enums/state_status.dart';

class MapStates extends Equatable {
  final LatLng currentLatLang;
  final Set<Marker> markers;
  final StateStatus mapStates;
  final FormzSubmissionStatus buttonStatus;

  const MapStates({
    this.currentLatLang = const LatLng(0, 0),
    this.markers = const {},
    this.mapStates = StateStatus.initial,
    this.buttonStatus = FormzSubmissionStatus.initial,
  });

  MapStates copyWith({
    LatLng? currentLatLang,
    Set<Marker>? markers,
    StateStatus? mapStates,
    FormzSubmissionStatus? buttonStatus,
  }) {
    return MapStates(
      currentLatLang: currentLatLang ?? this.currentLatLang,
      markers: markers ?? this.markers,
      mapStates: mapStates ?? this.mapStates,
      buttonStatus: buttonStatus ?? this.buttonStatus,
    );
  }

  @override
  List<Object?> get props => [currentLatLang, markers, mapStates, buttonStatus];
}
