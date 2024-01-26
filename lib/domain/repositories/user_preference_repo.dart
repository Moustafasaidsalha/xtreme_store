abstract class UserPreferenceRepo {
  Future<void> insertAccessToken({required String value});
  String getAccessToken();
  Future<void> insertUserName({required String value});
  Future<void> insertMainColor({required String value});
  Future<void> insertLabelColor({required String value});
  String getMainColor();
  String getLabelColor();
  String getUserName();
  Future<void> insertAppLogo({required String value});
  String getAppLogo();
  Future<void> insertLanguage({required String value});
  String getLanguage();
  Future<void> insertCountry({required String value});

  ///TODO Need to check if needed
  String getCountry();
  Future<void> insertSelectedCountryID({required int value});
  int getSelectedCountryID();
  Future<void> insertHideOnBoarding({required bool value});
  bool getHideOnBoarding();
  Future<void> insertLat({required double value});
  double getLat();
  Future<void> insertLong({required double value});
  double getLong();
}
