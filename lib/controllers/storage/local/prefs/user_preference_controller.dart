import 'package:shared_preferences/shared_preferences.dart';

import '../../../../models/auth/User.dart';

class UserPreferenceController {
  static final UserPreferenceController _instance =
      UserPreferenceController._internal();

  late SharedPreferences _sharedPreferences;

  UserPreferenceController._internal();

  factory UserPreferenceController() {
    return _instance;
  }

  Future<void> initSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> saveUserInformation({
    required User user,
    required String token,
    required String email,
    String? password,
  }) async {
    // _sharedPreferences.setString('token', autoGenerated.accessToken);
    // _sharedPreferences.setString('token_type', autoGenerated.tokenType);
    // _sharedPreferences.setString('expires_in', autoGenerated.expiresIn);
    _sharedPreferences.setBool('logged_in', true);

    _sharedPreferences.setString('id', user.id.toString());
    _sharedPreferences.setString('email', email);
    _sharedPreferences.setString('password', password.toString());
    _sharedPreferences.setString('name', user.name);
    _sharedPreferences.setString('mobile', user.mobile ?? '');
    _sharedPreferences.setString('avatar', user.avatar ?? '');
    _sharedPreferences.setString('dob', user.dob ?? '');
    _sharedPreferences.setString('gender', user.gender ?? '');
    _sharedPreferences.setString('token', token);
  }

  Future<void> updateUserInformation({
    required User user,
  }) async {
    _sharedPreferences.setString('id', user.id.toString());
    _sharedPreferences.setString('name', user.name);
    _sharedPreferences.setString('mobile', user.mobile ?? '');
    _sharedPreferences.setString('avatar', user.avatar ?? '');
    _sharedPreferences.setString('dob', user.dob ?? '');
    _sharedPreferences.setString('gender', user.gender ?? '');
  }

  Future<void> saveUserCountry({
    required String country,
  }) async {
    _sharedPreferences.setString('address', country);
  }

  Future<void> updatePassword(String password) async {
    _sharedPreferences.setString('password', password);
  }

  String get password => _sharedPreferences.getString('password') ?? '';

  User get userInformation {
    // Autogenerated autoGenerated = Autogenerated();
    User user = User();
    // autoGenerated.accessToken = _sharedPreferences.getString('token')!;
    // autoGenerated.tokenType = _sharedPreferences.getString('token_type')!;
    // autoGenerated.expiresIn = _sharedPreferences.getString('expires_in')!;
    user.id = int.parse(_sharedPreferences.getString('id') ?? '0');
    user.email = _sharedPreferences.getString('email') ?? '';
    user.name = _sharedPreferences.getString('name') ?? '';
    user.mobile = _sharedPreferences.getString('mobile') ?? '';
    user.avatar = _sharedPreferences.getString('avatar') ?? '';
    user.dob = _sharedPreferences.getString('dob') ?? '';
    user.gender = _sharedPreferences.getString('gender') ?? '';

    return user;
  }

  bool get loggedIn => _sharedPreferences.getBool('logged_in') ?? false;

  Future<void> saveToken({required String token}) async {
    _sharedPreferences.setString('token', token);
  }

  String get token => _sharedPreferences.getString('token') ?? 'null';

  Future<bool> logout() async {
    bool status = await _sharedPreferences.clear();
    return status;
  }
}
