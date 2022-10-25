import 'package:get/get.dart';
import 'package:subrate/models/Lesson/lesson.dart';
import 'package:subrate/models/Lesson/lesson_api.dart';

import '../../models/Task/task.dart';
import '../../models/Task/task_count.dart';
import '../storage/network/api/controllers/mission_api_controller.dart';

class MissionGetXController extends GetxController {
  RxList<Task> missions = <Task>[].obs;
  RxList<Lesson> lessons = <Lesson>[].obs;
  RxList<Task> remainingMissions = <Task>[].obs;

  RxList<Task> completedMissions = <Task>[].obs;
  RxInt points = 0.obs;
  Rx<TaskCount> missionsCount = TaskCount().obs;
  RxString money = '0'.obs;
  RxDouble rate = 1.0.obs;

  final MissionApiController _missionApiController = MissionApiController();

  static MissionGetXController get to => Get.find();

  @override
  void onInit() {
    read();
    super.onInit();
  }

  Future<void> read() async {
    readRemainingMissions();
    readCompletedMissions();
    readlesson();
    getPoints();
    getMissionCounts();
    getMoney();
    getRate();
    refresh();
    update();
  }

  Future<void> readlesson() async {
    lessons.value = await LessonApiController().getlesson();
  }

  Future<void> readRemainingMissions() async {
    remainingMissions.value =
        await _missionApiController.getRemainingMissions() as List<Task>;
  }

  Future<void> readCompletedMissions() async {
    completedMissions.value =
        await _missionApiController.getCompletedMissions() as List<Task>;
  }

  Future<void> getPoints() async {
    points.value = await _missionApiController.getPoints();
  }

  Future<void> getMissionCounts() async {
    missionsCount.value = await _missionApiController.getMissionsCount();
  }

  Future<void> getMoney() async {
    money.value = await _missionApiController.getMoney();
  }

  void getRate() {
    rate.value = _missionApiController.getRate();
  }
}