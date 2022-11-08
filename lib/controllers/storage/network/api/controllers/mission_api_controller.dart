import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:subrate/models/Lesson/lesson.dart';

import '../../../../../models/Task/points.dart';
import '../../../../../models/Task/task.dart';
import '../../../../../models/Task/task_count.dart';
import '../../../../../models/authorization_header.dart';

import '../../../local/prefs/user_preference_controller.dart';
import '../api_settings.dart';

class MissionApiController {
  String token = UserPreferenceController().token;
  late double rate = 1.0;

  Future<List<Task>> getMissions() async {
    var response = await responseApiGetMissions(ApiSettings.missionURL);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return getJsonDataMissions(response.body);
    }
    return [];
  }

  Future<List<Task>> getRemainingMissions() async {
    var response =
        await responseApiGetMissions(ApiSettings.remainingMissionURL);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return getJsonDataMissions(response.body);
    }
    return [];
  }

  Future<List<Task>> getCompletedMissions() async {
    var response =
        await responseApiGetMissions(ApiSettings.completedMissionURL);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return getJsonDataMissions(response.body);
    }
    return [];
  }

  Future<http.Response> responseApiGetMissions(String url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String onToken = prefs.getString("token") ?? 'null';
    var link = Uri.parse(url);
    return await http.get(link, headers: {
      HttpHeaders.authorizationHeader:
          AuthorizationHeader(token: onToken).token,
    });
  }

  List<Task> getJsonDataMissions(String body) {
    var dataJsonArray = jsonDecode(body);
    Map<String, dynamic> jsonMap = dataJsonArray['data'];
    rate = double.parse(jsonMap['group_rate'] ?? '1');
    Map<String, dynamic> jsonMap2 = jsonMap['missions'];
    late Task mission;
    List<Task> missions = [];
    for (var item in jsonMap2['data']) {
      mission = Task.fromJson(item);
      missions.add(mission);
    }
    return missions;
  }

  Future<int> getPoints() async {
    String token = UserPreferenceController().token;
    var url = Uri.parse(ApiSettings.pointsUrl);

    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: AuthorizationHeader(token: token).token,
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      var jsonResponse = jsonDecode(response.body);
      Points points = Points.fromJson(jsonResponse['data']);
      return points.total;
    } else {
      return 0;
    }
  }

  Future<TaskCount> getMissionsCount() async {
    String token = UserPreferenceController().token;
    var url = Uri.parse(ApiSettings.missionsCountUrl);

    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: AuthorizationHeader(token: token).token,
    });
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      TaskCount missionsCount = TaskCount.fromJson(jsonResponse['data']);
      return missionsCount;
    } else {
      return TaskCount();
    }
  }

  Future<String> getMoney() async {
    String token = UserPreferenceController().token;
    Uri url = Uri.parse(ApiSettings.moneyUrl);

    http.Response response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: AuthorizationHeader(token: token).token,
    });

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      String money = jsonResponse['data'];
      return money;
    } else {
      return '0';
    }
  }

  double getRate() {
    return rate;
  }
}
