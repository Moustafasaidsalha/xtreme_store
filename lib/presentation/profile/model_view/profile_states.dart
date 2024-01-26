import 'package:equatable/equatable.dart';
import 'package:extreme_store/data/models/profile.dart';
import 'package:extreme_store/presentation/product_details/model_view/product_details_states.dart';

class ProfileStates extends Equatable {
  final RequestStates getProfileState;
  final RequestStates editProfileState;
  final ProfilesModel? profilesModel;
  final String message;

  @override
  List<Object?> get props => [getProfileState, editProfileState, profilesModel, message];

  const ProfileStates({
    this.getProfileState = RequestStates.loading,
    this.editProfileState = RequestStates.loading,
    this.profilesModel,
    this.message = '',
  });
  ProfileStates copyWith({
    RequestStates? getProfileState,
    RequestStates? editProfileState,
    ProfilesModel? profilesModel,
    String? message,
  }) {
    return ProfileStates(
      profilesModel: profilesModel ?? this.profilesModel,
      editProfileState: editProfileState ?? this.editProfileState,
      getProfileState: getProfileState ?? this.getProfileState,
      message: message ?? this.message,
    );
  }
}

// class InitialState extends ProfileStates {
//   @override
//   List<Object> get props => [];
// }
//
// class GetProfileLoadingState extends ProfileStates {
//   @override
//   List<Object> get props => [];
// }
//
// class GetProfileSuccessState extends ProfileStates {
//   final ProfilesModel? profilesModel;
//
//   GetProfileSuccessState({
//     this.profilesModel,
//   });
//
//   @override
//   List<Object?> get props => [profilesModel];
// }
//
// class GetProfileErrorState extends ProfileStates {
//   @override
//   List<Object> get props => [];
// }
//
// class EditProfileLoadingState extends ProfileStates {  @override
// List<Object> get props => [];}
//
// class EditProfileSuccessState extends ProfileStates {  @override
// List<Object> get props => [];}
//
// class EditProfileErrorState extends ProfileStates {  @override
// List<Object> get props => [];}
