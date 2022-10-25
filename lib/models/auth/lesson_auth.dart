import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:subrate/controllers/storage/network/api/api_settings.dart';
import 'package:subrate/models/auth/base_response.dart';

import '../../controllers/storage/local/prefs/user_preference_controller.dart';
import '../authorization_header.dart';

class LessonAuth {
  String token = UserPreferenceController().token;

  getlesson() async {
    print("Token: $token");
    // try {
    http.Response response =
        await http.get(Uri.parse(ApiSettings.lesson), headers: {
      HttpHeaders.authorizationHeader: AuthorizationHeader(token: token).token,
    });
    if (response.statusCode == 200) {
      var decodeData = await jsonDecode(response.body);
      print(response.body);
      BaseResponse baseResponse = BaseResponse.fromJson(decodeData);
      print(baseResponse);
    } else {
      print(response.statusCode);
      return;
    }
    // } catch (e) {
    //   print("lesson error$e");
    // }
  }
}
