import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:extreme_store/app/constants/icon_constants.dart';
import 'package:extreme_store/app/constants/strings_constants.dart';
import 'package:extreme_store/app/failure/failure.dart';
import 'package:extreme_store/app/services/language_pref.dart';
import 'package:extreme_store/app/use_case/use_case.dart';
import 'package:extreme_store/data/models/setting.dart';
import 'package:extreme_store/domain/repositories/auth_repo.dart';
import 'package:extreme_store/domain/repositories/user_preference_repo.dart';
import 'package:extreme_store/domain/uses_cases/profile/get_settings.dart';
import 'package:extreme_store/presentation/my_account/widgets/choose_countery_widget.dart';
import 'package:extreme_store/presentation/my_account/widgets/choose_language_widget.dart';
import 'package:extreme_store/presentation/my_account/widgets/logoutdialog_widget.dart';

import '../../../data/models/response.dart';
import 'account_state.dart';

class AccountCubit extends Cubit<AccountStates> {
  AccountCubit({
    required this.userPreferenceRepo,
    required this.getSettingsUseCase,
    required this.authRepo,
  }) : super(InitialAccountState());
  static AccountCubit get(context) => BlocProvider.of(context);
  final UserPreferenceRepo userPreferenceRepo;
  final GetSettingsUseCase getSettingsUseCase;
  final AuthRepo authRepo;

  Future<dynamic> logOut(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => const LogoutDialog(),
    );
  }

  Future<dynamic> chooseCountry(BuildContext context) async {
    return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => ChooseCountry(
        userPreferenceRepo: userPreferenceRepo,
      ),
    );
  }

  Future<dynamic> chooseLanguage(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => ChooseLanguageWidget(),
    );
  }

  void changeLanguage(int index, BuildContext context) {
    if (index == 0) {
      context
          .setLocale(const Locale("en", "US"))
          .then((value) => Navigator.pop(context));
      userPreferenceRepo.insertLanguage(value: LanguageType.english.getValue());
      emit(ChangeLanguageState());
    } else {
      context
          .setLocale(const Locale("ar", "EG"))
          .then((value) => Navigator.pop(context));
      userPreferenceRepo.insertLanguage(value: LanguageType.arabic.getValue());

      emit(ChangeLanguageState());
    }
  }

  final List<String> countries = [
    StringsConstants.kuwait,
    StringsConstants.saudi,
    StringsConstants.emarat,
    StringsConstants.qatar,
    StringsConstants.oman,
    StringsConstants.bahrain,
  ];
  String flag = IconsConstants.kuwait;
  // void changeCountry(int index, BuildContext context, String countryFlag) {
  //   userPreferenceRepo
  //       .insertCountry(value: countries[index])
  //       .then((value) => Navigator.pop(context));
  //   flag = countryFlag;
  //   print(flag);
  //
  //   emit(ChangeCountryState());
  // }
  void changeCountry(int id, BuildContext context) {
    userPreferenceRepo.insertSelectedCountryID(value: id);
    emit(ChangeCountryState());
    // Navigator.pushReplacementNamed(context, RoutesConstant.homeLanding);
    Navigator.pop(context);

    // userPreferenceRepo
    //     .insertCountry(value: countries[index])
    //     .then((value) => Navigator.pop(context));
    // userPreferenceRepo.insertSelectedCountryID(
    //   value: userSelectedCountryId,
    // );
  }

  SettingModel? settingModel;

  Future<void> getSettings() async {
    emit(GetSettingsLoadingState());
    var response = await getSettingsUseCase(NoParams());
    response.fold((l) {
      ServerFailure(l.message);

      emit(GetSettingsErrorState());
    }, (r) {
      // settingModel=SettingModel("snapchat", "https://www.youtube.com/", null, null, "https://www.youtube.com/", "tiktok")    ;
      settingModel = r.settingModel;
      emit(GetSettingsSuccessState(settingModel: r.settingModel));
    });
  }

  Future<Either<Failure, ResponseModel>> doLogout() async {
    return await authRepo.logout();
  }

  Future<Either<Failure, ResponseModel>> doDeleteAccount() async {
    return await authRepo.deleteUser();
  }
}
