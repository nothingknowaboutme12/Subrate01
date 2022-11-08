import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:subrate/controllers/storage/local/prefs/user_preference_controller.dart';
import 'package:subrate/controllers/storage/network/api/api_settings.dart';
import 'package:http/http.dart' as http;
import '../Task/task.dart';
import '../authorization_header.dart';
import 'lesson.dart';

class LessonApiController {
  String token = UserPreferenceController().token;
  Lesson? emptylesson;
  printvalue() {}

  Future<List<Lesson>> getlesson() async {
    var response = await responseApiGetLesson(ApiSettings.lesson);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return getjsonDataLesson(response.body);
    }
    return [];
  }

  Future<Lesson> gettasklesson(String id) async {
    Lesson lesson;
    var response = await http.post(Uri.parse(ApiSettings.tasktolesson), body: {
      "mission_id": id,
    }, headers: {
      HttpHeaders.authorizationHeader: AuthorizationHeader(token: token).token,
    });
    print("here is lesson task");
    print(response);
    print(response.statusCode);
    if (await response.statusCode == 200 || response.statusCode == 201) {
      var dataJsonArray = await jsonDecode(response.body);
      print(dataJsonArray);
      print(dataJsonArray["data"]['id']);
      lesson = Lesson.fromJson(dataJsonArray['data']);
      return lesson;
    }
    return emptylesson as Lesson;
  }

  List<Lesson> getjsonDataLesson(String body) {
    var dataJsonArray = jsonDecode(body);

    Lesson lesson;
    List<Lesson> lessons = [];
    for (var item in dataJsonArray['data']) {
      lesson = Lesson.fromJson(item);
      lessons.add(lesson);
    }
    return lessons;
  }

  Future<http.Response> responseApiGetLesson(String url) async {
    var link = Uri.parse(url);
    return await http.get(link, headers: {
      HttpHeaders.authorizationHeader: AuthorizationHeader(token: token).token,
    });
  }

  Future<List<Task>> getlessontask(String id, String url) async {
    var response = await http.post(Uri.parse(url), body: {
      "lesson_id": id,
    }, headers: {
      HttpHeaders.authorizationHeader: AuthorizationHeader(token: token).token,
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      return getJsonDataTaskMission(response.body);
    }
    return [];
  }

  List<Task> getJsonDataTaskMission(String body) {
    var dataJsonArray = jsonDecode(body);
    Map<String, dynamic> jsonMap = dataJsonArray['data'];
    // rate = double.parse(jsonMap['group_rate'] ?? '1');
    Map<String, dynamic> jsonMap2 = jsonMap['missions'];
    late Task mission;
    List<Task> missions = [];
    for (var item in jsonMap2['data']) {
      mission = Task.fromJson(item);
      missions.add(mission);
    }
    return missions;
  }
}
