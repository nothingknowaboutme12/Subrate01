import 'package:get/get.dart';
import 'package:subrate/controllers/storage/network/api/api_settings.dart';
import 'package:subrate/models/Task/task.dart';

import 'lesson_api.dart';

class LessonTaskGetxController extends GetxController {
  LessonTaskGetxController(this.id);
  String id;
  RxList<Task> remaininglessonTask = <Task>[].obs;
  RxList<Task> completedLessonTask = <Task>[].obs;
  @override
  void onInit() {
    read();
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
  }

  readCLessonMissions() async {
    completedLessonTask.value =
        await LessonApiController().getlessontask(id, ApiSettings.lessonTaskC);
  }
}
