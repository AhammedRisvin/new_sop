import 'package:shared_preferences/shared_preferences.dart';

class AppPref {
  static const _userToken = "accessToken";
  static const _isSignedIn = 'isSignedIn';
  static const String _fcmToken = 'fcmToken';
  static const String _country = 'country';
  static const _isDrkModeOn = 'isDarkModeOn';

  static late SharedPreferences _preference;

  static Future<void> init() async {
    _preference = await SharedPreferences.getInstance();
  }

  void reloadPreference() async {
    await _preference.reload();
  }

  Future<void> clear() async {
    await _preference.clear();
  }

  //User Token _userProfileId
  static String get userToken => _preference.getString(_userToken) ?? "";
  static set userToken(String value) =>
      _preference.setString(_userToken, value);

  //User Is SignedIn or not
  static bool get isSignedIn => _preference.getBool(_isSignedIn) ?? false;
  static set isSignedIn(bool value) => _preference.setBool(_isSignedIn, value);

  //FCM Token
  static String get fcmToken => _preference.getString(_fcmToken) ?? "";
  static set fcmToken(String value) => _preference.setString(_fcmToken, value);
  //country
  static String get country => _preference.getString(_country) ?? "";
  static set country(String value) => _preference.setString(_country, value);

  //User enabled Dark mode or not
  static bool get isDrkModeOn => _preference.getBool(_isDrkModeOn) ?? false;
  static set isDrkModeOn(bool value) =>
      _preference.setBool(_isDrkModeOn, value);
}