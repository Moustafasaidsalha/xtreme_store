import 'package:equatable/equatable.dart';
import 'package:extreme_store/data/models/setting.dart';

abstract class AccountStates extends Equatable {}

class InitialAccountState extends AccountStates {
  @override
  List<Object> get props => [];
}

class ChangeLanguageState extends AccountStates { @override
List<Object> get props => [];}

class ChangeCountryState extends AccountStates { @override
List<Object> get props => [];}

class GetSettingsLoadingState extends AccountStates { @override
List<Object> get props => [];}

class GetSettingsSuccessState extends AccountStates {

  final SettingModel? settingModel;

   GetSettingsSuccessState({
    this.settingModel,
  });

  @override
  List<Object?> get props => [settingModel];
}

class GetSettingsErrorState extends AccountStates { @override
List<Object> get props => [];}
