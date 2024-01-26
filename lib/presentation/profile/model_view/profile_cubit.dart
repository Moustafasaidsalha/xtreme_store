import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:extreme_store/app/failure/failure.dart';
import 'package:extreme_store/domain/repositories/user_preference_repo.dart';
import 'package:extreme_store/domain/uses_cases/profile/get_profile.dart';
import 'package:extreme_store/presentation/product_details/model_view/product_details_states.dart';
import 'package:extreme_store/presentation/profile/model_view/profile_states.dart';

import '../../../data/models/users_model.dart';
import '../../../domain/uses_cases/profile/edit_profile.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit(this.getProfileUseCase, this.editProfileUseCase, this.userPreferenceRepo)
      : super(const ProfileStates());

  static ProfileCubit get(context) => BlocProvider.of(context);
  GetProfileUseCase getProfileUseCase;
  EditProfileUseCase editProfileUseCase;

  // UsersModel? usersModel;
  UserPreferenceRepo userPreferenceRepo;
  Future<void> getProfile() async {
    var token = userPreferenceRepo.getAccessToken();
    if (token.isEmpty) {
    } else {
      var result = await getProfileUseCase(GetProfileParams(token: token));
      result.fold((l) {
        ServerFailure(l.message);
        emit(state.copyWith(getProfileState: RequestStates.error));
      }, (r) {
        emit(state.copyWith(getProfileState: RequestStates.success, profilesModel: r));
      });
    }
  }

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  Future<void> editProfile(EditProfileModel userModel) async {
    var token = userPreferenceRepo.getAccessToken();
if(token.isEmpty){

}else{
  var result = await editProfileUseCase(EditProfileParams(token: token, usersModel: userModel));
  result.fold((l) {
    ServerFailure(l.message);

    emit(state.copyWith(editProfileState: RequestStates.error, message: l.message));
  }, (r) {
    getProfile();
    emit(state.copyWith(
      editProfileState: RequestStates.success,
      message: r.message,
    ));
  });
}

  }
}
