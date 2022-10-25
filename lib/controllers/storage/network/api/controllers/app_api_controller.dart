import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../../../models/authorization_header.dart';
import '../../../../../models/gift.dart';
import '../../../local/prefs/user_preference_controller.dart';
import '../api_settings.dart';

class AppApiController {
  String token = UserPreferenceController().token;

  Future<int> getRank() async {
    var url = Uri.parse(ApiSettings.rankUrl);
    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: AuthorizationHeader(token: token).token,
    });
    if (response.statusCode == 200) {
      var dataJsonArray = jsonDecode(response.body);
      return dataJsonArray['data'];
    }
    return 0;
  }

  Future<List<Gift>> getGifts() async {
    var url = Uri.parse(ApiSettings.giftsUrl);
    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: AuthorizationHeader(token: token).token,
    });
    if (response.statusCode == 200) {
      var dataJsonArray = jsonDecode(response.body);
      var giftsJson = dataJsonArray['data'];
      late Gift gift;
      List<Gift> gifts = [];
      for (var item in giftsJson['data']) {
        gift = Gift.fromJson(item);
        gifts.add(gift);
      }
      return gifts;
    }
    return [];
  }
}
