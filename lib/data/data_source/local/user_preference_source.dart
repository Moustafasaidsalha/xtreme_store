import 'package:hive/hive.dart';

class UserPreferenceConstants {
  static const String boxName = 'UserPreferenceBox';
  static const String accessToken = 'accessToken';
  static const String userName = 'userName';
  static const String isLoggedIn = 'isLoggedIn';
  static const String language = 'language';
  static const String country = 'country';
  static const String selectedCountryID = 'selectedCountryID';
  static const String showOnBoarding = 'showOnBoarding';
  static const String userLat = 'userLat';
  static const String userLong = 'userLong';
  static const String appLogo = 'appLogo';
  static const String mainColor = 'mainColor';
  static const String labelColor = 'labelColor';
}

class UserPreferenceSource {
  final Box userPreferenceBox;

  UserPreferenceSource({required this.userPreferenceBox});

  Future<void> insertStringValue({
    required String key,
    required String value,
  }) async {
    await userPreferenceBox.put(key, value);
  }

  String getStringValue({
    required String key,
  }) {
    return userPreferenceBox.get(key, defaultValue:'');
  }

  Future<void> insertBoolValue({
    required String key,
    required bool value,
  }) async {
    await userPreferenceBox.put(key, value);
  }

  bool getBoolValue({
    required String key,
  }) {
    return userPreferenceBox.get(key, defaultValue: false);
  }

  Future<void> insertIntValue({
    required String key,
    required int value,
  }) async {
    await userPreferenceBox.put(key, value);
  }

  int getIntValue({
    required String key,
    int defaultValue = 0,
  }) {
    return userPreferenceBox.get(key, defaultValue: defaultValue);
  }

  Future<void> insertDoubleValue({
    required String key,
    required double value,
  }) async {
    await userPreferenceBox.put(key, value);
  }

  double getDoubleValue({
    required String key,
    double defaultValue = 0,
  }) {
    return userPreferenceBox.get(key, defaultValue: defaultValue);
  }
}
