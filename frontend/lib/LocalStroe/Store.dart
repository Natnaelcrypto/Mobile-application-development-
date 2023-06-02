import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static String get username => _prefs.getString('username') ?? '';

  static set username(String value) {
    _prefs.setString('username', value);
  }
  static String get firstname => _prefs.getString('firstname') ?? '';

  static set firstname(String value) {
    _prefs.setString('firstname', value);
  }

static String get lastname => _prefs.getString('lastname') ?? '';

  static set lastname(String value) {
    _prefs.setString('lastname', value);
  }


  static String get userId => _prefs.getString('userId') ?? "";

  static set userId(String value) {
    _prefs.setString('userId', value);
  }

  static String get farmName => _prefs.getString('farmName') ?? "";

  static set farmName(String value) {
    _prefs.setString('farmName', value);
  }

  static String get role => _prefs.getString('role') ?? "";

  static set role(String value) {
    _prefs.setString('role', value);
  }

  static String get access => _prefs.getString('access') ?? "";

  static set access(String value) {
    _prefs.setString('access', value);
  }
}
