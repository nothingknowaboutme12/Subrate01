import 'dart:convert';

import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

import '../../controllers/storage/local/prefs/user_preference_controller.dart';
import '../../controllers/storage/network/api/api_settings.dart';
import 'base_response.dart';

class SocialAuth {
  static Future<void> GoogleSignin() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    // GoogleSignIn().signOut();
    print(googleUser);
    http.Response response =
        await http.post(Uri.parse(ApiSettings.google), body: {
      "name": googleUser!.displayName,
      "email": googleUser.email,
      "google_id": googleUser.id,
    });

    if (response.statusCode == 200) {
      var jsonresponse = await jsonDecode(response.body);
      BaseResponse baseResponse = BaseResponse.fromJson(jsonresponse);
      UserPreferenceController().saveUserInformation(
        user: baseResponse.data.user,
        token: baseResponse.data.token,
        email: googleUser.email,
      );
    } else {
      return;
    }
  }

  static Future<void> FacebookSignin() async {
    final LoginResult loginResult = await FacebookAuth.instance.login(
      permissions: ["public_profile", "email"],
      loginBehavior: LoginBehavior.dialogOnly,
    );
    final fbauth = await FacebookAuth.instance.getUserData();
    final tken = loginResult.accessToken!.token;
    print(tken);
    print(fbauth);
    http.Response response =
        await http.post(Uri.parse(ApiSettings.facebook), body: {
      "name": fbauth['name'],
      "email": fbauth['email'],
      "facebook_id": fbauth['id'],
    });
    print("response$response");
    if (response.statusCode == 200 || response.statusCode == 201) {
      var jsonresponse = jsonDecode(response.body);
      BaseResponse baseResponse = BaseResponse.fromJson(jsonresponse);
      print("Show base response$jsonresponse");
      UserPreferenceController().saveUserInformation(
        user: baseResponse.data.user,
        token: baseResponse.data.token,
        email: fbauth['email'],
      );
    } else {
      return;
    }
  }
}
