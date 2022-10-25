import 'package:shared_preferences/shared_preferences.dart';

class AppSettingsPrefs {
  static final AppSettingsPrefs _instance = AppSettingsPrefs._internal();

  late SharedPreferences _sharedPreferences;

  AppSettingsPrefs._internal();

  factory AppSettingsPrefs() {
    return _instance;
  }

  Future<void> initPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> saveLanguage({required String language}) async {
    await _sharedPreferences.setString('lang_code', language);
  }

  String get langCode =>_sharedPreferences.getString('lang_code') ?? 'en';
}
