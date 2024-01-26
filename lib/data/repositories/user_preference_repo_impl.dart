import 'package:extreme_store/data/data_source/local/user_preference_source.dart';
import 'package:extreme_store/domain/repositories/user_preference_repo.dart';

class UserPreferenceRepoImpl implements UserPreferenceRepo {
  final UserPreferenceSource userPreference;
  UserPreferenceRepoImpl({required this.userPreference});

  @override
  String getAccessToken() {
    return userPreference.getStringValue(
      key: UserPreferenceConstants.accessToken,
    );
  }

  @override
  Future<void> insertAccessToken({required String value}) async {
    return await userPreference.insertStringValue(
      key: UserPreferenceConstants.accessToken,
      value: value,
    );
  }

  @override
  String getUserName() {
    return userPreference.getStringValue(
      key: UserPreferenceConstants.userName,
    );
  }

  @override
  Future<void> insertUserName({required String value}) async {
    return await userPreference.insertStringValue(
      key: UserPreferenceConstants.userName,
      value: value,
    );
  }

  @override
  String getLanguage() {
    String value = userPreference.getStringValue(
      key: UserPreferenceConstants.language,
    );
    return value.isNotEmpty ? value : 'en';
  }

  @override
  Future<void> insertLanguage({required String value}) async {
    return await userPreference.insertStringValue(
      key: UserPreferenceConstants.language,
      value: value,
    );
  }

  @override
  String getCountry() {
    return userPreference.getStringValue(
      key: UserPreferenceConstants.country,
    );
  }

  @override
  Future<void> insertCountry({required String value}) async {
    return await userPreference.insertStringValue(
      key: UserPreferenceConstants.country,
      value: value,
    );
  }

  @override
  bool getHideOnBoarding() {
    return userPreference.getBoolValue(
      key: UserPreferenceConstants.showOnBoarding,
    );
  }

  @override
  Future<void> insertHideOnBoarding({required bool value}) async {
    return await userPreference.insertBoolValue(
      key: UserPreferenceConstants.showOnBoarding,
      value: value,
    );
  }

  @override
  int getSelectedCountryID() {
    return userPreference.getIntValue(
      key: UserPreferenceConstants.selectedCountryID,
      defaultValue: 1,
    );
  }

  @override
  Future<void> insertSelectedCountryID({required int value}) async {
    return await userPreference.insertIntValue(
      key: UserPreferenceConstants.selectedCountryID,
      value: value,
    );
  }

  @override
  double getLat() {
    return userPreference.getDoubleValue(
      key: UserPreferenceConstants.userLat,
      defaultValue: 1.0,
    );
  }

  @override
  double getLong() {
    return userPreference.getDoubleValue(
      key: UserPreferenceConstants.userLong,
      defaultValue: 1.0,
    );
  }

  @override
  Future<void> insertLat({required double value}) async {
    return await userPreference.insertDoubleValue(
      key: UserPreferenceConstants.userLat,
      value: value,
    );
  }

  @override
  Future<void> insertLong({required double value}) async {
    return await userPreference.insertDoubleValue(
      key: UserPreferenceConstants.userLong,
      value: value,
    );
  }

  @override
  String getAppLogo() {
    return userPreference.getStringValue(
      key: UserPreferenceConstants.appLogo,
    );
  }

  @override
  Future<void> insertAppLogo({required String value}) async{
    return await userPreference.insertStringValue(
      key: UserPreferenceConstants.appLogo,
      value: value,
    );
  }

  @override
  String getLabelColor() {
    return userPreference.getStringValue(
      key: UserPreferenceConstants.labelColor,
    );
  }

  @override
  String getMainColor() {
    return userPreference.getStringValue(
      key: UserPreferenceConstants.mainColor,
    );
  }

  @override
  Future<void> insertLabelColor({required String value}) async{
    return await userPreference.insertStringValue(
      key: UserPreferenceConstants.labelColor,
      value: value,
    );
  }

  @override
  Future<void> insertMainColor({required String value}) async{
    return await userPreference.insertStringValue(
      key: UserPreferenceConstants.mainColor,
      value: value,
    );
  }
}
