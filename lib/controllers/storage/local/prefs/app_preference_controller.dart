import 'package:shared_preferences/shared_preferences.dart';

class AppPreferenceController {
  static final AppPreferenceController _instance =
      AppPreferenceController._internal();

  late SharedPreferences _sharedPreferences;

  AppPreferenceController._internal();

  factory AppPreferenceController() {
    return _instance;
  }

  Future<void> initSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> saveFirstOpenApp() async {
    _sharedPreferences.setBool('first_time', false);
  }

  bool get firstTime => _sharedPreferences.getBool('first_time') ?? true;

  Future<bool> clearApp() async {
    return _sharedPreferences.clear();
  }
}
