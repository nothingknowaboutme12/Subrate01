import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:subrate/controllers/storage/local/prefs/user_preference_controller.dart';
import 'package:subrate/controllers/storage/network/api/api_settings.dart';
import 'package:subrate/models/Task/task.dart';
import 'package:http/http.dart' as http;
import '../authorization_header.dart';
import 'lesson.dart';
import 'lesson_api.dart';

class LessonTaskGetxController extends GetxController {
  LessonTaskGetxController(this.id);
  String id;
  RxList<Task> remaininglessonTask = <Task>[].obs;
  RxList<Task> completedLessonTask = <Task>[].obs;
  @override
  void onInit() {
    read();
    update();
    refresh();
    super.onInit();
  }

  static LessonTaskGetxController get to => Get.find();
  Future<void> read() async {
    await readRLessonMissions();
    await readCLessonMissions();
  }

  readRLessonMissions() async {
    remaininglessonTask.value =
        await LessonApiController().getlessontask(id, ApiSettings.lessonTaskR);
    remaininglessonTask.refresh();
  }

  readCLessonMissions() async {
    completedLessonTask.value =
        await LessonApiController().getlessontask(id, ApiSettings.lessonTaskC);
    completedLessonTask.refresh();
  }
}

class Filter {
  String? id;
  Filter(this.id);
  Task? filtertask;

  filtertaskData() async {
    print("Here is id of lesson$id");
    String token = UserPreferenceController().token;
    var response = await http.get(
        Uri.parse("https://www.subrate.app/api/missions/single/$id"),
        headers: {
          HttpHeaders.authorizationHeader:
              AuthorizationHeader(token: token).token,
        });
    print("Here is response${response.statusCode}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      var decodedData = await jsonDecode(response.body);
      print("Decoded Data ${decodedData}");

      Map<String, dynamic> jsonMap = await decodedData['data'];
      Map<String, dynamic> jsonMap2 = await jsonMap['mission'];
      filtertask = Task.fromJson(jsonMap2);
      print("Json map 2 data ${jsonMap2}");
      print("filter task value is here${filtertask?.steps}");
      print("task json file ${Task.fromJson(jsonMap2).steps}");
    }
    // List<Task> task =
  }
}
