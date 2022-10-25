import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../../../core/utils/helpers.dart';
import '../../../../../models/auth/User.dart';
import '../../../../../models/auth/base_response.dart';
import '../../../../../models/authorization_header.dart';
import '../../../local/prefs/user_preference_controller.dart';
import '../api_settings.dart';

typedef UpdateProfile = void Function({
  required bool status,
  User? user,
  required String message,
});

class AuthApiController with Helpers {
  String token = UserPreferenceController().token;

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    var url = Uri.parse(ApiSettings.login);
    var response = await http.post(url, body: {
      'email': email,
      'password': password,
    });

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      BaseResponse baseResponse = BaseResponse.fromJson(jsonResponse);
      UserPreferenceController().saveUserInformation(
        user: baseResponse.data.user,
        email: email,
        password: password,
        token: baseResponse.data.token,
      );
      return true;
    } else if (response.statusCode == 400) {
    } else {}
    return false;
  }

  Future<bool> logout(BuildContext context) async {
    Uri url = Uri.parse(ApiSettings.logout);

    var response = await http.post(url, headers: {
      HttpHeaders.authorizationHeader: AuthorizationHeader(token: token).token,
      HttpHeaders.acceptHeader: 'application/json',
    });

    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 401) {
      await UserPreferenceController().logout();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> register({
    required String name,
    required String email,
    required String password,
    required String image,
    required String phone,
    required String date,
    required BuildContext context,
  }) async {
    var url = Uri.parse(ApiSettings.register);
    var response = await http.post(url, body: {
      'name': name,
      'email': email,
      'password': password,
      'user_image': image,
      'dob': date,
      'phone': phone,
    });
    if (response.statusCode == 201 || response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 422) {
      showSnackBar(
          context: context,
          message: jsonDecode(response.body)['errors'][0],
          error: true);
    } else {
      showSnackBar(
          context: context,
          message: 'Something went wrong, please try again',
          error: true);
    }
    return false;
  }

  Future<void> updateProfile({
    required String? filePath,
    required UpdateProfile updateProfile,
    required User user,
  }) async {
    var url = Uri.parse(ApiSettings.updateProfile);
    var request = http.MultipartRequest('POST', url);
    if (filePath != null) {
      var file = await http.MultipartFile.fromPath('avatar', filePath);
      request.files.add(file);
    }
    request.headers[HttpHeaders.authorizationHeader] =
        AuthorizationHeader(token: token).token;

    request.fields['name'] = user.name.toString();
    request.fields['email'] = user.email;
    request.fields['mobile'] = user.mobile ?? '';
    request.fields['dob'] = user.dob ?? '';
    request.fields['gender'] = user.gender ?? '';

    var response = await request.send();

    response.stream.transform(utf8.decoder).listen((String event) {
      print(response.statusCode);
      if (response.statusCode == 201 || response.statusCode == 200) {
        var jsonResponse = jsonDecode(event);
        User user = User.fromJson(jsonResponse['data']);
        updateProfile(
          status: true,
          user: user,
          message: jsonResponse['description'],
        );
        UserPreferenceController().updateUserInformation(user: user);
      } else {
        updateProfile(
          status: false,
          message: 'Something went wrong!, try again',
        );
      }
    });
  }

  Future<bool> changePassword({
    required String? oldPassword,
    required String? newPassword,
    required BuildContext context,
  }) async {
    var url = Uri.parse(ApiSettings.changePassword);
    var response = await http.post(url, body: {
      'old_password': oldPassword,
      'password': newPassword,
      'password_confirmation': newPassword,
    }, headers: {
      HttpHeaders.authorizationHeader: AuthorizationHeader(token: token).token,
    });
    if (response.statusCode == 201 || response.statusCode == 200) {
      return true;
    }

    return false;
  }
}
