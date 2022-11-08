import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:subrate/controllers/storage/network/api/api_settings.dart';
import 'package:http/http.dart' as http;

import '../../controllers/storage/local/prefs/user_preference_controller.dart';
import '../authorization_header.dart';
import 'package:http/http.dart' as http;

class Notification {
  int? id;
  String? title;
  String? description;

  Notification.fromjson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
  }
}

String token = UserPreferenceController().token;
// class NotificationApi {
//   String token = UserPreferenceController().token;
//   getResponsenotification(String body) {
//     List<Notification> notifications = [];
//     Notification notifi;
//     var jsonResponse = jsonDecode(body);
//     Notification.fromjson(jsonResponse);
//     for (var item in jsonResponse['data']) {
//       notifi = Notification.fromjson(item);
//       notifications.add(notifi);
//     }
//     return notifications;
//   }
//
//   Future<List<Notification>> getnotification() async {
//     var response =
//         await http.get(Uri.parse(ApiSettings.notification), headers: {
//       HttpHeaders.authorizationHeader: AuthorizationHeader(token: token).token,
//     });
//     if (response.statusCode == 200 || response.statusCode == 201) {
//       print(getResponsenotification(response.body));
//       return await getResponsenotification(response.body);
//     }
//     return [];
//   }
// }

class NotificationApi {
  static Future<void> fcmtokenUpdate(String fcmtoken) async {
    var response = await http.post(
      Uri.parse(
        ApiSettings.tokenupdate,
      ),
      body: {
        "fcm_token": fcmtoken,
      },
      headers: {
        HttpHeaders.authorizationHeader:
            AuthorizationHeader(token: token).token,
      },
    );
  }
}
